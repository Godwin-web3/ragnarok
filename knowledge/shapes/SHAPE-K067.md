# SHAPE-K067 — Claims stay constant while redeemable assets fall (privilege seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: claim / share / ticket ledger vs custody token / redeemable backing
- SEAMS: `privilege`, `staking`, `vault`, `accounting`
- CONSTRUCTION: A permissionless actor moves backing out along a path that does not burn matching claims, or burns claims without releasing backing. Each call returns success. Valid-action sketch from this seam: a permissionless actor reaches claim, Mint, Burn, approve, each call returning success.
- WITNESS: claimSupply unchanged AND custodyBalance down (or inverse) AND last call success
- MONETIZATION / KILL: Redeem or liquidate the leftover claim. Dies if burn and release are one atomic conservation write.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 18068, 19328, 23431; severity High; PoC present: yes; cluster size 3. Distilled, not a report dump.
