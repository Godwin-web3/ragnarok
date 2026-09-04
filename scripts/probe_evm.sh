#!/usr/bin/env bash
# Cheap EVM falsifiers. Read-only against $RPC unless you point it at a local fork.
# Never send a production transaction from this script.
#
# Usage:
#   RPC=... ADDR=... ./scripts/probe_evm.sh identity
#   RPC=... ADDR=... ./scripts/probe_evm.sh proxy
#   RPC=... ADDR=... TOKEN=... WHO=... ./scripts/probe_evm.sh balances
#   RPC=... ADDR=... ./scripts/probe_evm.sh owner
set -euo pipefail

need() {
  command -v "$1" >/dev/null 2>&1 || { echo "missing $1 (install foundry cast)"; exit 2; }
}

need cast
RPC="${RPC:-}"
ADDR="${ADDR:-}"
CMD="${1:-help}"

if [ "$CMD" = "help" ] || [ -z "$RPC" ]; then
  cat <<'EOF'
probe_evm.sh — cheapest read-only checks

  RPC     required
  ADDR    contract under test
  TOKEN   optional token
  WHO     optional account
  IMPL    optional expected implementation

Commands:
  identity   code size + keccak of runtime bytecode
  proxy      EIP-1967 implementation and admin
  owner      owner() / paused() if present
  balances   token.balanceOf(ADDR) and token.balanceOf(WHO)
  oracle     latestRoundData on $ADDR (treat ADDR as the feed)

Example:
  RPC=http://127.0.0.1:8545 ADDR=0x... ./scripts/probe_evm.sh proxy
EOF
  exit 0
fi

[ -n "$ADDR" ] || { echo "ADDR required"; exit 2; }

case "$CMD" in
  identity)
    code="$(cast code "$ADDR" --rpc-url "$RPC")"
    echo "code_bytes $(( (${#code} - 2) / 2 ))"
    echo "code_keccak $(cast keccak "$code")"
    ;;
  proxy)
    impl_slot="0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc"
    admin_slot="0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103"
    echo "eip1967_impl $(cast storage "$ADDR" "$impl_slot" --rpc-url "$RPC")"
    echo "eip1967_admin $(cast storage "$ADDR" "$admin_slot" --rpc-url "$RPC")"
    cast impl "$ADDR" --rpc-url "$RPC" 2>/dev/null || true
    ;;
  owner)
    cast call "$ADDR" "owner()(address)" --rpc-url "$RPC" 2>/dev/null || echo "owner() missing"
    cast call "$ADDR" "paused()(bool)" --rpc-url "$RPC" 2>/dev/null || echo "paused() missing"
    ;;
  balances)
    TOKEN="${TOKEN:-}"
    WHO="${WHO:-}"
    [ -n "$TOKEN" ] || { echo "TOKEN required"; exit 2; }
    echo "vault_or_target $(cast call "$TOKEN" "balanceOf(address)(uint256)" "$ADDR" --rpc-url "$RPC")"
    if [ -n "$WHO" ]; then
      echo "who $(cast call "$TOKEN" "balanceOf(address)(uint256)" "$WHO" --rpc-url "$RPC")"
    fi
    ;;
  oracle)
    cast call "$ADDR" "latestRoundData()(uint80,int256,uint256,uint256,uint80)" --rpc-url "$RPC"
    ;;
  *)
    echo "unknown command $CMD"
    exit 2
    ;;
esac
