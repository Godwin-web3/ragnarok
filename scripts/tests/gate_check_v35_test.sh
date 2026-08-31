#!/usr/bin/env bash
# v3.5 regressions: imagination gate vs campaign gate
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

echo "=== gate_check v3.5 — synthesis vs campaign ==="

# empty research: synthesis locked
d="$(mktemp -d "$WORKROOT/f.XXXXXX")"
mkdir -p "$d/research"
out="$(bash "$GATE" "$d/research")"; ec=$?
assert_exit "S1 empty research locks synthesis" 1 "$ec"
assert_contains "S1 synthesis locked" "$out" "Imagination Gate (Adversarial State Synthesis): LOCKED"

# scope + NOW + thin map opens synthesis without model
d="$(mktemp -d "$WORKROOT/f.XXXXXX")"
r="$d/research"; mkdir -p "$r"
cat > "$r/NOW.md" <<'EOF'
# NOW
- Phase: 1
- Gate: SYNTHESIS
- Env: READ_ONLY_PRODUCTION
- Pin: example@1
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
## Actor → Entry → Check → State → Effect Traces
User -> deposit() -> mint shares -> balances updated on the vault.
EOF
out="$(bash "$GATE" "$d/research")"; ec=$?
assert_exit "S2 thin map opens synthesis" 0 "$ec"
assert_contains "S2 synthesis open" "$out" "Imagination Gate (Adversarial State Synthesis): OPEN"
assert_contains "S2 campaign locked" "$out" "Campaign Gate (full reconstruction, Phases 0-5): LOCKED"

# contradiction cards before thin map is a violation
d="$(mktemp -d "$WORKROOT/f.XXXXXX")"
r="$d/research"; mkdir -p "$r"
cat > "$r/NOW.md" <<'EOF'
# NOW
- Phase: 0
- Gate: LOCKED
EOF
cat > "$r/scope.md" <<'EOF'
# Scope
- Authorization status: NONE
- Research environment: READ_ONLY_PRODUCTION
- Live exploitation permitted: NO
- Repository: github.com/example/protocol
EOF
cat > "$r/contradictions.md" <<'EOF'
## CX-001 — claims survive while assets shrink
- STATE: totalShares constant, totalAssets down
EOF
out="$(bash "$GATE" "$d/research")"; ec=$?
assert_exit "S3 cards before thin map are a violation" 3 "$ec"
assert_contains "S3 names contradiction violation" "$out" "contradictions.md contains CX-### cards"

echo "==============================="
echo "Passed: $PASS  Failed: $FAIL"
[ "$FAIL" -eq 0 ]
