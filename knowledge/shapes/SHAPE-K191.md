# SHAPE-K191 — Payment obligation exists without a remaining entitlement (staking seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: payout / release path still live vs claim already burned or assigned away
- SEAMS: `staking`, `payments`, `vault`, `signature`
- CONSTRUCTION: Burn, transfer, or cancel the claim, then still take the payout path. Valid-action sketch from this seam: a permissionless actor reaches approve, stake, unstake, each call returning success.
- WITNESS: claim burned AND payout path still transferable
- MONETIZATION / KILL: Collect the second payout. Dies if payout burns the same id it releases.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 8158, 18351; severity High; PoC present: yes; cluster size 2. Distilled, not a report dump.
