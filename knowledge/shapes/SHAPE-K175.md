# SHAPE-K175 — A one-shot right can be consumed twice across two adapters

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: consumed receipt on adapter A vs still-live receipt on adapter B / legacy path
- SEAMS: `lending`, `amm`, `payments`, `bridge`
- CONSTRUCTION: Settle once through the new door, again through the old door (or two tokens, two chains, two entrypoints).
- WITNESS: two successful value-outs for one burned-in
- MONETIZATION / KILL: Double settlement. Dies if one spent-id namespace is shared.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 3676; severity High; PoC present: yes; cluster size 1. Distilled, not a report dump.
