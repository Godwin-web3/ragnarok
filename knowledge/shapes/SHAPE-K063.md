# SHAPE-K063 — A check's meaning is invalidated between pass and settlement (stablecoin seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: predicate snapshot at check vs predicate at value movement
- SEAMS: `stablecoin`, `staking`, `callback`, `payments`
- CONSTRUCTION: Pass a balance, allowance, health, or uniqueness check, then (same transaction or next) change the world before settlement via callback, hook, or later call. Valid-action sketch from this seam: a permissionless actor reaches transfer, approve, stake, claim, each call returning success.
- WITNESS: check-time snapshot != settle-time snapshot AND settle succeeded
- MONETIZATION / KILL: Settlement honors a predicate that is no longer true. Dies if settlement re-reads and re-checks the same storage.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 3958, 7029, 16961, 17025, 18765, 18892; severity Critical; PoC present: yes; cluster size 6. Distilled, not a report dump.
