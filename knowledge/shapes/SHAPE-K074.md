# SHAPE-K074 — Claims stay constant while redeemable assets fall via settle

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: claim / share / ticket ledger vs custody token / redeemable backing
- SEAMS: `vault`, `payments`, `oracle`, `lending`
- CONSTRUCTION: A permissionless actor moves backing out along a path that does not burn matching claims, or burns claims without releasing backing. Each call returns success.
- WITNESS: claimSupply unchanged AND custodyBalance down (or inverse) AND last call success
- MONETIZATION / KILL: Redeem or liquidate the leftover claim. Dies if burn and release are one atomic conservation write.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 17893, 17899, 17900, 18037, 18045, 18054, 18992, 18994, 19064, 19091, 19172, 19448; severity High; PoC present: yes; cluster size 16. Distilled, not a report dump.
