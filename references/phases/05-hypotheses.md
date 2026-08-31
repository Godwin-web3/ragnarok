# Ranked constructions (from contradictions)

Do not enumerate SWC / OWASP / Slither categories. Do not scan a checklist of attack primitives.

Generate `H-###` from `CX-###` cards that are REACHABLE or still live after a cheapest probe. The generator question is:

> Given this impossible state, what valid sequence makes two representations of the same fact diverge, and who can extract the difference?

If a protocol model exists, also name the `PROM-###` at risk. If it does not exist yet, name the fact and the two representations. Do not delay a live construction until the campaign gate opens.

## Anti-anchoring (required before CX → H)

1. What impossible state is claimed (`CX-###`)?
2. Which two representations of which fact diverge (`FACT-###`)?
3. What promise is at risk (`PROM-###` if modeled)?
4. What attacker capability is required?
5. What prevents it today?
6. Can that prevention fail on the deployment?
7. What is the smallest falsifiable experiment?
8. What evidence would kill it?
9. Who monetizes, and against whom?

A hypothesis is a concrete reachable state plus a witness, not "could potentially."

## Rank before you fork

```
P1 = permissionless AND capability ACTIVE AND capital/liquidity plausible
P2 = missing exactly one of those
P3 = speculative / privileged / INACTIVE / UNVERIFIED-blocked
```

Record `RANK` and `CHEAPEST FALSIFIER` on the ledger row. Run the cheapest falsifier (storage read, `eth_call`, unit test) before a scenario test.

Statuses: `UNTESTED | TESTING | KILLED | INCONCLUSIVE | SURVIVOR | CONFIRMED`.
CONFIRMED = RUNTIME_VERIFIED effect + ECONOMICALLY_VERIFIED impact.
Keep `leads.md` and `contradictions.md` in sync.
