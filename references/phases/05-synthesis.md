# Adversarial State Synthesis

The heart of V5. Load when SYNTHESIS is OPEN, **together with** `references/shapes.md`.

Job is not to inspect code for bugs. Job is to invent hostile worlds, then try to walk into them using only valid calls.

`shapes.md` is a generator corpus. It is not a scanner. If you tick shapes like SWC classes, you are doing it wrong.

## Early composition (mandatory)

After a thin map, the first invented card — or one of the first two, under focus lock — **must** be a pairing CX: two components disagreeing about the same fact.

Examples of pairings: vault↔oracle, queue↔settlement, message↔mint, token↔vault, harvest↔shares.

Do not wait for the late composition walk (`references/phases/08-composition.md`). That walk still happens. It is not when you start inventing cross-component states.

`scripts/gate_check.sh` fails hunt discipline if any CX exists and none has `PAIRING:` / `COMPONENTS:` naming two sides.

## Generator

For each important transition on the current seam, and against the shapes corpus:

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

Focus lock: max 2 live (`INVENTED`/`PROBING`/`REACHABLE`). Max 1 `PROBING`. No CX-N+1 until `FALSIFIER RESULT` is recorded.

## Card shape

```
## CX-001 — <short name for the impossible world>
- STATE: what must be simultaneously true
- CONTRADICTION: which two facts should not coexist
- PAIRING: ComponentA ↔ ComponentB
- CONSTRUCTION: valid actions that might make them coexist
- SEQUENCE: shortest action list
- WITNESS: assertable expression (storage / balance / claim). Not prose.
- MONETIZATION: who redeems, withdraws, settles, or is forced to absorb it
- CHEAPEST FALSIFIER: storage read / eth_call / unit test
- FALSIFIER RESULT: unrecorded | <value>
- HANDLERS: permissionless functions (required once REACHABLE)
- INVARIANT HARNESS: path (required once REACHABLE)
- CLASS: EXTRACT | GRIEF | PRIVILEGED | UNKNOWN
- BLOCKED BY: missing node / unknown behavior / none
- STATUS: INVENTED | PROBING | REACHABLE | UNREACHABLE | MONETIZABLE | KILLED
```

A WITNESS that cannot become `assertTrue`/`assertGt` stays `INVENTED` and cannot promote to `PROBING`. Scaffold:

```
scripts/harness_init.sh <target-dir> --cx CX-001
```

Correct generator:

> Can total claims stay unchanged while redeemable assets decrease?

Wrong generator:

> Check for rounding bugs.

## Iteration

```
invent pairing CX → cheapest probe → record result → invent or mutate → if blocked, expand map → reopen killed.md
```

Do not pause synthesis until `protocol-model.md` is campaign-complete. Grow the model when the construction needs a named promise, condition, or accounting identity.

## Promotion

A REACHABLE card must map to an invariant / handler set (`references/invariant-fuzz.md`) before it is allowed to stay REACHABLE.

A REACHABLE card with a monetization path and `CLASS: EXTRACT` becomes `H-###` in `hypotheses.md`. The hypothesis names `CX-###` and, if it exists, `PROM-###`.

UNREACHABLE after a real probe is not a failure of the method. Record why. Mutate the state. Kill only after the mutations in `07-mutation.md`.
