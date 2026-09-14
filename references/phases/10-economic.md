# PHASE 11 — Economic validation

Every surviving technical issue needs numbers before severity. Harsher than "there is a delta".

```
ATTACKER BEFORE / AFTER
PROTOCOL BEFORE / AFTER
capital required
flashloanability (can the capital be rented in the same tx?)
same-tx atomicity (does the profit survive if the bundle is atomic?)
exit liquidity (can the attacker actually leave with the asset?)
MEV / keeper race (who else can take the profit, and can the attacker win atomically?)
repeatability
extractable value
victim/protocol loss
attacker profit
CLASS: EXTRACT | GRIEF | PRIVILEGED
```

## Grief vs extract (mandatory)

- EXTRACT — permissionless attacker profit, realistic capital, exit, atomicity. This is the only class that may become CONFIRMED.
- GRIEF — victim or protocol loss without attacker profit (or profit dominated by cost). Tag `CLASS: GRIEF`. Bucket it. Do not clog the CONFIRMED queue.
- PRIVILEGED — needs an in-scope-trusted admin/role. Tag `CLASS: PRIVILEGED`. Bucket PRIVILEGED RISK. Not a permissionless CONFIRMED finding.

## Before CONFIRMED

`report_gate.sh` requires the Economic Impact section to record flashloanability/capital, same-tx atomicity, exit liquidity, MEV/keeper race, and `CLASS: EXTRACT`.

Distinguish TECHNICAL VIOLATION from ECONOMIC EXPLOIT. ECONOMICALLY_VERIFIED requires a realistic attacker/protocol delta with real preconditions and attacker control — not a bare state transition.

Rank (see `05-hypotheses.md`):

```
P1 = permissionless AND ACTIVE AND capital/flashloan plausible AND atomic or durable AND exit liquidity AND EXTRACT
P2 = missing exactly one of those
P3 = GRIEF / PRIVILEGED / INACTIVE / UNVERIFIED-blocked / speculative
```
