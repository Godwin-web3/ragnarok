#!/usr/bin/env bash
# v2-only regressions for scripts/gate_check.sh
# Covers Phase 4, provenance, map completeness, NOW.md.
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

seed() {
  local r="$1/research"
  mkdir -p "$r"
  cat > "$r/NOW.md" <<'EOF'
# NOW
- Phase: 4
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

echo "=== gate_check v2 extras ==="
d="$(mktemp -d "$WORKROOT/f.XXXXXX")"
seed "$d"
: > "$d/research/assumptions.md"
out="$(bash "$GATE" "$d/research")"; ec=$?
assert_exit "T10 empty assumptions.md blocks the gate" 1 "$ec"
assert_contains "T10 Phase 4 INCOMPLETE" "$out" "Phase 4: INCOMPLETE"

d="$(mktemp -d "$WORKROOT/f.XXXXXX")"
seed "$d"
cat > "$d/research/assumptions.md" <<'EOF'
## ASM-001 — Oracle spot is always fresh at mint
- TRUSTED BY: Vault.sol:88
- INFLUENCEABLE BY: oracle updater
- FAILURE CONDITION: stale heartbeat
- POSSIBLE CONSEQUENCE: wrong mint
- ATTACK SURFACE: deposit()
- CROSSES BOUNDARY?: yes
- CONFIDENCE: med
EOF
out="$(bash "$GATE" "$d/research")"; ec=$?
assert_exit "T11 assumption without provenance blocks" 1 "$ec"
assert_contains "T11 names PROVENANCE" "$out" "PROVENANCE"

d="$(mktemp -d "$WORKROOT/f.XXXXXX")"
seed "$d"
cat > "$d/research/deployment.md" <<'EOF'
Capability | Contract/Address | Status
--- | --- | ---
Vault deposit | 0xAAA | ACTIVE
SecretHook | 0xEEE | ACTIVE
## Missing / unavailable evidence
None — explorer confirmed.
EOF
out="$(bash "$GATE" "$d/research")"; ec=$?
assert_exit "T12 live address missing from map blocks" 1 "$ec"
assert_contains "T12 grow the map" "$out" "grow the map"

d="$(mktemp -d "$WORKROOT/f.XXXXXX")"
seed "$d"
rm -f "$d/research/NOW.md"
out="$(bash "$GATE" "$d/research")"; ec=$?
assert_exit "T13 missing NOW.md blocks Phase 0" 1 "$ec"
assert_contains "T13 names NOW.md" "$out" "NOW.md"

d="$(mktemp -d "$WORKROOT/f.XXXXXX")"
seed "$d"
out="$(bash "$GATE" "$d/research")"; ec=$?
assert_exit "T8b complete 0-4 opens the gate" 0 "$ec"
assert_contains "T8b GATE OPEN" "$out" "Hypothesis Generation Gate (Phase 5+): OPEN"

echo "==============================="
echo "Passed: $PASS  Failed: $FAIL"
[ "$FAIL" -eq 0 ]
