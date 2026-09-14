#!/usr/bin/env bash
# Ragnarok report gate (V5).
#
# A finding may appear in research/report.md only when the ledger says
# CONFIRMED, the effect is RUNTIME_VERIFIED, the impact is
# ECONOMICALLY_VERIFIED EXTRACT (not GRIEF/PRIVILEGED), harsher economic
# checks are recorded (flashloan/capital, same-tx atomicity, exit liquidity,
# MEV/keeper race), a falsification attempt is recorded, and a harness file
# exists. Otherwise report.md must be the honest empty report.
#
# Usage:
#   scripts/report_gate.sh [research-dir]
#   scripts/report_gate.sh [research-dir] --write
#
# Exit codes:
#   0  PASS
#   1  FAIL
set -u

RESEARCH="research"
WRITE=0
for arg in "$@"; do
  if [ "$arg" = "--write" ]; then
    WRITE=1
  else
    RESEARCH="$arg"
  fi
done

REASONS=()

is_empty_file() {
  local file="$1"
  [ -f "$file" ] || return 0
  [ -z "$(tr -d '[:space:]' < "$file")" ] && return 0
  return 1
}

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
  if printf '%s' "$text" | grep -qiE '<fill|<name>|_e\.g\.|\bTBD\b|<concise|<underlying|placeholder'; then
    return 0
  fi
  [ "${#trimmed}" -lt 15 ] && return 0
  return 1
}

REPORT="$RESEARCH/report.md"
HYPO="$RESEARCH/hypotheses.md"
SURV="$RESEARCH/survivors.md"
EXPS="$RESEARCH/experiments"

if is_empty_file "$REPORT"; then
  REASONS+=("report.md: MISSING/EMPTY")
fi

HONEST_EMPTY=0
if [ -f "$REPORT" ] && grep -qiE 'No confirmed finding meets the Ragnarok evidence standard' "$REPORT"; then
  HONEST_EMPTY=1
fi

HAS_FINDING_SECTIONS=0
if [ -f "$REPORT" ] && grep -qiE '^##+ *(Title|Summary|Root Cause|Proof of Concept)' "$REPORT"; then
  HAS_FINDING_SECTIONS=1
fi

if [ "$HONEST_EMPTY" -eq 1 ] && [ "$HAS_FINDING_SECTIONS" -eq 0 ]; then
  :
elif [ "$HONEST_EMPTY" -eq 1 ] && [ "$HAS_FINDING_SECTIONS" -eq 1 ]; then
  REASONS+=("report.md: empty-report sentence and finding sections both present — pick one")
