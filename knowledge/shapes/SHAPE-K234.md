# SHAPE-K234 — Recorded balance exceeds transferable balance via initialize

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: internal accounting balance vs token.balanceOf(this) / native backing
- SEAMS: `vault`, `privilege`, `staking`, `accounting`
- CONSTRUCTION: Credit an internal ledger from a donation, rebase, or failed transfer that does not actually move tokens in. Valid-action sketch from this seam: a permissionless actor reaches initialize, approve, deposit, stake, each call returning success.
- WITNESS: internalBal > token.balanceOf(this)
- MONETIZATION / KILL: Withdraw the recorded amount until custody is empty; later users are short. Dies if credits are `min(internal, actual)` at payout.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 18011, 18520, 22994; severity High; PoC present: yes; cluster size 3. Distilled, not a report dump.
