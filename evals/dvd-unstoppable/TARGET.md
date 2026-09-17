# Target — DVD Unstoppable

Educational CTF. Local only. No live chain.

## Pin

- Repo: https://github.com/theredguild/damn-vulnerable-defi
- Path: `src/unstoppable/UnstoppableVault.sol`
- Related: `src/unstoppable/UnstoppableMonitor.sol`
- Challenge brief: a lending vault holds 1_000_000 DVT and offers free flash loans. Halt flash loans. Player starts with 100 DVT.

## Authorization

```
Authorization: NONE
Environment: LOCAL_FORK
Live exploitation: NO
```

## Seams to map first

- Vault ↔ underlying token
- Vault ↔ flash-loan callback
- Share accounting ↔ `totalAssets()`

## What the hunt is allowed to read

Challenge README. Vault source. Monitor source. Test setup for balances.

## What the hunt is not allowed to read

`EXPECTED.md`. Public writeups. Solution tests.
