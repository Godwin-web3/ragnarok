#!/usr/bin/env bash
# Ragnarok mechanical phase gate.
#
# Inspects the on-disk research/ artifacts (never conversation history, tool-call
# history, or the agent's self-report) and determines which phases are actually
# COMPLETE, and whether the hypothesis-generation gate (Phase 5+) is OPEN.
#
# Usage:
#   scripts/gate_check.sh [research-dir]              print the gate report
#   scripts/gate_check.sh [research-dir] --write       also snapshot it to
#                                                       <research-dir>/phase-state.md
#
# Exit codes:
#   0  gate OPEN  (Phases 0-3 all COMPLETE) and no violation detected
#   1  gate LOCKED (at least one of Phases 0-3 incomplete)
#   3  GATE VIOLATION detected (hypothesis/exploit work started while LOCKED),
#      regardless of the lock state above
set -u
# Deliberately no -e/pipefail: this script runs many greps that legitimately
# report "no match" (an unfilled field, an absent section) as part of normal
# control flow rather than as a script error.

RESEARCH="research"
WRITE=0
for arg in "$@"; do
  if [ "$arg" = "--write" ]; then
    WRITE=1
  else
    RESEARCH="$arg"
  fi
done

# ---------------------------------------------------------------------------
# helpers
# ---------------------------------------------------------------------------

# Extract the body of the first markdown heading (level 1-3) whose text matches
# an extended-regex keyword pattern, up to (not including) the next heading.
section_body() {
  local file="$1" re="$2"
  [ -f "$file" ] || return 0
  # NOTE: portable to mawk (no IGNORECASE support) — lowercase the line
  # ourselves and require callers to pass lowercase patterns.
  awk -v re="$re" '
    BEGIN { found=0 }
    /^#{1,3}[^#]/ {
      if (found==1) { exit }
      if (tolower($0) ~ re) { found=1; next }
      next
    }
    found==1 { print }
  ' "$file"
}

# True (0) if the given text is blank, too short, or still contains an unfilled
# template placeholder token.
is_placeholder_or_blank() {
  local text="$1" trimmed
  trimmed="$(printf '%s' "$text" | tr -d '[:space:]')"
  [ -z "$trimmed" ] && return 0
  if printf '%s' "$text" | grep -qiE '<fill|<name>|_e\.g\.|0x\.\.\.|\bTBD\b|<-- ?set one|<statement of|<concise|<underlying|placeholder'; then
    return 0
  fi
  [ "${#trimmed}" -lt 15 ] && return 0
  return 1
}

# True (0) if a file is missing or has no non-whitespace content at all.
is_empty_file() {
  local file="$1"
  [ -f "$file" ] || return 0
  [ -z "$(tr -d '[:space:]' < "$file")" ] && return 0
  return 1
}

field_value() {
  local file="$1" label_re="$2"
  grep -iE "$label_re" "$file" 2>/dev/null | head -1 | sed -E 's/^[^:]*:[[:space:]]*//'
}

# True (0) if a scope.md enum field is still an unresolved "A / B / C" list
# (or blank) rather than a single chosen value.
is_unresolved_enum() {
  local val="$1" trimmed
  trimmed="$(printf '%s' "$val" | tr -d '[:space:]')"
  [ -z "$trimmed" ] && return 0
  printf '%s' "$val" | grep -q '/' && return 0
  return 1
}

# ---------------------------------------------------------------------------
# Phase 0 — scope.md
# ---------------------------------------------------------------------------
check_phase0() {
  REASONS=()
  local f="$RESEARCH/scope.md"
  if is_empty_file "$f"; then
    REASONS+=("scope.md: MISSING/EMPTY")
    return
  fi
  local auth env live repo
  auth="$(field_value "$f" '^-?\s*Authorization status:')"
  env="$(field_value "$f" '^-?\s*Research environment:')"
  live="$(field_value "$f" '^-?\s*Live exploitation permitted:')"
  repo="$(field_value "$f" '^-?\s*Repository:')"
  is_unresolved_enum "$auth" && REASONS+=("scope.md: Authorization status not resolved to a single value")
  is_unresolved_enum "$env"  && REASONS+=("scope.md: Research environment not classified to a single value")
  is_unresolved_enum "$live" && REASONS+=("scope.md: Live exploitation permitted not resolved to YES/NO")
  [ -z "$(printf '%s' "$repo" | tr -d '[:space:]')" ] && REASONS+=("scope.md: Target repository not recorded")
}

# ---------------------------------------------------------------------------
# Phase 1 — architecture.md, asset-flows.md, trust-boundaries.md
# ---------------------------------------------------------------------------
check_reconstruction_file() {
  local file="$1"; shift
  local -a headers=("$@")
  local -a missing=()
  if is_empty_file "$file"; then
    missing+=("$(basename "$file"): EMPTY")
    printf '%s\n' "${missing[@]}"
    return
  fi
  local h body
  for h in "${headers[@]}"; do
    body="$(section_body "$file" "$h")"
    if is_placeholder_or_blank "$body"; then
      missing+=("$(basename "$file"): missing/placeholder section matching /$h/")
    fi
  done
  printf '%s\n' "${missing[@]}"
}

