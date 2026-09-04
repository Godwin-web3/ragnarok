#!/usr/bin/env bash
# One Foundry harness per target. Idempotent.
# Usage: ./scripts/harness_init.sh <target-dir>
set -euo pipefail

TARGET="${1:-$PWD}"
EXP="$TARGET/research/experiments"
mkdir -p "$EXP"

if [ -f "$EXP/Campaign.t.sol" ]; then
  echo "exists $EXP/Campaign.t.sol"
  exit 0
fi

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
echo "Run with FORK_RPC and FORK_BLOCK set. Add one test per H-###."
