# Target — DVD Truster

Educational CTF. Local only.

## Pin

- Repo: https://github.com/theredguild/damn-vulnerable-defi
- Path: `src/truster/TrusterLenderPool.sol`
- Brief: flash loan of DVT. Drain the pool. Player starts with 0 DVT.

## Authorization

```
Authorization: NONE
Environment: LOCAL_FORK
Live exploitation: NO
```

## Seams

- Flash-loan repay check ↔ arbitrary `target.functionCall(data)`
- Authorization vs execution. Pool is `msg.sender` of that call.