check_phase1() {
  REASONS=()
  local out

  out="$(check_reconstruction_file "$RESEARCH/architecture.md" \
    'contract|component' \
    'entry.?point' \
    'privileg|upgrade' \
    'external.*(dependen|call)|callback|reentran' \
    'actor.*entry|trace')"
  [ -n "$out" ] && while IFS= read -r line; do [ -n "$line" ] && REASONS+=("$line"); done <<< "$out"

  out="$(check_reconstruction_file "$RESEARCH/asset-flows.md" \
    'assets? in' \
    'assets? out' \
    'custody|accounting' \
    'mint|burn|claim|redemption' \
    'attacker.?controlled')"
  [ -n "$out" ] && while IFS= read -r line; do [ -n "$line" ] && REASONS+=("$line"); done <<< "$out"

  out="$(check_reconstruction_file "$RESEARCH/trust-boundaries.md" \
    'actor|authorit' \
    'entry point.*check|check.*state write|modifier' \
    'emergency|recovery|upgrade|migration')"
  [ -n "$out" ] && while IFS= read -r line; do [ -n "$line" ] && REASONS+=("$line"); done <<< "$out"
}

# ---------------------------------------------------------------------------
# Phase 2 — deployment.md
# ---------------------------------------------------------------------------
check_phase2() {
  REASONS=()
  local f="$RESEARCH/deployment.md"
  if is_empty_file "$f"; then
    REASONS+=("deployment.md: MISSING/EMPTY")
    return
  fi
  # a real table row: "<something> | <something> | ACTIVE|INACTIVE|UNKNOWN|UNVERIFIED"
  # that is not the literal template example row.
  if ! grep -qiE '^\s*[^|<]+\|[^|]+\|\s*(ACTIVE|INACTIVE|UNKNOWN|UNVERIFIED)\s*$' "$f"; then
    REASONS+=("deployment.md: no recorded capability rows (still template/empty table)")
  fi
  local body
  body="$(section_body "$f" 'missing.*(evidence|unavailable)')"
  if is_placeholder_or_blank "$body"; then
    REASONS+=("deployment.md: 'Missing / unavailable evidence' section not filled in")
  fi
}

# ---------------------------------------------------------------------------
# Phase 3 — invariants.md
# ---------------------------------------------------------------------------
check_phase3() {
  REASONS=()
  local f="$RESEARCH/invariants.md"
  if is_empty_file "$f"; then
    REASONS+=("invariants.md: MISSING/EMPTY")
    return
  fi
  if grep -qiE '^##+ *no (applicable|meaningful) invariants' "$f"; then
    local body
    body="$(section_body "$f" 'no (applicable|meaningful) invariants')"
    if is_placeholder_or_blank "$body"; then
      REASONS+=("invariants.md: 'No applicable invariants' rationale is present but empty/placeholder")
    fi
    return
  fi
  if ! grep -qE '^##+ *INV-[0-9]+' "$f"; then
    REASONS+=("invariants.md: no INV-### entries and no explicit no-invariants rationale")
    return
  fi
  # Every INV-### entry must have its required fields filled.
  local ids
  ids="$(grep -oE '^##+ *INV-[0-9]+' "$f" | grep -oE 'INV-[0-9]+' | sort -u)"
  local id body
  for id in $ids; do
    body="$(section_body "$f" "${id,,}")"
    for field in 'Definition:' 'WHERE CREATED:' 'WHERE ASSUMED:' 'WHERE CAN CHANGE:' 'WHO CAN INFLUENCE:' 'ACTUALLY ENFORCED\?:' 'Enforcement point:'; do
      local val
      val="$(printf '%s\n' "$body" | grep -iE "^-?\s*${field}" | head -1 | sed -E 's/^[^:]*:[[:space:]]*//')"
      if [ -z "$(printf '%s' "$val" | tr -d '[:space:]')" ]; then
        REASONS+=("invariants.md: $id missing field '$field'")
      fi
    done
  done
}

# ---------------------------------------------------------------------------
# Leads / hypothesis-gate violation detection
# ---------------------------------------------------------------------------
count_pending_leads() {
  local f="$RESEARCH/leads.md"
  [ -f "$f" ] || { echo 0; return; }
  grep -oE '^L-[0-9]+ *\|.*\|[^|]*$' "$f" 2>/dev/null | awk -F'|' '
    { s=$NF; gsub(/^[ \t]+|[ \t]+$/,"",s); if (toupper(s)=="OBSERVED" || toupper(s)=="QUEUED") c++ }
    END { print c+0 }
  '
}

