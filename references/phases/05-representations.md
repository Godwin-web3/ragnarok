# Semantic differential analysis

Load when the current seam has a fact that more than one component records.

This is not a new protocol-model file. It is a table of how the same fact is represented in different places.

## Job

For every important fact on the current seam, write one block in `research/representations.md`:

```
## FACT-001 — <plain-language fact>
- Token / balance:
- Shares / internal accounting:
- Claim / ticket / receipt:
- Settlement / owed:
- Oracle / price used as if it were this fact:
- Actual transferable assets:
- Divergence possible?:
- What would make two rows disagree while each function still returns success?
```

## Offensive question

> Can an attacker cause any two representations to diverge while every individual function still behaves "correctly"?

That divergence is a `CX-###` candidate. Do not name a bug class here.

## Rules

- Start with the facts the current construction needs. Do not catalog every variable in the repo.
- If two rows already disagree on deployment, that is a lead. Record it. Do not assume it is intended.
- If a representation lives in an unmapped contract, add the node to the map, then continue.
- "Looks the same in comments" is not a representation. Cite the storage slot, return value, or event.
