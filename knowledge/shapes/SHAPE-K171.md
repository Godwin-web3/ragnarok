# SHAPE-K171 — Custody of a unique token diverges from the rental or borrow right that should control it (privilege seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: ERC-721 / ERC-1155 owner vs rental / borrow / listing record
- SEAMS: `privilege`, `amm`, `nft`, `callback`
- CONSTRUCTION: During a callback or handler change, take the NFT while the listing still believes it is escrowed (or the reverse). Valid-action sketch from this seam: a permissionless actor reaches transfer, initialize, each call returning success.
- WITNESS: nft.ownerOf(id) != escrow.record.owner AND rental/borrow still ACTIVE
- MONETIZATION / KILL: Keep the NFT and the payment stream. Dies if custody and the right update in one non-callback-capable write.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 1351, 1589, 4309, 5494, 17034, 17085, 17236, 18956, 20743; severity Critical; PoC present: yes; cluster size 9. Distilled, not a report dump.
