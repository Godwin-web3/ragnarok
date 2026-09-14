# SHAPE-K072 — Claims stay constant while redeemable assets fall via mint

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: claim / share / ticket ledger vs custody token / redeemable backing
- SEAMS: `vault`, `privilege`, `accounting`, `amm`
- CONSTRUCTION: A permissionless actor moves backing out along a path that does not burn matching claims, or burns claims without releasing backing. Each call returns success. Valid-action sketch from this seam: a permissionless actor reaches mint, approve, deposit, redeem, each call returning success.
- WITNESS: claimSupply unchanged AND custodyBalance down (or inverse) AND last call success
- MONETIZATION / KILL: Redeem or liquidate the leftover claim. Dies if burn and release are one atomic conservation write.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 11372, 11374, 11381, 11434, 11447, 14019, 16870, 16872, 17129, 17134, 17137, 17908; severity High; PoC present: yes; cluster size 37. Distilled, not a report dump.
