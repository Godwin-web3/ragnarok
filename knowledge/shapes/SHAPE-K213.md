# SHAPE-K213 — Price used to create a position is not the price that keeps the system solvent (vault seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: mark used to mint / borrow / open vs mark used to liquidate / redeem / settle
- SEAMS: `vault`, `stablecoin`, `oracle`, `amm`
- CONSTRUCTION: Open a position against one feed or spot, then settle against a different feed, a stale round, or a mark the opener can push. Valid-action sketch from this seam: a permissionless actor reaches mint, approve, deposit, transfer, each call returning success.
- WITNESS: mintPrice != solvencyPrice AND position created AND later settle succeeds
- MONETIZATION / KILL: Extract the wedge between the two marks. Dies if both paths read the same bounded feed with the same heartbeat.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 2616, 3967, 4550, 4783, 4814, 6163, 7521, 12356, 13863, 15975, 16873, 17185; severity Critical; PoC present: yes; cluster size 29. Distilled, not a report dump.
