# Contradiction + representation data model

Canonical artifacts: `research/contradictions.md`, `research/representations.md`.

## IDs

| ID | Lives in | Meaning |
| :--- | :--- | :--- |
| `FACT-###` | representations.md | One protocol fact with multiple ledgers |
| `CX-###` | contradictions.md | An invented world that should be unreachable |
| `H-###` | hypotheses.md | A promoted construction with a test plan |
| `PROM-###` | protocol-model.md | Optional link once the model exists |

## Required CX fields

| Field | Rule |
| :--- | :--- |
| STATE | Simultaneously true predicates |
| CONTRADICTION | Two facts that should not coexist |
| PAIRING | Two components. At least one live card must have this. |
| WITNESS | Assertable expression. Prose is refused. |
| MONETIZATION | Who captures or absorbs value |
| CHEAPEST FALSIFIER | Smallest check |
| FALSIFIER RESULT | Required to invent another live card while PROBING |
| HANDLERS / INVARIANT HARNESS | Required to remain REACHABLE |
| CLASS | EXTRACT / GRIEF / PRIVILEGED / UNKNOWN |
| STATUS | See promotion |

## Promotion

```
FACT divergence suspected
  → CX card (INVENTED) with assertable WITNESS
  → cheapest probe (PROBING) only if WITNESS compiles to an assert
  → REACHABLE | UNREACHABLE | BLOCKED
  → if REACHABLE: map HANDLERS + invariant harness; fuzzer tries to walk in
  → if REACHABLE and CLASS EXTRACT and monetizable → H-###
  → runtime + economic (flashloan/capital, atomicity, exit liquidity, MEV/keeper, extract not grief) → CONFIRMED
```

WITNESS that cannot become an assert: the card **stays INVENTED**. It cannot become PROBING.

GRIEF and PRIVILEGED never promote into the permissionless CONFIRMED queue.

A CX card may exist before `PROM-###` exists. When the construction needs a named promise, write it into `protocol-model.md` and link it. Do not invent the promise first as a way to delay the card.

## Focus lock

Live statuses: `INVENTED`, `PROBING`, `REACHABLE` without a kill outcome.

- Max 2 live cards.
- Max 1 open probe.
- No new live card until `FALSIFIER RESULT` is recorded on the open probe.

`scripts/gate_check.sh` enforces this.
