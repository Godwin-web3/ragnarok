# SHAPE-K115 — Flag says closed while a write path still treats the surface as open (vault seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: initializer / migrated / disabled storage vs write entry that still succeeds
- SEAMS: `vault`, `privilege`, `staking`, `lending`
- CONSTRUCTION: After initialize, migrate, or sunset, call the forbidden write (re-init, old mint, old settle). Valid-action sketch from this seam: a permissionless actor reaches mint, approve, stake, unstake, each call returning success.
- WITNESS: initialized == true (or migrated == true) AND the forbidden write succeeded
- MONETIZATION / KILL: Re-init as owner or mint under old math. Dies if the flag gates every write, including inherited ones.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 10, 2437, 4552, 13871, 13874, 14016, 14219, 14223, 14594, 18074, 18126, 21978; severity Critical; PoC present: yes; cluster size 19. Distilled, not a report dump.
