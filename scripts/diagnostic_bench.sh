#!/usr/bin/env bash
# Reproducible local diagnostic runner for Ragnarok.
# This runs repository regression tests; it does NOT claim to run blind protocol hunts.
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

UTC_NOW="$(date -u +%Y%m%dT%H%M%SZ)"
RUN_ID="${RAGNAROK_RUN_ID:-$UTC_NOW}"
OUT_DIR="${RAGNAROK_OUT_DIR:-$ROOT/diagnostics/runs/$RUN_ID}"
mkdir -p "$OUT_DIR/logs"

if [[ -e "$OUT_DIR/summary.md" || -e "$OUT_DIR/summary.json" ]]; then
  echo "Refusing to overwrite existing run: $OUT_DIR" >&2
  exit 2
fi

START_EPOCH="$(date -u +%s)"
START_ISO="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
COMMIT="$(git rev-parse HEAD 2>/dev/null || echo UNKNOWN)"
BRANCH="$(git branch --show-current 2>/dev/null || echo UNKNOWN)"
VERSION="$(tr -d '[:space:]' < VERSION 2>/dev/null || echo UNKNOWN)"
PYTHON_VERSION="$(python3 --version 2>&1 || true)"
BASH_VERSION_STR="$BASH_VERSION"
FOUNDRY_VERSION="$(forge --version 2>&1 | head -n 1 || echo unavailable)"
SOLC_VERSION="$(solc --version 2>&1 | grep -m1 'Version:' || echo unavailable)"

declare -a NAMES=()
declare -a STATUSES=()
declare -a CODES=()
declare -a DURATIONS=()

run_test() {
  local name="$1"; shift
  local logfile="$OUT_DIR/logs/$name.log"
  local before after code
  before="$(date -u +%s)"
  echo "RUN  $name"
  set +e
  "$@" >"$logfile" 2>&1
  code=$?
  set -e
  after="$(date -u +%s)"
  NAMES+=("$name")
  CODES+=("$code")
  DURATIONS+=("$((after-before))")
  if [[ "$code" -eq 0 ]]; then
    STATUSES+=("PASS")
    echo "PASS $name ($((after-before))s)"
  else
    STATUSES+=("FAIL")
    echo "FAIL $name (exit $code; see $logfile)"
    tail -n 30 "$logfile" || true
  fi
}

# Existing shell regression suites. Explicit list makes the benchmark stable
# and prevents an unrelated new script from silently entering the score.
for test in \
  scripts/tests/gate_check_v2_test.sh \
  scripts/tests/gate_check_v3_test.sh \
  scripts/tests/gate_check_v35_test.sh \
  scripts/tests/gate_check_v5_test.sh \
  scripts/tests/harness_init_v5_test.sh \
  scripts/tests/report_gate_test.sh; do
  if [[ -x "$test" || -f "$test" ]]; then
    run_test "$(basename "$test" .sh)" bash "$test"
  else
    echo "Missing required test: $test" >&2
    exit 3
  fi
done

if [[ -f scripts/tests/shape_knowledge_test.py ]]; then
  run_test "shape_knowledge_test" python3 scripts/tests/shape_knowledge_test.py
else
  echo "Missing required test: scripts/tests/shape_knowledge_test.py" >&2
  exit 3
fi

END_EPOCH="$(date -u +%s)"
END_ISO="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
TOTAL="$((END_EPOCH-START_EPOCH))"
PASS_COUNT=0
FAIL_COUNT=0
for status in "${STATUSES[@]}"; do
  if [[ "$status" == "PASS" ]]; then PASS_COUNT=$((PASS_COUNT+1)); else FAIL_COUNT=$((FAIL_COUNT+1)); fi
done

{
  echo "# Ragnarok Diagnostic Run — $RUN_ID"
  echo
  echo "- Started (UTC): $START_ISO"
  echo "- Finished (UTC): $END_ISO"
  echo "- Duration: ${TOTAL}s"
  echo "- Commit: \`$COMMIT\`"
  echo "- Branch: \`$BRANCH\`"
  echo "- VERSION: \`$VERSION\`"
  echo "- Python: $PYTHON_VERSION"
  echo "- Bash: $BASH_VERSION_STR"
  echo "- Foundry: $FOUNDRY_VERSION"
  echo "- Solidity compiler: $SOLC_VERSION"
  echo
  echo "## Repository regression suite"
  echo
  echo "| Test | Status | Exit | Duration (s) | Log |"
  echo "|---|---:|---:|---:|---|"
  for i in "${!NAMES[@]}"; do
    echo "| ${NAMES[$i]} | ${STATUSES[$i]} | ${CODES[$i]} | ${DURATIONS[$i]} | [log](logs/${NAMES[$i]}.log) |"
  done
  echo
  echo "**Regression summary: $PASS_COUNT passed, $FAIL_COUNT failed.**"
  echo
  echo "## Protocol discovery benchmark"
  echo
  echo "| Target | Status | Reason |"
  echo "|---|---|---|"
  for target in dvd-unstoppable dvd-side-entrance dvd-truster dvd-puppet; do
    echo "| $target | BLOCKED | No blind discovery-agent adapter is wired into this runner; existing local mechanism replicas are not a measured discovery pass. |"
  done
  echo
  echo "No target-level discovery, patched-control, independent-reproduction, or V6.1-vs-V6.5 score is claimed by this run."
} > "$OUT_DIR/summary.md"

python3 - "$OUT_DIR/summary.json" "$RUN_ID" "$START_ISO" "$END_ISO" "$COMMIT" "$BRANCH" "$VERSION" "$PASS_COUNT" "$FAIL_COUNT" "${NAMES[*]}" "${STATUSES[*]}" "${CODES[*]}" "${DURATIONS[*]}" <<'PY'
import json, sys
from pathlib import Path
(path, run_id, started, finished, commit, branch, version,
 passed, failed, names, statuses, codes, durations) = sys.argv[1:]
data = {
    "run_id": run_id, "started_utc": started, "finished_utc": finished,
    "commit": commit, "branch": branch, "version": version,
    "regression_tests": {
        "passed": int(passed), "failed": int(failed),
        "results": [
            {
                "test": name, "status": status,
                "exit_code": int(code), "duration_seconds": int(duration),
                "log": f"logs/{name}.log"
            }
            for name, status, code, duration in zip(
                names.split(), statuses.split(), codes.split(), durations.split()
            )
        ]
    },
    "protocol_discovery": {
        "status": "BLOCKED",
        "reason": "No blind discovery-agent adapter is wired into this runner."
    }
}
# The Markdown table and per-test logs remain the canonical detailed record.
Path(path).write_text(json.dumps(data, indent=2) + "\n", encoding="utf-8")
PY

echo
echo "Run artifact: $OUT_DIR"
echo "Regression tests: $PASS_COUNT passed, $FAIL_COUNT failed"
echo "Protocol discovery: BLOCKED (not run)"
[[ "$FAIL_COUNT" -eq 0 ]]
