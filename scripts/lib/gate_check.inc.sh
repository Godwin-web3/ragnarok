#!/usr/bin/env bash
# Sourced by scripts/gate_check.sh — do not run directly.

section_body() {
  local file="$1" re="$2"
  [ -f "$file" ] || return 0
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

is_unresolved_enum() {
  local val="$1" trimmed
  trimmed="$(printf '%s' "$val" | tr -d '[:space:]')"
  [ -z "$trimmed" ] && return 0
  printf '%s' "$val" | grep -q '/' && return 0
  return 1
}

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

  local now="$RESEARCH/NOW.md"
  if is_empty_file "$now"; then
    REASONS+=("NOW.md: MISSING/EMPTY — hot card is required")
  else
    local phase
    phase="$(field_value "$now" '^-?\s*Phase:')"
    if [ -z "$(printf '%s' "$phase" | tr -d '[:space:]')" ]; then
      REASONS+=("NOW.md: Phase not recorded")
    fi
  fi
}

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
    'component graph|contract|component' \
    'entry.?point' \
    'privileg|upgrade' \
    'external.*(dependen|call)|callback|reentran' \
    'actor.*entry|trace')"
  [ -n "$out" ] && while IFS= read -r line; do [ -n "$line" ] && REASONS+=("$line"); done <<< "$out"

  if [ -f "$RESEARCH/architecture.md" ]; then
    if ! grep -qiE 'component[[:space:]]*\|' "$RESEARCH/architecture.md"; then
      REASONS+=("architecture.md: missing component graph table (Component | Type | Address | ...)")
    elif [ "$(grep -cE '^\s*[^|<][^|]*\|[^|]+\|[^|]+' "$RESEARCH/architecture.md" || true)" -lt 3 ]; then
      REASONS+=("architecture.md: component graph has no real rows")
    fi
  fi

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
    'emergency|recovery|upgrade|migration' \
    'composition|pairing|cross-?contract')"
  [ -n "$out" ] && while IFS= read -r line; do [ -n "$line" ] && REASONS+=("$line"); done <<< "$out"
}

check_phase2() {
  REASONS=()
  local f="$RESEARCH/deployment.md"
  if is_empty_file "$f"; then
    REASONS+=("deployment.md: MISSING/EMPTY")
    return
  fi
  if ! grep -qiE '^\s*[^|<]+\|[^|]+\|\s*(ACTIVE|INACTIVE|UNKNOWN|UNVERIFIED)\s*$' "$f"; then
    REASONS+=("deployment.md: no recorded capability rows (still template/empty table)")
  fi
  local body
  body="$(section_body "$f" 'missing.*(evidence|unavailable)')"
  if is_placeholder_or_blank "$body"; then
    REASONS+=("deployment.md: 'Missing / unavailable evidence' section not filled in")
  fi
  if [ -f "$RESEARCH/architecture.md" ]; then
    local addrs addr
    addrs="$(grep -oE '0x[0-9a-fA-F]{3,}' "$f" | sort -u || true)"
    for addr in $addrs; do
      [ -z "$addr" ] && continue
      printf '%s' "$addr" | grep -qiE '^0x\.+$' && continue
      if ! grep -qiF "$addr" "$RESEARCH/architecture.md"; then
        REASONS+=("deployment.md: address $addr not present in architecture.md component graph — grow the map")
      fi
    done
  fi
}

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