else
  if [ "$HAS_FINDING_SECTIONS" -eq 0 ]; then
    REASONS+=("report.md: neither honest-empty sentence nor finding sections")
  fi

  if grep -qiE 'Status:[[:space:]]*(SURVIVOR|INCONCLUSIVE)' "$REPORT" 2>/dev/null; then
    REASONS+=("report.md: SURVIVOR / INCONCLUSIVE is not a reportable finding")
  fi

  CONFIRMED_ROWS=""
  if [ -f "$HYPO" ]; then
    CONFIRMED_ROWS="$(grep -E '^H-[0-9]+ *\|' "$HYPO" | grep -iE '\|[[:space:]]*CONFIRMED[[:space:]]*$' || true)"
  fi
  if [ -z "$CONFIRMED_ROWS" ]; then
    REASONS+=("hypotheses.md: no CONFIRMED row — report.md cannot carry a finding")
  else
    if ! printf '%s' "$CONFIRMED_ROWS" | grep -q 'RUNTIME_VERIFIED'; then
      REASONS+=("hypotheses.md: CONFIRMED row is missing RUNTIME_VERIFIED")
    fi
    if ! printf '%s' "$CONFIRMED_ROWS" | grep -q 'ECONOMICALLY_VERIFIED'; then
      REASONS+=("hypotheses.md: CONFIRMED row is missing ECONOMICALLY_VERIFIED")
    fi
  fi

  if [ ! -d "$EXPS" ] || [ -z "$(find "$EXPS" -type f 2>/dev/null)" ]; then
    REASONS+=("research/experiments/: empty — RUNTIME_VERIFIED requires a harness file")
  fi

  for sec in 'falsification' 'economic impact' 'proof of concept'; do
    body="$(section_body "$REPORT" "$sec")"
    if is_placeholder_or_blank "$body"; then
      REASONS+=("report.md: '$sec' section missing or placeholder")
    fi
  done

  econ="$(section_body "$REPORT" 'economic impact')"
  class=""
  class="$(printf '%s\n' "$econ" "${CONFIRMED_ROWS:-}" | grep -iE 'CLASS:' | head -1 | sed -E 's/^[^:]*:[[:space:]]*//' || true)"
  if printf '%s' "$class" | grep -qiE 'GRIEF'; then
    REASONS+=("CLASS: GRIEF cannot enter the permissionless CONFIRMED queue — bucket it, do not report")
  fi
  if printf '%s' "$class" | grep -qiE 'PRIVILEGED'; then
    REASONS+=("CLASS: PRIVILEGED cannot enter the permissionless CONFIRMED queue — bucket PRIVILEGED RISK")
  fi
  if [ -z "$(printf '%s' "$class" | tr -d '[:space:]')" ]; then
    if printf '%s\n' "$econ" "${CONFIRMED_ROWS:-}" | grep -qiE '\bGRIEF\b'; then
      REASONS+=("finding tagged GRIEF cannot be CONFIRMED permissionless")
    elif printf '%s\n' "$econ" "${CONFIRMED_ROWS:-}" | grep -qiE '\bPRIVILEGED\b'; then
      REASONS+=("finding tagged PRIVILEGED cannot be CONFIRMED permissionless")
    else
      REASONS+=("CONFIRMED requires CLASS: EXTRACT (GRIEF/PRIVILEGED stay out of this queue)")
    fi
  elif ! printf '%s' "$class" | grep -qiE 'EXTRACT'; then
    REASONS+=("CONFIRMED CLASS must be EXTRACT — GRIEF/PRIVILEGED are not the permissionless queue")
  fi

  missing_econ=""
  printf '%s\n' "$econ" | grep -qiE 'FLASHLOAN|CAPITAL' || missing_econ="${missing_econ} flashloanability/capital"
  printf '%s\n' "$econ" | grep -qiE 'ATOMIC|SAME-?TX|SAME TX' || missing_econ="${missing_econ} same-tx atomicity"
  printf '%s\n' "$econ" | grep -qiE 'EXIT LIQUIDITY|LIQUIDITY' || missing_econ="${missing_econ} exit liquidity"
  printf '%s\n' "$econ" | grep -qiE 'MEV|KEEPER' || missing_econ="${missing_econ} MEV/keeper race"
  if [ -n "$missing_econ" ]; then
    REASONS+=("report.md Economic Impact missing harsher checks:$missing_econ")
  fi
fi

if [ "${#REASONS[@]}" -eq 0 ]; then
  STATUS="PASS"
else
  STATUS="FAIL"
fi

build_report() {
  echo "REPORT GATE CHECK"
  echo "generated: $(date -u +%Y-%m-%dT%H:%M:%SZ) (source of truth: research-state files, not conversation history)"
  echo
  echo "Report gate: $STATUS"
  local r
  for r in "${REASONS[@]}"; do
    echo "  $r"
  done
  echo
  echo "Action:"
  if [ "$STATUS" = "PASS" ]; then
    echo "REPORT GATE PASS. report.md matches the evidence standard."
  else
    echo "DO NOT SHIP report.md as a finding. Return to the ledger / harness / falsification."
    echo "CONFIRMED still requires RUNTIME_VERIFIED + ECONOMICALLY_VERIFIED + kill attempt."
    echo "GRIEF and PRIVILEGED stay out of this queue. If nothing is CONFIRMED, honest empty."
  fi
}

OUT="$(build_report)"
printf '%s\n' "$OUT"

if [ "$WRITE" -eq 1 ]; then
  {
    echo "<!-- AUTO-GENERATED by scripts/report_gate.sh — do not hand-edit. -->"
    echo "# Report Gate Manifest"
    echo
    printf '%s\n' "$OUT"
  } > "$RESEARCH/report-state.md"
fi

[ "$STATUS" = "PASS" ] && exit 0 || exit 1
