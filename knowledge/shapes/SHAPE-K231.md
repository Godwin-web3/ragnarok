# SHAPE-K231 — Recorded balance exceeds transferable balance (staking seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: internal accounting balance vs token.balanceOf(this) / native backing
- SEAMS: `staking`, `vault`, `accounting`
- CONSTRUCTION: Credit an internal ledger from a donation, rebase, or failed transfer that does not actually move tokens in.
- WITNESS: internalBal > token.balanceOf(this)
- MONETIZATION / KILL: Withdraw the recorded amount until custody is empty; later users are short. Dies if credits are `min(internal, actual)` at payout.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 23; severity High; PoC present: yes; cluster size 1. Distilled, not a report dump.
