# EVM adapter — lookup table

Commands, not essays. Use against READ_ONLY_PRODUCTION or a local Anvil fork. Never send a production tx unless AUTHORIZED_LIVE.

Replace `$RPC`, `$ADDR`, `$IMPL`, `$FORK_RPC`, `$BLOCK`, `$WHO`.

## Pin a fork

```bash
anvil --fork-url $FORK_RPC --fork-block-number $BLOCK
```

Foundry test fork (campaign harness):

```solidity
vm.createSelectFork(vm.envString("FORK_RPC"), vm.envUint("FORK_BLOCK"));
```

## Bytecode identity

```bash
cast code $ADDR --rpc-url $RPC
cast keccak $(cast code $ADDR --rpc-url $RPC)
```

Compare to `forge inspect ContractName deployedBytecode` at the pinned commit. Mismatch → source≠deployment blocker.

## Proxy implementation / admin (EIP-1967)

```bash
cast storage $ADDR 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc --rpc-url $RPC
cast storage $ADDR 0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103 --rpc-url $RPC
cast impl $ADDR --rpc-url $RPC
```

## Owner / roles / pause

```bash
cast call $ADDR "owner()(address)" --rpc-url $RPC
cast call $ADDR "paused()(bool)" --rpc-url $RPC
cast call $ADDR "hasRole(bytes32,address)(bool)" $ROLE $WHO --rpc-url $RPC
```

## Oracle wiring / freshness

```bash
cast call $ADDR "oracle()(address)" --rpc-url $RPC
cast call $ORACLE "latestRoundData()(uint80,int256,uint256,uint256,uint80)" --rpc-url $RPC
```

## Token / balances

```bash
cast call $TOKEN "balanceOf(address)(uint256)" $WHO --rpc-url $RPC
```

## Impersonation on the fork only

```solidity
vm.prank(attacker);
vm.deal(attacker, 10 ether);
deal(token, attacker, amount);
```

## Behavior check vs address match

Address in `deployments.json` is step one. For an oracle / precompile / registry, submit a **self-generated** vector (`eth_call`) and record the result. If you cannot, mark UNVERIFIED.

## Campaign harness skeleton

`research/experiments/Campaign.t.sol` — one `setUp()` fork, one function per hypothesis, `vm.snapshot` / `vm.revertTo` between mutations.
