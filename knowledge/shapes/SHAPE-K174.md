# SHAPE-K174 — Custody of a unique token diverges from the rental or borrow right that should control it (vault seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: ERC-721 / ERC-1155 owner vs rental / borrow / listing record
- SEAMS: `vault`, `nft`, `callback`, `privilege`
- CONSTRUCTION: During a callback or handler change, take the NFT while the listing still believes it is escrowed (or the reverse).
- WITNESS: nft.ownerOf(id) != escrow.record.owner AND rental/borrow still ACTIVE
- MONETIZATION / KILL: Keep the NFT and the payment stream. Dies if custody and the right update in one non-callback-capable write.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 7864, 8246, 14017, 14018, 14221, 14222, 16824, 17187, 17325, 19093, 20963, 20964; severity Critical; PoC present: yes; cluster size 17. Distilled, not a report dump.
