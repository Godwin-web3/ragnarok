# SHAPE-K114 — Flag says closed while a write path still treats the surface as open (stablecoin seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: initializer / migrated / disabled storage vs write entry that still succeeds
- SEAMS: `stablecoin`, `privilege`, `amm`, `accounting`
- CONSTRUCTION: After initialize, migrate, or sunset, call the forbidden write (re-init, old mint, old settle). Valid-action sketch from this seam: a permissionless actor reaches reBalance, swap, each call returning success.
- WITNESS: initialized == true (or migrated == true) AND the forbidden write succeeded
- MONETIZATION / KILL: Re-init as owner or mint under old math. Dies if the flag gates every write, including inherited ones.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 9886, 11102, 18802, 19043, 23009, 23280, 23281, 23317, 23321, 23322; severity Critical; PoC present: yes; cluster size 10. Distilled, not a report dump.