detect_violation() {
  VIOLATIONS=()
  local hf="$RESEARCH/hypotheses.md"
  if [ -f "$hf" ]; then
    while IFS= read -r row; do
      [ -z "$row" ] && continue
      if ! printf '%s' "$row" | grep -q '_e\.g\. oracle price is trusted as fresh_'; then
        VIOLATIONS+=("hypotheses.md contains a non-placeholder entry: ${row:0:80}")
      fi
    done < <(grep -E '^H-[0-9]+ *\|' "$hf" 2>/dev/null || true)
  fi
  local ed="$RESEARCH/experiments"
  if [ -d "$ed" ] && [ -n "$(find "$ed" -type f 2>/dev/null)" ]; then
    VIOLATIONS+=("research/experiments/ contains files — exploit/falsification work has started")
  fi
}

# ---------------------------------------------------------------------------
# run all checks
# ---------------------------------------------------------------------------
check_phase0; P0_REASONS=("${REASONS[@]}")
check_phase1; P1_REASONS=("${REASONS[@]}")
check_phase2; P2_REASONS=("${REASONS[@]}")
check_phase3; P3_REASONS=("${REASONS[@]}")
detect_violation

PENDING_LEADS="$(count_pending_leads)"

phase_status() {
  local -n reasons_ref="$1"
  [ "${#reasons_ref[@]}" -eq 0 ] && echo "COMPLETE" || echo "INCOMPLETE"
}

P0_STATUS="$(phase_status P0_REASONS)"
P1_STATUS="$(phase_status P1_REASONS)"
P2_STATUS="$(phase_status P2_REASONS)"
P3_STATUS="$(phase_status P3_REASONS)"

FIRST_BLOCKER=""
[ "$P0_STATUS" = "INCOMPLETE" ] && FIRST_BLOCKER="0"
[ -z "$FIRST_BLOCKER" ] && [ "$P1_STATUS" = "INCOMPLETE" ] && FIRST_BLOCKER="1"
[ -z "$FIRST_BLOCKER" ] && [ "$P2_STATUS" = "INCOMPLETE" ] && FIRST_BLOCKER="2"
[ -z "$FIRST_BLOCKER" ] && [ "$P3_STATUS" = "INCOMPLETE" ] && FIRST_BLOCKER="3"

if [ -z "$FIRST_BLOCKER" ]; then
  GATE="OPEN"
else
  GATE="LOCKED"
fi

# Violations (hypothesis/exploit work started ahead of the gate) only matter
# while the gate is actually LOCKED. Once the gate legitimately opens, the
# same content is expected work, not a violation.
if [ "$GATE" = "OPEN" ]; then
  VIOLATIONS=()
fi

# ---------------------------------------------------------------------------
# render report
# ---------------------------------------------------------------------------
render_phase_line() {
  local num="$1" status="$2"
  local -n reasons_ref="$3"
  if [ -n "$FIRST_BLOCKER" ] && [ "$num" -gt "$FIRST_BLOCKER" ]; then
    echo "Phase $num: BLOCKED (upstream Phase $FIRST_BLOCKER incomplete)"
    return
  fi
  echo "Phase $num: $status"
  local r
  for r in "${reasons_ref[@]}"; do
    echo "  $r"
  done
}

build_report() {
  echo "PHASE GATE CHECK"
  echo "generated: $(date -u +%Y-%m-%dT%H:%M:%SZ) (source of truth: research-state files, not conversation history)"
  echo
  render_phase_line 0 "$P0_STATUS" P0_REASONS
  render_phase_line 1 "$P1_STATUS" P1_REASONS
  render_phase_line 2 "$P2_STATUS" P2_REASONS
  render_phase_line 3 "$P3_STATUS" P3_REASONS
  echo
  echo "Hypothesis Generation Gate (Phase 5+): $GATE"
  if [ "${#VIOLATIONS[@]}" -gt 0 ]; then
    echo
    echo "GATE VIOLATIONS DETECTED:"
    local v
    for v in "${VIOLATIONS[@]}"; do
      echo "  - $v"
    done
  fi
  echo
  echo "Action:"
  if [ "$GATE" = "OPEN" ]; then
    echo "GATE OPEN. Hypothesis generation, exploit construction, fuzzing, and deep"
    echo "falsification of a specific lead are permitted."
  else
    echo "DO NOT ADVANCE to hypothesis generation, exploit construction, fuzzing, or"
    echo "deep falsification of a specific lead."
    echo "Return to Phase $FIRST_BLOCKER reconstruction."
  fi
  if [ "${#VIOLATIONS[@]}" -gt 0 ]; then
    echo "GATE VIOLATION: work occurred ahead of the gate. Revert/queue it and return"
    echo "to reconstruction before continuing."
  fi
  echo "Pending leads preserved: $PENDING_LEADS"
}

REPORT="$(build_report)"
printf '%s\n' "$REPORT"

if [ "$WRITE" -eq 1 ]; then
  {
    echo "<!-- AUTO-GENERATED by scripts/gate_check.sh — do not hand-edit. Re-run the script to refresh. -->"
    echo "# Phase State Manifest"
    echo
    printf '%s\n' "$REPORT"
  } > "$RESEARCH/phase-state.md"
fi

if [ "${#VIOLATIONS[@]}" -gt 0 ]; then
  exit 3
fi
[ "$GATE" = "OPEN" ] && exit 0 || exit 1
