#!/usr/bin/env bash
# Regression tests for scripts/gate_check.sh — the mechanical Ragnarok phase gate.
#
# No external test framework required. Each test builds a throwaway research/
# fixture under a temp directory, runs gate_check.sh against it, and asserts
# on its exit code and/or report text.
#
# Usage: scripts/tests/gate_check_test.sh
set -u

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GATE="$HERE/../gate_check.sh"

PASS=0
FAIL=0

WORKROOT="$(mktemp -d)"
cleanup() { rm -rf "$WORKROOT"; }
trap cleanup EXIT

# --- assertion helpers ------------------------------------------------------

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
  local dir
  dir="$(mktemp -d "$WORKROOT/fixture.XXXXXX")"
  echo "$dir"
}

# A fully-complete Phase 0-3 fixture, reused as a base by several tests.
seed_complete_reconstruction() {
  local r="$1/research"
  mkdir -p "$r/experiments"

  cat > "$r/scope.md" <<'EOF'
# Scope
## Authorization & research environment (PHASE 0 — REQUIRED)
- Authorization status: NONE
- Research environment: READ_ONLY_PRODUCTION
- Live exploitation permitted: NO

## Target
- Repository: github.com/example/protocol
EOF

  cat > "$r/architecture.md" <<'EOF'
## Contracts & Components
Vault.sol, Controller.sol, proxy at 0xAAA.

## Entry Points
deposit(), withdraw(), liquidate() are the external entry points.

## Privileged Functions & Upgrade Paths
setController is onlyOwner. Proxy admin can upgrade the implementation.

## External Dependencies & Callback Surfaces
Relies on an external price oracle and ERC20 token callbacks.

## Actor → Entry → Check → State → Effect Traces
User -> deposit() -> onlyIfNotPaused -> _mintShares() -> balances updated.
EOF

  cat > "$r/asset-flows.md" <<'EOF'
## Assets In
Users deposit the underlying ERC20 token via deposit().

## Assets Out
Users withdraw underlying token via withdraw(); redeemed pro-rata.

## Custody & Accounting Transitions
Vault custodies underlying; internal share ledger tracks ownership.

## Mint / Burn / Claim / Redemption Paths
Shares minted on deposit, burned on withdraw.

## Attacker-Controlled Inputs Affecting Value
Deposit amount and timing of deposit relative to price updates.
EOF

  cat > "$r/trust-boundaries.md" <<'EOF'
## Actors & Authorities
Users, Owner (multisig), Keeper bot, Oracle.

## Actor → Entry Point → Check → Internal Call → State Write → Effect Traces
Owner -> setController() -> onlyOwner -> _setController() -> controller slot write -> effect.

## Normal / Emergency / Recovery / Upgrade / Migration Paths
Emergency pause callable by Owner; proxy admin can upgrade implementation.
EOF

  cat > "$r/deployment.md" <<'EOF'
Capability | Contract/Address | Status
--- | --- | ---
Vault deposit | 0xAAA | ACTIVE
Oracle feed | 0xBBB | ACTIVE

## Missing / unavailable evidence
None — all relevant addresses were confirmed against the block explorer.
EOF

  cat > "$r/invariants.md" <<'EOF'
## INV-001 — Share value never decreases from a user deposit
- Definition: totalAssets/totalShares must not decrease solely because a user deposited.
- WHERE CREATED: Vault.sol:120
- WHERE ASSUMED: Vault.sol:150 withdraw()
- WHERE CAN CHANGE: Vault.sol:120 _mintShares()
- WHO CAN INFLUENCE: any depositor
- ACTUALLY ENFORCED?: yes
- Enforcement point: Vault.sol:125 rounding-down mint
EOF
}

PLACEHOLDER_H001='H-001 | _e.g. oracle price is trusted as fresh_ | _mint/withdraw path_ | _state, roles, funds_ | _ordered steps_ | _state delta_ | _$ impact_ | _experiment file_ | SOURCE_VERIFIED | UNTESTED'

