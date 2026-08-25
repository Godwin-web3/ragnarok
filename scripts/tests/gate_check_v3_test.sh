#!/usr/bin/env bash
# v3-only regressions for scripts/gate_check.sh
# Covers Phase 5 (protocol-model.md): structural fields, ID cross-references,
# critical-actor coverage, and the no-applicable-model escape hatch.
set -u

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GATE="$HERE/../gate_check.sh"
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

# Seeds a research/ dir where Phases 0-4 are already COMPLETE, so every test
# here isolates Phase 5 (protocol-model.md) behavior.
seed() {
  local r="$1/research"
  mkdir -p "$r"
  cat > "$r/NOW.md" <<'EOF'
# NOW
- Phase: 5
- Gate: LOCKED
- Env: READ_ONLY_PRODUCTION
- Pin: github.com/example/protocol@abc123
- Adapter: evm
EOF
  cat > "$r/scope.md" <<'EOF'
# Scope
- Authorization status: NONE
- Research environment: READ_ONLY_PRODUCTION
- Live exploitation permitted: NO
- Repository: github.com/example/protocol
EOF
  cat > "$r/architecture.md" <<'EOF'
# Architecture
## Component graph
Component | Type | Address | Role | Trusts | Trusted by
--- | --- | --- | --- | --- | ---
Vault | proxy | 0xAAA | custody | Oracle | Users
Oracle | feed | 0xBBB | price | off-chain | Vault
## Contracts & Components
Vault.sol proxy at 0xAAA and oracle 0xBBB.
## Entry Points
deposit() and withdraw() are external.
## Privileged Functions & Upgrade Paths
setController is onlyOwner. Proxy admin can upgrade.
## External Dependencies & Callback Surfaces
Relies on an external price oracle.
## Actor → Entry → Check → State → Effect Traces
User -> deposit() -> onlyIfNotPaused -> _mintShares() -> balances updated.
EOF
  cat > "$r/asset-flows.md" <<'EOF'
## Assets In
Users deposit the underlying ERC20 token via deposit().
## Assets Out
Users withdraw underlying token via withdraw().
## Custody & Accounting Transitions
Vault custodies underlying; share ledger tracks ownership.
## Mint / Burn / Claim / Redemption Paths
Shares minted on deposit, burned on withdraw.
## Attacker-Controlled Inputs Affecting Value
Deposit amount and timing relative to price updates.
EOF
  cat > "$r/trust-boundaries.md" <<'EOF'
## Actors & Authorities
Users, Owner, Oracle.
## Actor → Entry Point → Check → Internal Call → State Write → Effect Traces
Owner -> setController() -> onlyOwner -> _setController() -> slot write.
## Normal / Emergency / Recovery / Upgrade / Migration Paths
Emergency pause by Owner; proxy admin can upgrade.
## Composition traces
Pairing | Trace | Invariant at risk
--- | --- | ---
Vault + Oracle | deposit reads spot with no heartbeat | INV-001
EOF
  cat > "$r/deployment.md" <<'EOF'
Capability | Contract/Address | Status
--- | --- | ---
Vault deposit | 0xAAA | ACTIVE
Oracle feed | 0xBBB | ACTIVE
## Missing / unavailable evidence
None — explorer confirmed all relevant addresses.
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
  cat > "$r/assumptions.md" <<'EOF'
## ASM-001 — Oracle spot is always fresh at mint
- TRUSTED BY: Vault.sol:88
- INFLUENCEABLE BY: oracle updater
- FAILURE CONDITION: mint after updatedAt exceeds heartbeat
- POSSIBLE CONSEQUENCE: shares minted at the wrong price
- ATTACK SURFACE: deposit()
- CROSSES BOUNDARY?: oracle -> vault
- PROVENANCE: SOURCE_VERIFIED
- CONFIDENCE: med
EOF
}

valid_model() {
  cat <<'EOF'
## ACT-001 Lender
- Critical?: yes

## PROM-001 Shares redeemable for underlying
- Actor: ACT-001
- Promise: shares convert to underlying at spot rate
- Required conditions: ASM-001
- Accounting: INV-001
- State transitions: ST-001
- Enforcement: Vault.sol:125
- Attacker influence: donate token then mint to skew the rate
- Potential value transfer: later depositor overpays for shares
- Falsification plan: eth_call convertToShares(1) after a 1-wei donation

## ST-001 deposit -> mint
- Who can trigger: any token holder
EOF
}

echo "=== gate_check v3 — protocol-model.md (Phase 5) ==="

# V1: missing protocol-model.md blocks the gate
d="$(mktemp -d "$WORKROOT/f.XXXXXX")"
seed "$d"
out="$(bash "$GATE" "$d/research")"; ec=$?
assert_exit "V1 missing protocol-model.md blocks the gate" 1 "$ec"
assert_contains "V1 names Phase 5 missing" "$out" "protocol-model.md: MISSING/EMPTY"

