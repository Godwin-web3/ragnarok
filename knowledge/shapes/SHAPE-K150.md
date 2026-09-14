# SHAPE-K150 — Legacy path still ACTIVE after new accounting took over

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: v1 entry still callable vs v2 ledger / assumption
- SEAMS: `amm`, `privilege`, `vault`
- CONSTRUCTION: After migration, call the old mint, settle, or withdraw that still writes value under v2's assumptions.
- WITNESS: v1 call succeeded AND v2 conservation broken
- MONETIZATION / KILL: Old math against new backing. Dies if v1 is bricked (selfdestruct, flag, or removed selector) on the live deployment.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 20894; severity Medium; PoC present: yes; cluster size 1. Distilled, not a report dump.
