# PHASE 5 — Ranked hypothesis generation

Only after `scripts/gate_check.sh research/` reports OPEN.

Do not enumerate SWC / OWASP / Slither categories. Generate architecture-derived hypotheses from broken invariants, cross-contract inconsistency, oracle/accounting, ordering, callbacks, upgrades, rounding, asset equivalence, composability, unexpected state combinations.

Central question: **what can an attacker influence that makes an important assumption false?**

## Anti-anchoring (required before QUEUED → HYPOTHESIS)

1. What exactly is suspicious?
2. What security property could break?
3. What attacker capability is required?
4. What state transition is affected?
5. What prevents it today?
6. What assumption must fail?
7. Can that assumption actually fail?
8. What is the smallest falsifiable experiment?
9. What evidence would kill it?

A hypothesis is a concrete state transition, not "could potentially."

## Rank before you fork

```
P1 = permissionless AND capability ACTIVE AND capital/liquidity plausible
P2 = missing exactly one of those
P3 = speculative / privileged / INACTIVE / UNVERIFIED-blocked
```

Record `RANK` and `CHEAPEST FALSIFIER` on the ledger row. Run the cheapest falsifier (storage read, `eth_call`, unit test) before a scenario test.

Statuses: `UNTESTED | TESTING | KILLED | INCONCLUSIVE | SURVIVOR | CONFIRMED`.
CONFIRMED = RUNTIME_VERIFIED effect + ECONOMICALLY_VERIFIED impact.
Keep `leads.md` in sync.