seed_placeholder_hypotheses() {
  cat > "$1/research/hypotheses.md" <<EOF
# Hypothesis Ledger

ID | ASSUMPTION | ATTACK SURFACE | PRECONDITIONS | ATTACK SEQUENCE | EXPECTED EFFECT | EXPECTED ECONOMIC CONSEQUENCE | TEST PLAN | EVIDENCE LEVEL | STATUS
---|---|---|---|---|---|---|---|---|---
$PLACEHOLDER_H001
EOF
}

# --- 1. Empty required artifacts block phase advancement --------------------
t1() {
  local d; d="$(new_fixture)"
  mkdir -p "$d/research"
  : > "$d/research/scope.md"
  out="$($GATE "$d/research")"; ec=$?
  assert_exit "T1 empty scope.md blocks the gate" 1 "$ec"
  assert_contains "T1 report names scope.md as missing/empty" "$out" "scope.md: MISSING/EMPTY"
}

# --- 2. Partially completed Phase 1 blocks Phase 2+ --------------------------
t2() {
  local d; d="$(new_fixture)"
  seed_complete_reconstruction "$d"
  # sabotage: wipe just one Phase 1 artifact
  : > "$d/research/asset-flows.md"
  out="$($GATE "$d/research")"; ec=$?
  assert_exit "T2 partial Phase 1 blocks the gate" 1 "$ec"
  assert_contains "T2 Phase 1 reported INCOMPLETE" "$out" "Phase 1: INCOMPLETE"
  assert_contains "T2 Phase 2 reported BLOCKED, not independently COMPLETE" "$out" "Phase 2: BLOCKED"
  assert_contains "T2 Phase 3 reported BLOCKED" "$out" "Phase 3: BLOCKED"
}

# --- 3. Missing deployment.md blocks Phase 3+ --------------------------------
t3() {
  local d; d="$(new_fixture)"
  seed_complete_reconstruction "$d"
  rm -f "$d/research/deployment.md"
  out="$($GATE "$d/research")"; ec=$?
  assert_exit "T3 missing deployment.md blocks the gate" 1 "$ec"
  assert_contains "T3 Phase 2 reported INCOMPLETE" "$out" "Phase 2: INCOMPLETE"
  assert_contains "T3 Phase 3 reported BLOCKED by Phase 2" "$out" "Phase 3: BLOCKED (upstream Phase 2 incomplete)"
}

# --- 4. Missing invariants.md blocks hypothesis generation -------------------
t4() {
  local d; d="$(new_fixture)"
  seed_complete_reconstruction "$d"
  : > "$d/research/invariants.md"
  out="$($GATE "$d/research")"; ec=$?
  assert_exit "T4 missing invariants.md blocks the gate" 1 "$ec"
  assert_contains "T4 hypothesis gate reported LOCKED" "$out" "Hypothesis Generation Gate (Phase 5+): LOCKED"
}

# --- 5. Newly discovered leads are queued rather than immediately investigated
t5() {
  local d; d="$(new_fixture)"
  seed_complete_reconstruction "$d"
  : > "$d/research/invariants.md"   # keep gate LOCKED
  cat > "$d/research/leads.md" <<'EOF'
# Pending Leads

ID | LOCATION | OBSERVATION | INITIAL CONFIDENCE | INITIAL IMPACT | STATUS
---|---|---|---|---|---
L-001 | Vault.sol:88 | suspicious unchecked external call | MED | possible reentrancy | OBSERVED
L-002 | Controller.sol:40 | asymmetric role check | LOW | unclear | QUEUED
L-003 | Oracle.sol:10 | stale price bound missing | HIGH | mint at wrong price | FALSIFIED
EOF
  out="$($GATE "$d/research")"; ec=$?
  assert_exit "T5 gate still LOCKED with leads queued" 1 "$ec"
  assert_contains "T5 counts OBSERVED+QUEUED leads as pending (2), not FALSIFIED" "$out" "Pending leads preserved: 2"
}

