# Contradiction + representation data model

Canonical artifacts: `research/contradictions.md`, `research/representations.md`.

## IDs

| ID | Lives in | Meaning |
| :--- | :--- | :--- |
| `FACT-###` | representations.md | One protocol fact with multiple ledgers |
| `CX-###` | contradictions.md | An invented world that should be unreachable |
| `H-###` | hypotheses.md | A promoted construction with a test plan |
| `PROM-###` | protocol-model.md | Optional link once the model exists |

## Promotion

```
FACT divergence suspected
  → CX card (INVENTED)
  → cheapest probe
  → REACHABLE | UNREACHABLE | BLOCKED
  → if REACHABLE and monetizable → H-###
  → runtime + economic → CONFIRMED
```

A CX card may exist before `PROM-###` exists. When the construction needs a named promise, write it into `protocol-model.md` and link it. Do not invent the promise first as a way to delay the card.
