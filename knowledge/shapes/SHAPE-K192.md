# SHAPE-K192 — Payment obligation exists without a remaining entitlement (vault seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: payout / release path still live vs claim already burned or assigned away
- SEAMS: `vault`, `privilege`, `callback`, `payments`
- CONSTRUCTION: Burn, transfer, or cancel the claim, then still take the payout path. Valid-action sketch from this seam: a permissionless actor reaches approve, transfer, transferFrom, each call returning success.
- WITNESS: claim burned AND payout path still transferable
- MONETIZATION / KILL: Collect the second payout. Dies if payout burns the same id it releases.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 1544, 2011, 2160, 2428, 3637, 4823, 6451, 7383, 15404, 16853, 17132, 18294; severity High; PoC present: yes; cluster size 15. Distilled, not a report dump.
