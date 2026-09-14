# SHAPE-K208 — Price used to create a position is not the price that keeps the system solvent (oracle seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: mark used to mint / borrow / open vs mark used to liquidate / redeem / settle
- SEAMS: `oracle`, `lending`, `stablecoin`, `amm`
- CONSTRUCTION: Open a position against one feed or spot, then settle against a different feed, a stale round, or a mark the opener can push.
- WITNESS: mintPrice != solvencyPrice AND position created AND later settle succeeds
- MONETIZATION / KILL: Extract the wedge between the two marks. Dies if both paths read the same bounded feed with the same heartbeat.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 1217, 1347, 1352, 2469, 2643, 3438, 4575, 4749, 4818, 5314, 5329, 7506; severity Critical; PoC present: yes; cluster size 38. Distilled, not a report dump.
