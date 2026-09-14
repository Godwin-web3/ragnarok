# SHAPE-K232 — Recorded balance exceeds transferable balance (vault seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: internal accounting balance vs token.balanceOf(this) / native backing
- SEAMS: `vault`, `lending`, `amm`, `accounting`
- CONSTRUCTION: Credit an internal ledger from a donation, rebase, or failed transfer that does not actually move tokens in.
- WITNESS: internalBal > token.balanceOf(this)
- MONETIZATION / KILL: Withdraw the recorded amount until custody is empty; later users are short. Dies if credits are `min(internal, actual)` at payout.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 994, 1182, 1216, 2601, 4979, 7624, 9874, 17110, 17890, 18108, 18310, 19378; severity Critical; PoC present: yes; cluster size 14. Distilled, not a report dump.
