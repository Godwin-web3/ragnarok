# SHAPE-K069 — Claims stay constant while redeemable assets fall (staking seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: claim / share / ticket ledger vs custody token / redeemable backing
- SEAMS: `staking`, `vault`, `accounting`
- CONSTRUCTION: A permissionless actor moves backing out along a path that does not burn matching claims, or burns claims without releasing backing. Each call returns success.
- WITNESS: claimSupply unchanged AND custodyBalance down (or inverse) AND last call success
- MONETIZATION / KILL: Redeem or liquidate the leftover claim. Dies if burn and release are one atomic conservation write.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 22254, 23548; severity High; PoC present: yes; cluster size 2. Distilled, not a report dump.
