#!/usr/bin/env bash
# Smoke tests: seam retrieve returns only tagged seams; empty knowledge falls back.
set -u
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$HERE/../.." && pwd)"
RETRIEVE="$HERE/../shape_retrieve.sh"
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
assert_not_contains() {
  local desc="$1" haystack="$2" needle="$3"
  if printf '%s' "$haystack" | grep -qF -- "$needle"; then
    echo "FAIL - $desc (did not expect: $needle)"
    FAIL=$((FAIL+1))
  else
    echo "ok   - $desc"
    PASS=$((PASS+1))
  fi
}

echo "=== shape_retrieve smoke ==="

# Usage error without seams
out="$(bash "$RETRIEVE" 2>&1)"; ec=$?
assert_exit "no seams is usage error" 2 "$ec"

# Empty knowledge → hand calibration for vault
empty="$WORKROOT/empty-knowledge"
mkdir -p "$empty"
out="$(bash "$RETRIEVE" --root "$ROOT" --knowledge "$empty" --n 15 vault)"; ec=$?
assert_exit "empty knowledge retrieve succeeds" 0 "$ec"
assert_contains "fallback pack names generators" "$out" "Generators for impossible states"
assert_contains "fallback includes SHAPE-01" "$out" "SHAPE-01"
assert_contains "fallback note" "$out" "empty"
assert_not_contains "fallback is not LazyAudit" "$out" "similar known bug"
assert_not_contains "no corpus dump heading" "$out" "Zaevlad raw"

# Tiny synthetic knowledge: vault vs bridge
kdir="$WORKROOT/k"
mkdir -p "$kdir"
cat > "$kdir/shapes.jsonl" <<'EOF'
{"calibration": false, "construction": "valid leak", "fact_a": "shares", "fact_b": "assets", "family_id": "claims_vs_assets", "member_count": 4, "monetize_kill": "redeem", "name": "Claims stay constant while redeemable assets fall", "poc_present": true, "provenance_ids": [11], "seams": ["vault"], "severity": "High", "shape_id": "SHAPE-K001", "source": "knowledge", "witness": "supply unchanged AND assets down"}
{"calibration": false, "construction": "replay message", "fact_a": "message", "fact_b": "lock", "family_id": "message_without_lock", "member_count": 2, "monetize_kill": "sell minted", "name": "Message accepted without a lock", "poc_present": true, "provenance_ids": [22], "seams": ["bridge"], "severity": "Critical", "shape_id": "SHAPE-K002", "source": "knowledge", "witness": "mint AND no lock"}
EOF

out="$(bash "$RETRIEVE" --root "$ROOT" --knowledge "$kdir" --n 20 vault)"; ec=$?
assert_exit "tagged retrieve succeeds" 0 "$ec"
assert_contains "includes vault knowledge shape" "$out" "SHAPE-K001"
assert_not_contains "excludes bridge-only knowledge shape" "$out" "SHAPE-K002"
assert_contains "includes vault calibration" "$out" "SHAPE-01"

out="$(bash "$RETRIEVE" --root "$ROOT" --knowledge "$kdir" --n 10 bridge)"; ec=$?
assert_exit "bridge retrieve succeeds" 0 "$ec"
assert_contains "bridge pack has K002" "$out" "SHAPE-K002"
assert_not_contains "bridge pack omits vault-only K001" "$out" "SHAPE-K001"

# Cap N
out="$(bash "$RETRIEVE" --root "$ROOT" --knowledge "$kdir" --n 3 vault)"
count="$(printf '%s\n' "$out" | grep -cE '^## SHAPE-')"
if [ "$count" -le 3 ]; then
  echo "ok   - --n 3 caps pack ($count)"
  PASS=$((PASS+1))
else
  echo "FAIL - --n 3 caps pack (got $count)"
  FAIL=$((FAIL+1))
fi

assert_not_contains "does not mention SWC classes" "$out" "SWC-"

# Live corpus (when populated): vault pack knowledge cards are vault-tagged
if [ -f "$ROOT/knowledge/shapes.jsonl" ]; then
  live_out="$WORKROOT/live-vault.md"
  bash "$RETRIEVE" --root "$ROOT" --knowledge "$ROOT/knowledge" --n 15 vault > "$live_out"
  ec=$?
  assert_exit "live vault retrieve succeeds" 0 "$ec"
  live="$(cat "$live_out")"
  assert_contains "live pack is generators" "$live" "Not LazyAudit"
  assert_not_contains "live pack is not a corpus dump" "$live" "bug_full"
  python3 - "$ROOT/knowledge/shapes.jsonl" "$live_out" <<'PY'
import json, re, sys
cards = {}
for line in open(sys.argv[1], encoding="utf-8"):
    if line.strip():
        c = json.loads(line)
        cards[c["shape_id"]] = c
pack = open(sys.argv[2], encoding="utf-8").read()
ids = re.findall(r"^## (SHAPE-K\d+)", pack, re.M)
bad = [sid for sid in ids if "vault" not in cards.get(sid, {}).get("seams", [])]
if bad:
    print("LIVE_SEAM_FAIL " + ",".join(bad))
    sys.exit(1)
if not ids:
    print("LIVE_SEAM_FAIL no SHAPE-K ids")
    sys.exit(1)
print("LIVE_SEAM_OK", len(ids))
PY
  pyec=$?
  if [ "$pyec" -eq 0 ]; then
    echo "ok   - live vault knowledge cards are vault-tagged"
    PASS=$((PASS+1))
  else
    echo "FAIL - live vault knowledge cards are vault-tagged"
    FAIL=$((FAIL+1))
  fi
fi

echo "==============================="
echo "Passed: $PASS  Failed: $FAIL"
[ "$FAIL" -eq 0 ]