# --- 6. Resume logic derives phase state from artifacts, not memory ---------
t6() {
  local d; d="$(new_fixture)"
  seed_complete_reconstruction "$d"
  seed_placeholder_hypotheses "$d"
  # Two independent invocations against the same on-disk state must agree,
  # proving the result comes from the files, not from any in-process memory.
  out1="$($GATE "$d/research")"; ec1=$?
  out2="$($GATE "$d/research")"; ec2=$?
  assert_exit "T6 first read of artifacts: gate OPEN" 0 "$ec1"
  assert_exit "T6 second independent read agrees" 0 "$ec2"
  if [ "$out1" != "$out2" ]; then
    # timestamps differ line-by-line; strip the generated: line before comparing
    s1="$(printf '%s\n' "$out1" | grep -v '^generated:')"
    s2="$(printf '%s\n' "$out2" | grep -v '^generated:')"
    if [ "$s1" = "$s2" ]; then
      echo "ok   - T6 reports are identical modulo timestamp"
      PASS=$((PASS+1))
    else
      echo "FAIL - T6 two reads of identical artifacts disagree"
      FAIL=$((FAIL+1))
    fi
  else
    echo "ok   - T6 reports are byte-identical"
    PASS=$((PASS+1))
  fi
}

# --- 7. A compelling lead cannot bypass the gate -----------------------------
t7() {
  local d; d="$(new_fixture)"
  seed_complete_reconstruction "$d"
  : > "$d/research/invariants.md"   # gate LOCKED
  cat > "$d/research/hypotheses.md" <<EOF
# Hypothesis Ledger

ID | ASSUMPTION | ATTACK SURFACE | PRECONDITIONS | ATTACK SEQUENCE | EXPECTED EFFECT | EXPECTED ECONOMIC CONSEQUENCE | TEST PLAN | EVIDENCE LEVEL | STATUS
---|---|---|---|---|---|---|---|---|---
$PLACEHOLDER_H001
H-002 | oracle staleness never checked | mint path | attacker calls after stale oracle | call mint() with stale price | mint at wrong price | drains vault | research/experiments/H-002 | SOURCE_VERIFIED | TESTING
EOF
  mkdir -p "$d/research/experiments"
  echo "fake poc" > "$d/research/experiments/H-002-poc.t.sol"
  out="$($GATE "$d/research")"; ec=$?
  assert_exit "T7 a real hypothesis + PoC while LOCKED is flagged as a violation" 3 "$ec"
  assert_contains "T7 report names the violation" "$out" "GATE VIOLATIONS DETECTED"
  assert_contains "T7 still says DO NOT ADVANCE" "$out" "DO NOT ADVANCE"
}

# --- 8. Correctly completed artifacts allow progression ----------------------
t8() {
  local d; d="$(new_fixture)"
  seed_complete_reconstruction "$d"
  out="$($GATE "$d/research")"; ec=$?
  assert_exit "T8 fully complete Phase 0-3 opens the gate" 0 "$ec"
  assert_contains "T8 reports GATE OPEN" "$out" "Hypothesis Generation Gate (Phase 5+): OPEN"
}

# --- 9. Misfiled evidence does not count as completion of the canonical file -
t9() {
  local d; d="$(new_fixture)"
  seed_complete_reconstruction "$d"
  # Deployment facts written into architecture.md instead of deployment.md.
  cat >> "$d/research/architecture.md" <<'EOF'

## Deployment facts (misfiled — should live in deployment.md)
Vault proxy 0xAAA, implementation 0xCCC, owner multisig 0xDDD, ACTIVE on mainnet.
EOF
  : > "$d/research/deployment.md"
  out="$($GATE "$d/research")"; ec=$?
  assert_exit "T9 misfiled deployment evidence does not open the gate" 1 "$ec"
  assert_contains "T9 deployment.md still reported INCOMPLETE" "$out" "Phase 2: INCOMPLETE"
}

echo "=== gate_check.sh regression suite ==="
t1; t2; t3; t4; t5; t6; t7; t8; t9
echo "==============================="
echo "Passed: $PASS  Failed: $FAIL"
[ "$FAIL" -eq 0 ]
