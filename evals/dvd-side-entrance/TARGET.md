# Target — DVD Side Entrance

Educational CTF. Local only.

## Pin

- Repo: https://github.com/theredguild/damn-vulnerable-defi
- Path: `src/side-entrance/`
- Brief: a lending pool lets anyone deposit and withdraw ETH. Flash loans exist. Drain the pool.

## Authorization

```
Authorization: NONE
Environment: LOCAL_FORK
Live exploitation: NO
```

## Seams

- Flash-loan callback ↔ deposit
- Deposit ledger ↔ pool ETH balance

Do not load a solution writeup during the hunt.
