#!/usr/bin/env bash
# Regression tests for scripts/report_gate.sh
set -u

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GATE="$HERE/../report_gate.sh"

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
    echo "FAIL - $desc (expected output to contain: $needle)"
    FAIL=$((FAIL+1))
  fi
}

new_fixture() {
  mktemp -d "$WORKROOT/fixture.XXXXXX"
}

seed_honest_empty() {
  local r="$1/research"
  mkdir -p "$r/experiments"
  cat > "$r/report.md" <<'EOF'
# Ragnarok Finding Report

**No confirmed finding meets the Ragnarok evidence standard.**
EOF
  cat > "$r/hypotheses.md" <<'EOF'
# Hypothesis Ledger
H-001 | ASM-001 | mint | — | — | — | — | — | SOURCE_VERIFIED | P2 | eth_call | KILLED
EOF
}

seed_confirmed() {
  local r="$1/research"
  mkdir -p "$r/experiments"
  echo "// harness" > "$r/experiments/Campaign.t.sol"
  cat > "$r/hypotheses.md" <<'EOF'
# Hypothesis Ledger
H-001 | ASM-001 | mint | stale oracle | donate+mint | shares cheap | drain | experiments/Campaign.t.sol | RUNTIME_VERIFIED; ECONOMICALLY_VERIFIED | P1 | eth_call | CONFIRMED
EOF
  cat > "$r/report.md" <<'EOF'
# Ragnarok Finding Report

## Title
Stale-oracle mint after donation extracts victim deposits

## Summary
An attacker donates underlying, mints one share, and redeems victim deposits.

## Root Cause
Share conversion trusts a spot oracle with no heartbeat and a 1-wei virtual offset.

## Proof of Concept
research/experiments/Campaign.t.sol:testH001_scenario reproduces the drain on a pinned fork.

## Economic Impact
Attacker profit 99 tokens on a 100 token victim deposit; capital 1 wei + donation; repeatable.
- FLASHLOANABLE / CAPITAL: 1 wei mint plus donation inventory; same-tx flashloan yes
- SAME-TX ATOMICITY: donate+mint+redeem in one tx
- EXIT LIQUIDITY: vault holds 100 tokens, withdraw pays the token
- MEV / KEEPER RACE: permissionless, no keeper race
- CLASS: EXTRACT

## Falsification Attempts
Checked larger virtual offset (absent), onlyOwner donate (raw transfer works), heartbeat on mint (absent). Finding survived.
EOF
}

t1() {
  local d; d="$(new_fixture)"
  seed_honest_empty "$d"
  out="$(bash "$GATE" "$d/research")"; ec=$?
  assert_exit "R1 honest empty report passes" 0 "$ec"
  assert_contains "R1 says PASS" "$out" "Report gate: PASS"
}

t2() {
  local d; d="$(new_fixture)"
  mkdir -p "$d/research"
  : > "$d/research/report.md"
  out="$(bash "$GATE" "$d/research")"; ec=$?
  assert_exit "R2 empty report.md fails" 1 "$ec"
}

t3() {
  local d; d="$(new_fixture)"
  seed_confirmed "$d"
  cat > "$d/research/hypotheses.md" <<'EOF'
H-001 | ASM-001 | mint | — | — | — | — | — | RUNTIME_VERIFIED | P1 | eth_call | SURVIVOR
EOF
  out="$(bash "$GATE" "$d/research")"; ec=$?
  assert_exit "R3 finding without CONFIRMED row fails" 1 "$ec"
  assert_contains "R3 names missing CONFIRMED" "$out" "no CONFIRMED row"
}

t4() {
  local d; d="$(new_fixture)"
  seed_confirmed "$d"
  cat > "$d/research/hypotheses.md" <<'EOF'
H-001 | ASM-001 | mint | — | — | — | — | — | RUNTIME_VERIFIED | P1 | eth_call | CONFIRMED
EOF
  out="$(bash "$GATE" "$d/research")"; ec=$?
  assert_exit "R4 CONFIRMED without ECONOMICALLY_VERIFIED fails" 1 "$ec"
  assert_contains "R4 names economic bar" "$out" "ECONOMICALLY_VERIFIED"
}

t5() {
  local d; d="$(new_fixture)"
  seed_confirmed "$d"
  rm -rf "$d/research/experiments"
  out="$(bash "$GATE" "$d/research")"; ec=$?
  assert_exit "R5 CONFIRMED without harness files fails" 1 "$ec"
}

t6() {
  local d; d="$(new_fixture)"
  seed_confirmed "$d"
  out="$(bash "$GATE" "$d/research")"; ec=$?
  assert_exit "R6 full CONFIRMED finding passes" 0 "$ec"
}

t7() {
  local d; d="$(new_fixture)"
  seed_confirmed "$d"
  printf '\n> Status: SURVIVOR\n' >> "$d/research/report.md"
  out="$(bash "$GATE" "$d/research")"; ec=$?
  assert_exit "R7 SURVIVOR status in report fails" 1 "$ec"
}

t8() {
  local d; d="$(new_fixture)"
  seed_confirmed "$d"
  cat > "$d/research/report.md" <<'EOF'
# Ragnarok Finding Report

## Title
Harvest poke depresses share price

## Summary
Anyone can poke harvest and mark a loss onto depositors.

## Root Cause
Harvest books loss without transferring value to the caller.

## Proof of Concept
research/experiments/Campaign.t.sol reproduces the share-price drop.

## Economic Impact
Victim loses 3%. Attacker profit is zero.
- FLASHLOANABLE / CAPITAL: 0
- SAME-TX ATOMICITY: grief is atomic
- EXIT LIQUIDITY: none for attacker
- MEV / KEEPER RACE: keepers also poke
- CLASS: GRIEF

## Falsification Attempts
Checked mint-during-loss (paused). Grief remained grief.
EOF
  out="$(bash "$GATE" "$d/research")"; ec=$?
  assert_exit "R8 CONFIRMED+GRIEF fails" 1 "$ec"
  assert_contains "R8 names GRIEF" "$out" "GRIEF"
}

t9() {
  local d; d="$(new_fixture)"
  seed_confirmed "$d"
  cat > "$d/research/report.md" <<'EOF'
# Ragnarok Finding Report

## Title
Stale-oracle mint after donation extracts victim deposits

## Summary
An attacker donates underlying, mints one share, and redeems victim deposits.

## Root Cause
Share conversion trusts a spot oracle with no heartbeat and a 1-wei virtual offset.

## Proof of Concept
research/experiments/Campaign.t.sol:testH001_scenario reproduces the drain on a pinned fork.

## Economic Impact
Attacker profit 99 tokens on a 100 token victim deposit.

## Falsification Attempts
Checked larger virtual offset (absent). Finding survived.
EOF
  out="$(bash "$GATE" "$d/research")"; ec=$?
  assert_exit "R9 CONFIRMED without harsher economics fails" 1 "$ec"
  assert_contains "R9 names CLASS" "$out" "CLASS: EXTRACT"
}

t10() {
  local d; d="$(new_fixture)"
  seed_confirmed "$d"
  out="$(bash "$GATE" "$d/research")"; ec=$?
  assert_exit "R10 EXTRACT with full economic checklist still passes" 0 "$ec"
}

echo "=== report_gate.sh regression suite ==="
t1; t2; t3; t4; t5; t6; t7; t8; t9; t10
echo "==============================="
echo "Passed: $PASS  Failed: $FAIL"
[ "$FAIL" -eq 0 ]
