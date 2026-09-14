# SHAPE-K186 — Payment obligation exists without a remaining entitlement (bridge seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: payout / release path still live vs claim already burned or assigned away
- SEAMS: `bridge`, `privilege`, `amm`, `accounting`
- CONSTRUCTION: Burn, transfer, or cancel the claim, then still take the payout path. Valid-action sketch from this seam: a permissionless actor reaches unstake, withdraw, unwrap, approve, each call returning success.
- WITNESS: claim burned AND payout path still transferable
- MONETIZATION / KILL: Collect the second payout. Dies if payout burns the same id it releases.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 18219; severity High; PoC present: yes; cluster size 1. Distilled, not a report dump.
