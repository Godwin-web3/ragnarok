# SHAPE-K209 — Price used to create a position is not the price that keeps the system solvent (payments seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: mark used to mint / borrow / open vs mark used to liquidate / redeem / settle
- SEAMS: `payments`, `lending`, `amm`, `nft`
- CONSTRUCTION: Open a position against one feed or spot, then settle against a different feed, a stale round, or a mark the opener can push.
- WITNESS: mintPrice != solvencyPrice AND position created AND later settle succeeds
- MONETIZATION / KILL: Extract the wedge between the two marks. Dies if both paths read the same bounded feed with the same heartbeat.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 1844, 1899, 2651, 15341, 16869, 17055, 19135, 19267, 20921, 21656, 21754, 21757; severity High; PoC present: yes; cluster size 17. Distilled, not a report dump.
