#!/usr/bin/env bash
# V5 harness_init: CX witness + invariant scaffolds, refuse soft witness.
set -u
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INIT="$HERE/../harness_init.sh"
PASS=0
FAIL=0
WORKROOT="$(mktemp -d)"
cleanup() { rm -rf "$WORKROOT"; }
trap cleanup EXIT

assert_exit() {
  local desc="$1" expected="$2" actual="$3"
  if [ "$expected" = "$actual" ]; then
    echo "ok   - $desc (exit $actual)"
    PASS=$((PASS+1))
  else
    echo "FAIL - $desc (expected exit $expected, got $actual)"
    FAIL=$((FAIL+1))
  fi
}
assert_contains() {
  local desc="$1" haystack="$2" needle="$3"
  if printf '%s' "$haystack" | grep -qF -- "$needle"; then
    echo "ok   - $desc"
    PASS=$((PASS+1))
  else
    echo "FAIL - $desc (expected: $needle)"
    FAIL=$((FAIL+1))
  fi
}

seed() {
  local t="$1"
  mkdir -p "$t/research"
  cat > "$t/research/contradictions.md" <<'EOF'
# Contradictions
## CX-001 — double settle
- STATE: ticket exists AND token already burned AND collateral sent twice
- PAIRING: Queue ↔ Collateral
- SEQUENCE: requestRedeem -> settle -> settle
- WITNESS: collateral.balanceOf(attacker) > burned * rate
- MONETIZATION: attacker collateral balance increases on the second settle
- HANDLERS: requestRedeem, settle
- STATUS: INVENTED
## CX-002 — prose
- STATE: the queue looks wrong
- PAIRING: Queue ↔ Collateral
- WITNESS: the queue looks inconsistent after settle
- STATUS: INVENTED
EOF
}

echo "=== harness_init v5 ==="

d="$(mktemp -d "$WORKROOT/f.XXXXXX")"
seed "$d"
out="$(bash "$INIT" "$d")"; ec=$?
assert_exit "H1 campaign harness writes" 0 "$ec"
[ -f "$d/research/experiments/Campaign.t.sol" ] || { echo "FAIL - H1 missing Campaign.t.sol"; FAIL=$((FAIL+1)); }
[ -f "$d/research/experiments/Campaign.t.sol" ] && { echo "ok   - H1 Campaign.t.sol exists"; PASS=$((PASS+1)); }

out="$(bash "$INIT" "$d")"; ec=$?
assert_exit "H2 idempotent campaign" 0 "$ec"
assert_contains "H2 exists" "$out" "exists"

out="$(bash "$INIT" "$d" --cx CX-001)"; ec=$?
assert_exit "H3 witness scaffold from assertable CX" 0 "$ec"
wf="$d/research/experiments/CX001_witness.t.sol"
if [ -f "$wf" ]; then
  echo "ok   - H3 wrote CX001_witness.t.sol"
  PASS=$((PASS+1))
else
  echo "FAIL - H3 missing witness file"
  FAIL=$((FAIL+1))
fi
body="$(cat "$wf" 2>/dev/null || true)"
assert_contains "H3 asserts STATE" "$body" "impossible_state_holds"
assert_contains "H3 asserts monetization" "$body" "monetization_moves_value"
assert_contains "H3 assertGt value moved" "$body" "assertGt"

out="$(bash "$INIT" "$d" --cx CX-002)"; ec=$?
assert_exit "H4 prose witness is refused" 2 "$ec"
assert_contains "H4 refuse" "$out" "REFUSE"
[ ! -f "$d/research/experiments/CX002_witness.t.sol" ]
if [ ! -f "$d/research/experiments/CX002_witness.t.sol" ]; then
  echo "ok   - H4 no harness for prose WITNESS"
  PASS=$((PASS+1))
else
  echo "FAIL - H4 wrote a harness for a soft card"
  FAIL=$((FAIL+1))
fi

out="$(bash "$INIT" "$d" --invariant CX-001)"; ec=$?
assert_exit "H5 invariant scaffold" 0 "$ec"
inv="$d/research/experiments/CX001_invariant.t.sol"
body="$(cat "$inv" 2>/dev/null || true)"
assert_contains "H5 invariant_ prefix" "$body" "invariant_CX001_state_unreachable"
assert_contains "H5 handler from HANDLERS" "$body" "handler_settle"
assert_contains "H5 handler requestRedeem" "$body" "handler_requestRedeem"

echo "==============================="
echo "Passed: $PASS  Failed: $FAIL"
[ "$FAIL" -eq 0 ]
