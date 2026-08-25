# PHASE 6 — Ranked hypothesis generation

Only after `scripts/gate_check.sh research/` reports OPEN (Phases 0–5 complete).

Do not enumerate SWC / OWASP / Slither categories. Do not scan a checklist of attack primitives.

Generate hypotheses from the protocol model. The generator question is:

> Given these promises, state transitions, accounting relationships, and attacker capabilities, what transformation would cause a participant's expected claim to become greater than the system's ability to honor it?

Each `H-###` names the `PROM-###` it tries to break. Architecture-derived classes (ordering, callbacks, upgrades, rounding, asset equivalence, composability) are *outputs* of that question, not a menu.

## Anti-anchoring (required before QUEUED → HYPOTHESIS)

1. What promise is at risk (`PROM-###`)?
2. What security property / accounting identity could break?
3. What attacker capability is required?
4. What state transition is affected (`ST-###`)?
5. What prevents it today?
6. What required condition must fail (`ASM-###` / `COND-###`)?
7. Can that condition actually fail on the deployment?
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
