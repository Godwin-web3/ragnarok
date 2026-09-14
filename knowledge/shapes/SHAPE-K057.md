# SHAPE-K057 — A documented cap, floor, or uniqueness bound is not the bound the write path honors

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: documented / stored cap or unique id vs actual minted, withdrawn, or accepted amount
- SEAMS: `privilege`, `accounting`
- CONSTRUCTION: Mint, withdraw, or register past the cap, or reuse an id the spec says is unique.
- WITNESS: writtenAmount > cap (or duplicate id accepted) AND call success
- MONETIZATION / KILL: Over-mint or double-register. Dies if the write checks the same cap it increments, atomically.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 6313, 23391; severity High; PoC present: yes; cluster size 2. Distilled, not a report dump.
