# SHAPE-K056 — Burn without matching release, or release without matching burn (vault seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: token burn / lock vs collateral release / mint
- SEAMS: `vault`, `privilege`, `amm`, `callback`
- CONSTRUCTION: Trigger one side of a two-sided conservation law without the other.
- WITNESS: burned > 0 AND released == 0 (or the reverse) in the same sequence
- MONETIZATION / KILL: Keep both the claim and the backing, or neither. Dies if burn and release share one non-callback-capable conservation function.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 23390; severity High; PoC present: yes; cluster size 1. Distilled, not a report dump.
