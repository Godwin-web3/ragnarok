#!/usr/bin/env bash
# One Foundry harness per target. Idempotent.
# Usage:
#   ./scripts/harness_init.sh <target-dir>
#   ./scripts/harness_init.sh <target-dir> --cx CX-001
#   ./scripts/harness_init.sh <target-dir> --invariant CX-001
#
# --cx writes a witness test that asserts the invented STATE and that
# MONETIZATION moves value. --invariant writes a handler set that tries to
# walk into a REACHABLE CX via any valid call sequence.
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/cx_cards.inc.sh
. "$HERE/lib/cx_cards.inc.sh"

TARGET="$PWD"
CX=""
INV=""
while [ $# -gt 0 ]; do
  case "$1" in
    --cx)
      CX="${2:-}"
      shift
      [ $# -gt 0 ] && shift
      ;;
    --invariant)
      INV="${2:-}"
      shift
      [ $# -gt 0 ] && shift
      ;;
    --help|-h)
      cat <<'EOF'
harness_init.sh — Foundry campaign + CX witness/invariant scaffolds

  scripts/harness_init.sh <target-dir>
  scripts/harness_init.sh <target-dir> --cx CX-001
  scripts/harness_init.sh <target-dir> --invariant CX-001

Campaign.t.sol is one harness, one setUp fork, one function per H-###.
CX witness tests assert STATE + MONETIZATION. Invariant tests try to reach
the invented STATE through valid handlers. Never broadcast to production.
EOF
      exit 0
      ;;
    *)
      TARGET="$1"
      shift
      ;;
  esac
done

if [ -d "$TARGET/research" ]; then
  RESEARCH="$TARGET/research"
elif [ -f "$TARGET/contradictions.md" ]; then
  RESEARCH="$TARGET"
  TARGET="$(cd "$TARGET/.." && pwd)"
else
  RESEARCH="$TARGET/research"
fi

EXP="$RESEARCH/experiments"
mkdir -p "$EXP"

if [ -f "$EXP/Campaign.t.sol" ]; then
  echo "exists $EXP/Campaign.t.sol"
else
  cat > "$EXP/Campaign.t.sol" <<'EOF'
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";

/// One harness. One setUp fork. One function per H-###.
/// Snapshot between mutations. Never broadcast to production.
contract Campaign is Test {
    uint256 internal forkId;

    function setUp() public {
        string memory rpc = vm.envString("FORK_RPC");
        uint256 blockNum = vm.envUint("FORK_BLOCK");
        forkId = vm.createSelectFork(rpc, blockNum);
    }

    function test_H001_cheapest_falsifier() public {
        // Replace with the smallest eth_call / state read that would kill H-001.
        assertTrue(true);
    }
}
EOF
  echo "wrote $EXP/Campaign.t.sol"
fi

if [ -n "$CX" ]; then
  [ -f "$RESEARCH/contradictions.md" ] || { echo "missing $RESEARCH/contradictions.md"; exit 2; }
  if ! printf '%s\n' "$(cx_ids)" | grep -qx "$CX"; then
    echo "unknown $CX — not a ## CX-### header in contradictions.md"
    exit 2
  fi
  body="$(cx_body "$CX")"
  witness="$(cx_field "$body" 'WITNESS')"
  if ! is_assertable_witness "$witness"; then
    echo "REFUSE: $CX WITNESS is not assertable. Card stays INVENTED. No harness."
    echo "WITNESS must be an expression that can become assertTrue/assertGt (storage, balance, claim), not prose."
    exit 2
  fi
  write_cx_witness_harness "$TARGET" "$CX"
fi

if [ -n "$INV" ]; then
  [ -f "$RESEARCH/contradictions.md" ] || { echo "missing $RESEARCH/contradictions.md"; exit 2; }
  if ! printf '%s\n' "$(cx_ids)" | grep -qx "$INV"; then
    echo "unknown $INV — not a ## CX-### header in contradictions.md"
    exit 2
  fi
  write_cx_invariant_harness "$TARGET" "$INV"
fi

echo "Run with FORK_RPC and FORK_BLOCK set."
echo "Add one Campaign test per H-###. CX witness/invariant files are per card."
