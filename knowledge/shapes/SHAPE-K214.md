# SHAPE-K214 — Price used to create a position is not the price that keeps the system solvent (vault #2)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: mark used to mint / borrow / open vs mark used to liquidate / redeem / settle
- SEAMS: `vault`, `payments`, `privilege`, `lending`
- CONSTRUCTION: Open a position against one feed or spot, then settle against a different feed, a stale round, or a mark the opener can push.
- WITNESS: mintPrice != solvencyPrice AND position created AND later settle succeeds
- MONETIZATION / KILL: Extract the wedge between the two marks. Dies if both paths read the same bounded feed with the same heartbeat.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 18217, 18224, 19051, 19141, 19183, 19532, 20377, 20824, 20920, 21198, 21199, 21238; severity High; PoC present: yes; cluster size 24. Distilled, not a report dump.