check_phase4() {
  REASONS=()
  local f="$RESEARCH/assumptions.md"
  if is_empty_file "$f"; then
    REASONS+=("assumptions.md: MISSING/EMPTY")
    return
  fi
  if grep -qiE '^##+ *no (applicable|meaningful) assumptions' "$f"; then
    local body
    body="$(section_body "$f" 'no (applicable|meaningful) assumptions')"
    if is_placeholder_or_blank "$body"; then
      REASONS+=("assumptions.md: 'No applicable assumptions' rationale is present but empty/placeholder")
    fi
    return
  fi
  if ! grep -qE '^##+ *ASM-[0-9]+' "$f"; then
    REASONS+=("assumptions.md: no ASM-### entries and no explicit no-assumptions rationale")
    return
  fi
  local ids
  ids="$(grep -oE '^##+ *ASM-[0-9]+' "$f" | grep -oE 'ASM-[0-9]+' | sort -u)"
  local id body
  for id in $ids; do
    body="$(section_body "$f" "${id,,}")"
    for field in 'TRUSTED BY:' 'INFLUENCEABLE BY:' 'FAILURE CONDITION:' 'PROVENANCE:'; do
      local val
      val="$(printf '%s\n' "$body" | grep -iE "^-?\s*${field}" | head -1 | sed -E 's/^[^:]*:[[:space:]]*//')"
      if [ -z "$(printf '%s' "$val" | tr -d '[:space:]')" ]; then
        REASONS+=("assumptions.md: $id missing field '$field'")
      fi
    done
    local prov
    prov="$(printf '%s\n' "$body" | grep -iE '^-?\s*PROVENANCE:' | head -1 | sed -E 's/^[^:]*:[[:space:]]*//')"
    if [ -n "$(printf '%s' "$prov" | tr -d '[:space:]')" ]; then
      if ! printf '%s' "$prov" | grep -qiE 'SOURCE_VERIFIED|DEPLOYMENT_VERIFIED|RUNTIME_VERIFIED|ECONOMICALLY_VERIFIED|UNVERIFIED'; then
        REASONS+=("assumptions.md: $id provenance is not an evidence level")
      fi
    fi
  done
}

count_pending_leads() {
  local f="$RESEARCH/leads.md"
  [ -f "$f" ] || { echo 0; return; }
  grep -oE '^L-[0-9]+ *\|.*\|[^|]*$' "$f" 2>/dev/null | awk -F'|' '
    { s=$NF; gsub(/^[ \t]+|[ \t]+$/,"",s); if (toupper(s)=="OBSERVED" || toupper(s)=="QUEUED") c++ }
    END { print c+0 }
  '
}

check_thin_map() {
  REASONS=()
  local f="$RESEARCH/architecture.md"
  if is_empty_file "$f"; then
    REASONS+=("architecture.md: MISSING/EMPTY — thin map needs a component graph")
    return
  fi
  if ! grep -qiE 'component[[:space:]]*\|' "$f"; then
    REASONS+=("architecture.md: missing component graph table")
  elif [ "$(grep -cE '^\s*[^|<][^|]*\|[^|]+\|[^|]+' "$f" || true)" -lt 3 ]; then
    REASONS+=("architecture.md: component graph has no real rows")
  fi
  local traces flows bounds
  traces="$(section_body "$f" 'actor.*entry|trace')"
  flows="$RESEARCH/asset-flows.md"
  bounds="$RESEARCH/trust-boundaries.md"
  local has_trace=0
  if ! is_placeholder_or_blank "$traces"; then
    has_trace=1
  fi
  if [ -f "$flows" ] && ! is_empty_file "$flows"; then
    local bin
    bin="$(section_body "$flows" 'assets? in')"
    if ! is_placeholder_or_blank "$bin"; then
      has_trace=1
    fi
  fi
  if [ -f "$bounds" ] && ! is_empty_file "$bounds"; then
    local ct
    ct="$(section_body "$bounds" 'composition|pairing|cross-?contract|actor|entry point')"
    if ! is_placeholder_or_blank "$ct"; then
      has_trace=1
    fi
  fi
  if [ "$has_trace" -eq 0 ]; then
    REASONS+=("thin map: need one actor-trace or one asset/composition trace")
  fi
}

detect_violation() {
  VIOLATIONS=()
  [ "${SYNTHESIS:-LOCKED}" = "OPEN" ] && return
  local hf="$RESEARCH/hypotheses.md"
  if [ -f "$hf" ]; then
    local rows row
    rows="$(grep -E '^H-[0-9]+ *\|' "$hf" 2>/dev/null || true)"
    while IFS= read -r row; do
      [ -z "$row" ] && continue
      if ! printf '%s' "$row" | grep -q '_e\.g\. oracle price is trusted as fresh_'; then
        VIOLATIONS+=("hypotheses.md contains a non-placeholder entry: ${row:0:80}")
      fi
    done <<< "$rows"
  fi
  local cf="$RESEARCH/contradictions.md"
  if [ -f "$cf" ] && grep -qE '^##+ *CX-[0-9]+' "$cf"; then
    VIOLATIONS+=("contradictions.md contains CX-### cards before a thin map exists")
  fi
  local ed="$RESEARCH/experiments"
  if [ -d "$ed" ] && [ -n "$(find "$ed" -type f 2>/dev/null)" ]; then
    VIOLATIONS+=("research/experiments/ contains files — exploit/falsification work has started")
  fi
}
