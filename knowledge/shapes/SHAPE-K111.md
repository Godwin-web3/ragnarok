# SHAPE-K111 — Flag says closed while a write path still treats the surface as open (payments seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: initializer / migrated / disabled storage vs write entry that still succeeds
- SEAMS: `payments`, `privilege`, `staking`, `callback`
- CONSTRUCTION: After initialize, migrate, or sunset, call the forbidden write (re-init, old mint, old settle).
- WITNESS: initialized == true (or migrated == true) AND the forbidden write succeeded
- MONETIZATION / KILL: Re-init as owner or mint under old math. Dies if the flag gates every write, including inherited ones.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 18415, 18563, 18828, 21384, 23614; severity High; PoC present: yes; cluster size 5. Distilled, not a report dump.
