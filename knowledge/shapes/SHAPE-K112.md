# SHAPE-K112 — Flag says closed while a write path still treats the surface as open (privilege seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: initializer / migrated / disabled storage vs write entry that still succeeds
- SEAMS: `privilege`, `amm`, `nft`, `accounting`
- CONSTRUCTION: After initialize, migrate, or sunset, call the forbidden write (re-init, old mint, old settle). Valid-action sketch from this seam: a permissionless actor reaches transfer, initialize, transferFrom, each call returning success.
- WITNESS: initialized == true (or migrated == true) AND the forbidden write succeeded
- MONETIZATION / KILL: Re-init as owner or mint under old math. Dies if the flag gates every write, including inherited ones.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 3186, 4314, 4617, 4618, 4766, 4859, 4996, 5284, 5381, 5495, 6043, 9973; severity Critical; PoC present: yes; cluster size 33. Distilled, not a report dump.
