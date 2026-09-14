# SHAPE-K068 — Claims stay constant while redeemable assets fall (stablecoin seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: claim / share / ticket ledger vs custody token / redeemable backing
- SEAMS: `stablecoin`, `lending`, `nft`, `vault`
- CONSTRUCTION: A permissionless actor moves backing out along a path that does not burn matching claims, or burns claims without releasing backing. Each call returns success. Valid-action sketch from this seam: a permissionless actor reaches deposit, mint, repay, each call returning success.
- WITNESS: claimSupply unchanged AND custodyBalance down (or inverse) AND last call success
- MONETIZATION / KILL: Redeem or liquidate the leftover claim. Dies if burn and release are one atomic conservation write.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 4213, 19600, 19616, 19621, 19810; severity Critical; PoC present: yes; cluster size 5. Distilled, not a report dump.