# V2: full valid model opens the gate
d="$(mktemp -d "$WORKROOT/f.XXXXXX")"
seed "$d"
valid_model > "$d/research/protocol-model.md"
out="$(bash "$GATE" "$d/research")"; ec=$?
assert_exit "V2 full valid protocol model opens the gate" 0 "$ec"
assert_contains "V2 GATE OPEN" "$out" "Hypothesis Generation Gate (Phase 6+): OPEN"

# V3: honest 'No Applicable Protocol Model' rationale opens the gate
d="$(mktemp -d "$WORKROOT/f.XXXXXX")"
seed "$d"
cat > "$d/research/protocol-model.md" <<'EOF'
## No Applicable Protocol Model
This target is a pure off-chain indexer with no custody, no mintable claim,
and no actor who could ever hold an unhonored promise on value.
EOF
out="$(bash "$GATE" "$d/research")"; ec=$?
assert_exit "V3 honest no-applicable rationale opens the gate" 0 "$ec"

# V4: no ACT-### actors blocks
d="$(mktemp -d "$WORKROOT/f.XXXXXX")"
seed "$d"
cat > "$d/research/protocol-model.md" <<'EOF'
## PROM-001 Shares redeemable for underlying
- Actor: ACT-001
- Promise: x
- Required conditions: ASM-001
- Accounting: INV-001
- State transitions: ST-001
- Enforcement: x
- Attacker influence: x
- Potential value transfer: x
- Falsification plan: x

## ST-001 x
- Who can trigger: x
EOF
out="$(bash "$GATE" "$d/research")"; ec=$?
assert_exit "V4 no ACT-### actors blocks" 1 "$ec"
assert_contains "V4 names missing actors" "$out" "no ACT-### actors"

# V5: promise citing a nonexistent ASM-### blocks
d="$(mktemp -d "$WORKROOT/f.XXXXXX")"
seed "$d"
cat > "$d/research/protocol-model.md" <<'EOF'
## ACT-001 Lender
- Critical?: yes

## PROM-001 Shares redeemable for underlying
- Actor: ACT-001
- Promise: shares convert to underlying at spot rate
- Required conditions: ASM-999
- Accounting: INV-001
- State transitions: ST-001
- Enforcement: x
- Attacker influence: x
- Potential value transfer: x
- Falsification plan: x

## ST-001 deposit -> mint
- Who can trigger: any token holder
EOF
out="$(bash "$GATE" "$d/research")"; ec=$?
assert_exit "V5 unresolved ASM-### reference blocks" 1 "$ec"
assert_contains "V5 names the missing assumption" "$out" "ASM-999 missing from assumptions.md"

# V6: critical actor with no promise blocks
d="$(mktemp -d "$WORKROOT/f.XXXXXX")"
seed "$d"
cat > "$d/research/protocol-model.md" <<'EOF'
## ACT-001 Lender
- Critical?: yes

## ACT-002 Keeper
- Critical?: yes

## PROM-001 Shares redeemable for underlying
- Actor: ACT-001
- Promise: shares convert to underlying at spot rate
- Required conditions: ASM-001
- Accounting: INV-001
- State transitions: ST-001
- Enforcement: x
- Attacker influence: x
- Potential value transfer: x
- Falsification plan: x

## ST-001 deposit -> mint
- Who can trigger: any token holder
EOF
out="$(bash "$GATE" "$d/research")"; ec=$?
assert_exit "V6 critical actor without a promise blocks" 1 "$ec"
assert_contains "V6 names the uncovered actor" "$out" "critical actor ACT-002 has no promise"

# V7: promise missing a required field blocks and names it
d="$(mktemp -d "$WORKROOT/f.XXXXXX")"
seed "$d"
cat > "$d/research/protocol-model.md" <<'EOF'
## ACT-001 Lender
- Critical?: yes

## PROM-001 Shares redeemable for underlying
- Actor: ACT-001
- Promise: shares convert to underlying at spot rate
- Required conditions: ASM-001
- Accounting: INV-001
- State transitions: ST-001
- Enforcement: x
- Attacker influence: x
- Potential value transfer: x

## ST-001 deposit -> mint
- Who can trigger: any token holder
EOF
out="$(bash "$GATE" "$d/research")"; ec=$?
assert_exit "V7 promise missing falsification plan blocks" 1 "$ec"
assert_contains "V7 names the missing field" "$out" "PROM-001 missing field 'Falsification plan:'"

echo "==============================="
echo "Passed: $PASS  Failed: $FAIL"
[ "$FAIL" -eq 0 ]
