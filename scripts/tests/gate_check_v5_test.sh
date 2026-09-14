#!/usr/bin/env bash
# V5 hunt-discipline regressions: focus lock, witness, pairing, invariant map, reopen.
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
    echo "FAIL - $desc (expected: $needle)"
    FAIL=$((FAIL+1))
  fi
}

thin() {
  local r="$1/research"
  mkdir -p "$r"
  cat > "$r/NOW.md" <<'EOF'
# NOW
- Phase: 1
- Gate: SYNTHESIS
- Env: READ_ONLY_PRODUCTION
- Pin: example@1
- Adapter: evm
- Focus lock: live 0/2, probes 0/1, unresolved 0
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
## Entry Points
deposit() and withdraw() are external.
## Actor → Entry → Check → State → Effect Traces
User -> deposit() -> mint shares -> balances updated on the vault.
EOF
}

echo "=== gate_check v5 — hunt discipline ==="

# F1: thin map still opens synthesis with no CX cards
d="$(mktemp -d "$WORKROOT/f.XXXXXX")"
thin "$d"
out="$(bash "$GATE" "$d/research")"; ec=$?
assert_exit "F1 thin map opens synthesis" 0 "$ec"
assert_contains "F1 synthesis open" "$out" "Imagination Gate (Adversarial State Synthesis): OPEN"
assert_contains "F1 campaign locked" "$out" "Campaign Gate (full reconstruction, Phases 0-5): LOCKED"

# F2: three live CX cards violate focus lock
d="$(mktemp -d "$WORKROOT/f.XXXXXX")"
thin "$d"
cat > "$d/research/contradictions.md" <<'EOF'
# Contradictions
## CX-001 — claims vs assets
- STATE: totalSupply constant AND token.balanceOf(vault) down
- PAIRING: Vault ↔ Oracle
- WITNESS: token.balanceOf(vault) < convertToAssets(totalSupply)
- MONETIZATION: attacker redeem extracts the missing assets
- STATUS: INVENTED
## CX-002 — auth vs exec
- STATE: check passed in A AND execution in B
- PAIRING: Vault ↔ Oracle
- WITNESS: authContext != execContext AND token.balanceOf(attacker) > startBal
- STATUS: INVENTED
## CX-003 — extra live
- STATE: queued claim transferable into a new backing
- PAIRING: Vault ↔ Oracle
- WITNESS: ticket.epoch != settle.epoch AND token.balanceOf(attacker) > paid
- STATUS: INVENTED
EOF
out="$(bash "$GATE" "$d/research")"; ec=$?
assert_exit "F2 three live cards is a focus-lock violation" 3 "$ec"
assert_contains "F2 names live max" "$out" "FOCUS LOCK: 3 live CX cards"

# F3: two PROBING cards violate
d="$(mktemp -d "$WORKROOT/f.XXXXXX")"
thin "$d"
cat > "$d/research/contradictions.md" <<'EOF'
# Contradictions
## CX-001 — a
- STATE: totalSupply constant AND token.balanceOf(vault) down
- PAIRING: Vault ↔ Oracle
- WITNESS: token.balanceOf(vault) < convertToAssets(totalSupply)
- FALSIFIER RESULT: shares-for-1 dropped
- STATUS: PROBING
## CX-002 — b
- STATE: right in A redeemed in B
- PAIRING: Vault ↔ Oracle
- WITNESS: ticket.epoch != settle.epoch AND token.balanceOf(attacker) > paid
- FALSIFIER RESULT: two oracles
- STATUS: PROBING
EOF
out="$(bash "$GATE" "$d/research")"; ec=$?
assert_exit "F3 two open probes violate" 3 "$ec"
assert_contains "F3 names probes" "$out" "open probes"

# F4: unresolved probe blocks another live card
d="$(mktemp -d "$WORKROOT/f.XXXXXX")"
thin "$d"
cat > "$d/research/contradictions.md" <<'EOF'
# Contradictions
## CX-001 — probing
- STATE: totalSupply constant AND token.balanceOf(vault) down
- PAIRING: Vault ↔ Oracle
- WITNESS: token.balanceOf(vault) < convertToAssets(totalSupply)
- FALSIFIER RESULT: unrecorded
- STATUS: PROBING
## CX-002 — invented while probe open
- STATE: auth in A exec in B
- PAIRING: Vault ↔ Oracle
- WITNESS: authContext != execContext AND token.balanceOf(attacker) > startBal
- STATUS: INVENTED
EOF
out="$(bash "$GATE" "$d/research")"; ec=$?
assert_exit "F4 unresolved probe blocks CX-N+1" 3 "$ec"
assert_contains "F4 names unresolved" "$out" "unresolved probe"

# F5: prose WITNESS cannot be PROBING
d="$(mktemp -d "$WORKROOT/f.XXXXXX")"
thin "$d"
cat > "$d/research/contradictions.md" <<'EOF'
# Contradictions
## CX-001 — soft
- STATE: the vault looks insolvent after a harvest
- PAIRING: Vault ↔ Oracle
- WITNESS: the vault looks insolvent
- STATUS: PROBING
EOF
out="$(bash "$GATE" "$d/research")"; ec=$?
assert_exit "F5 prose witness cannot probe" 3 "$ec"
assert_contains "F5 stays INVENTED" "$out" "WITNESS is not assertable"

