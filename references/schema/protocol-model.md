# Protocol-model data model

Canonical artifact: `research/protocol-model.md`.
Do not split this into sibling model files.

## Identity rules

| ID | Lives in | Meaning |
| :--- | :--- | :--- |
| `ACT-###` | protocol-model.md | Participant who holds or honors a claim |
| `PROM-###` | protocol-model.md | Statement the protocol makes to an actor |
| `COND-###` | protocol-model.md | Required condition not already an `ASM-###` |
| `ST-###` | protocol-model.md | Named state transition |
| `ACC-###` | protocol-model.md | Accounting identity not already an `INV-###` |
| `ASM-###` | assumptions.md | Reused, never copied |
| `INV-###` | invariants.md | Reused, never copied |

A required condition is valid only if it points at an `ASM-###` that exists in `assumptions.md` or a `COND-###` in this file that carries an evidence-level `Provenance`.

An accounting link is valid only if it points at an `INV-###` that exists in `invariants.md` or an `ACC-###` in this file that names `Variables`.

A state-transition link is valid only if it points at an `ST-###` in this file that names `Who can trigger`.

## Intersection with the rest of the ledger

```
deployment.md     → which transitions are ACTIVE
architecture.md   → actor and component names must already be on the map
assumptions.md    → provenance for required conditions
invariants.md     → accounting identities that are already reconstructed
leads.md          → observations noticed while filling the model
hypotheses.md     → each H-### should name the PROM-### it tries to break
```

If a promise names a component or address absent from `architecture.md`, grow the map. Do not invent a parallel cast.

## Criticality

Omit `Critical?:` and the record is treated as critical. Mark `Critical?: no` only for non-economic observers (indexers, off-chain reporters with no claim).

## Falsification plan vs Phase 11

Phase 5 records the cheapest check that would show the promise is unhonored (storage slot, one `eth_call`, unit test). That is not RUNTIME_VERIFIED. Phase 11 is still mandatory after a surviving experiment.
