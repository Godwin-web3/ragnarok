# SHAPE-K070 — Claims stay constant while redeemable assets fall (vault seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: claim / share / ticket ledger vs custody token / redeemable backing
- SEAMS: `vault`, `oracle`, `lending`, `accounting`
- CONSTRUCTION: A permissionless actor moves backing out along a path that does not burn matching claims, or burns claims without releasing backing. Each call returns success. Valid-action sketch from this seam: a permissionless actor reaches transfer, deposit, each call returning success.
- WITNESS: claimSupply unchanged AND custodyBalance down (or inverse) AND last call success
- MONETIZATION / KILL: Redeem or liquidate the leftover claim. Dies if burn and release are one atomic conservation write.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 972, 973, 985, 1048, 1428, 1452, 1618, 1699, 1718, 1719, 1835, 1941; severity Critical; PoC present: yes; cluster size 48. Distilled, not a report dump.
