# SHAPE-K210 — Price used to create a position is not the price that keeps the system solvent (privilege seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: mark used to mint / borrow / open vs mark used to liquidate / redeem / settle
- SEAMS: `privilege`, `amm`, `oracle`, `lending`
- CONSTRUCTION: Open a position against one feed or spot, then settle against a different feed, a stale round, or a mark the opener can push.
- WITNESS: mintPrice != solvencyPrice AND position created AND later settle succeeds
- MONETIZATION / KILL: Extract the wedge between the two marks. Dies if both paths read the same bounded feed with the same heartbeat.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 1371, 8792, 17059, 17217, 18333, 18378, 18384, 18385, 18400, 18448, 19065, 19414; severity Critical; PoC present: yes; cluster size 19. Distilled, not a report dump.
