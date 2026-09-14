# SHAPE-K189 — Payment obligation exists without a remaining entitlement (privilege seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: payout / release path still live vs claim already burned or assigned away
- SEAMS: `privilege`, `amm`, `payments`, `vault`
- CONSTRUCTION: Burn, transfer, or cancel the claim, then still take the payout path. Valid-action sketch from this seam: a permissionless actor reaches transfer, approve, deposit, withdraw, each call returning success.
- WITNESS: claim burned AND payout path still transferable
- MONETIZATION / KILL: Collect the second payout. Dies if payout burns the same id it releases.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 4592, 4724, 18273, 18638, 20755, 21789, 22226; severity High; PoC present: yes; cluster size 7. Distilled, not a report dump.
