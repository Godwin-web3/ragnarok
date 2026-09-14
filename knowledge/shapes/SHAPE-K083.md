# SHAPE-K083 — Entitlement exists without a corresponding payment obligation (staking seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: live claim / ticket / share vs recorded obligation / escrow / backing
- SEAMS: `staking`, `vault`, `stablecoin`, `payments`
- CONSTRUCTION: Mint or transfer a claim along a path that never books who owes the backing.
- WITNESS: claim.balanceOf(user) > 0 AND escrow.owed == 0
- MONETIZATION / KILL: Redeem the unbacked claim. Dies if minting the claim always increments the obligation in the same call.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 19934; severity Medium; PoC present: yes; cluster size 1. Distilled, not a report dump.
