# Adversarial State Synthesis

The heart of V3.5. Load when SYNTHESIS is OPEN.

Job is not to inspect code for bugs. Job is to invent hostile worlds, then try to walk into them using only valid calls.

## Generator

For each important transition on the current seam:

1. What state does this function assume is impossible?
2. Can valid calls reach that state?
3. Can two components disagree about the same FACT-###?
4. Can a check pass, then have its meaning invalidated before settlement?
5. Can a right acquired in state A be redeemed in state B?
6. Can entitlement separate from payment?
7. Can authorization separate from execution?
8. Can identity separate from ownership?
9. Can price separate from solvency?
10. Can recorded balance separate from actual balance?
11. Can A → B → C each succeed while A → B → C is economically impossible under the intended model?

Write one card per invented world in `research/contradictions.md`.

## Card shape

```
## CX-001 — <short name for the impossible world>
- STATE: what must be simultaneously true
- CONTRADICTION: which two facts should not coexist
- CONSTRUCTION: valid actions that might make them coexist
- SEQUENCE: shortest action list
- WITNESS: storage / balance / claim that would prove it
- MONETIZATION: who redeems, withdraws, settles, or is forced to absorb it
- BLOCKED BY: missing node / unknown behavior / none
- STATUS: INVENTED | PROBING | REACHABLE | UNREACHABLE | MONETIZABLE | KILLED
```

Correct generator:

> Can total claims stay unchanged while redeemable assets decrease?

Wrong generator:

> Check for rounding bugs.

## Iteration

```
invent → cheapest probe → if blocked, expand map/dive → invent again
```

Do not pause synthesis until `protocol-model.md` is campaign-complete. Grow the model when the construction needs a named promise, condition, or accounting identity.

## Promotion

A REACHABLE card with a monetization path becomes `H-###` in `hypotheses.md`. The hypothesis names `CX-###` and, if it exists, `PROM-###`.

UNREACHABLE after a real probe is not a failure of the method. Record why. Mutate the state. Kill only after the mutations in `07-mutation.md`.