# F6: CX cards without pairing violate early composition
d="$(mktemp -d "$WORKROOT/f.XXXXXX")"
thin "$d"
cat > "$d/research/contradictions.md" <<'EOF'
# Contradictions
## CX-001 — solo
- STATE: totalSupply constant AND token.balanceOf(vault) down
- WITNESS: token.balanceOf(vault) < convertToAssets(totalSupply)
- STATUS: INVENTED
EOF
out="$(bash "$GATE" "$d/research")"; ec=$?
assert_exit "F6 missing pairing CX violates" 3 "$ec"
assert_contains "F6 names composition" "$out" "COMPOSITION:"

# F7: REACHABLE without invariant mapping
d="$(mktemp -d "$WORKROOT/f.XXXXXX")"
thin "$d"
cat > "$d/research/contradictions.md" <<'EOF'
# Contradictions
## CX-001 — reachable
- STATE: totalSupply constant AND token.balanceOf(vault) down
- PAIRING: Vault ↔ Oracle
- WITNESS: token.balanceOf(vault) < convertToAssets(totalSupply)
- FALSIFIER RESULT: convertToShares dropped after donation
- STATUS: REACHABLE
EOF
out="$(bash "$GATE" "$d/research")"; ec=$?
assert_exit "F7 REACHABLE without handlers violates" 3 "$ec"
assert_contains "F7 names invariant" "$out" "INVARIANT HARNESS"

# F8: legal two-card hunt passes
d="$(mktemp -d "$WORKROOT/f.XXXXXX")"
thin "$d"
cat > "$d/research/contradictions.md" <<'EOF'
# Contradictions
## CX-001 — pairing
- STATE: totalSupply constant AND token.balanceOf(vault) down
- PAIRING: Vault ↔ Oracle
- WITNESS: token.balanceOf(vault) < convertToAssets(totalSupply)
- HANDLERS: deposit, withdraw
- INVARIANT HARNESS: research/experiments/CX001_invariant.t.sol
- FALSIFIER RESULT: convertToShares dropped after donation
- STATUS: REACHABLE
## CX-002 — second live
- STATE: auth in A exec in B
- PAIRING: Vault ↔ Oracle
- WITNESS: authContext != execContext AND token.balanceOf(attacker) > startBal
- STATUS: INVENTED
EOF
out="$(bash "$GATE" "$d/research")"; ec=$?
assert_exit "F8 two live cards with pairing and witness pass" 0 "$ec"
assert_contains "F8 focus hold" "$out" "Focus lock: HOLD"

# F9: map growth queues killed.md revisit-if
d="$(mktemp -d "$WORKROOT/f.XXXXXX")"
thin "$d"
cat > "$d/research/contradictions.md" <<'EOF'
# Contradictions
## CX-001 — pairing
- STATE: totalSupply constant AND token.balanceOf(vault) down
- PAIRING: Vault ↔ Oracle
- WITNESS: token.balanceOf(vault) < convertToAssets(totalSupply)
- STATUS: KILLED
EOF
cat > "$d/research/killed.md" <<'EOF'
# Killed
## H-001 — KILLED
- Why it failed: settle latches
- Revisit if: settleFrom()
EOF
printf '%s\n' "Vault" "Oracle" "deposit()" "withdraw()" > "$d/research/map-stamp.txt"
cat > "$d/research/architecture.md" <<'EOF'
# Architecture
## Component graph
Component | Type | Address | Role | Trusts | Trusted by
--- | --- | --- | --- | --- | ---
Vault | proxy | 0xAAA | custody | Oracle | Users
Oracle | feed | 0xBBB | price | off-chain | Vault
Helper | contract | 0x555 | settle adapter | Queue | Users
## Entry Points
deposit() and withdraw() and settleFrom() are external.
## Actor → Entry → Check → State → Effect Traces
User -> deposit() -> mint shares -> balances updated on the vault.
Helper -> settleFrom() -> pays collateral.
EOF
out="$(bash "$GATE" "$d/research")"; ec=$?
assert_exit "F9 map growth still synthesis-open" 0 "$ec"
assert_contains "F9 reopen queue" "$out" "Reopen queue"
assert_contains "F9 names settleFrom" "$out" "settleFrom()"

# F10: --write queues a lead
d="$(mktemp -d "$WORKROOT/f.XXXXXX")"
thin "$d"
cat > "$d/research/killed.md" <<'EOF'
# Killed
## H-001 — KILLED
- Why it failed: settle latches
- Revisit if: settleFrom()
EOF
printf '%s\n' "Vault" "Oracle" > "$d/research/map-stamp.txt"
cat > "$d/research/architecture.md" <<'EOF'
# Architecture
## Component graph
Component | Type | Address | Role | Trusts | Trusted by
--- | --- | --- | --- | --- | ---
Vault | proxy | 0xAAA | custody | Oracle | Users
Oracle | feed | 0xBBB | price | off-chain | Vault
Helper | contract | 0x555 | settle adapter | Queue | Users
## Entry Points
deposit() and withdraw() and settleFrom() are external.
## Actor → Entry → Check → State → Effect Traces
User -> deposit() -> mint shares -> balances updated on the vault.
EOF
out="$(bash "$GATE" "$d/research" --write)"; ec=$?
assert_exit "F10 --write succeeds" 0 "$ec"
if grep -q 'REOPEN' "$d/research/leads.md" 2>/dev/null; then
  echo "ok   - F10 queued REOPEN lead"
  PASS=$((PASS+1))
else
  echo "FAIL - F10 expected REOPEN in leads.md"
  FAIL=$((FAIL+1))
fi

echo "==============================="
echo "Passed: $PASS  Failed: $FAIL"
[ "$FAIL" -eq 0 ]
