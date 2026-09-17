# NOW

- Phase: 1
- Gate: LOCKED until gate_check after thin map is complete
- Env: LOCAL_FORK
- Pin: theredguild/damn-vulnerable-defi src/unstoppable
- Adapter: evm
- Focus lock: live 0/2, probes 0/1, unresolved 0
- Open probe:
- Last falsifier result:

## Map (15 lines max)
- Components: UnstoppableVault (ERC4626 flash-loan vault), UnstoppableMonitor, DVT ERC20, player, feeRecipient
- External deps: token transfers, IERC3156FlashBorrower callback
- Assets: DVT
- Authorities: owner / feeRecipient on vault
- Unmapped / UNVERIFIED: exact DVD commit hash if not pinned locally

## Live invariants / assumptions
- INV-001 candidate: convertToShares(totalSupply) == totalAssets() before a flash loan
- ASM-001 candidate: vault token balance only changes through deposit/mint/withdraw/redeem/flashLoan

## Experiment seam (not the scope of the map)
- Current cut-set: Vault ↔ DVT balance ↔ share supply
- Do not drop from map: callback receiver, monitor

## Queue
1. Finish component graph + one deposit/flashLoan trace
2. gate_check
3. Invent pairing CX on share accounting vs token balance

## Ranked open hypotheses

## BLOCKED
