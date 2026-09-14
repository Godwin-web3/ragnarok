# SHAPE-K271 — A time lock, cooldown, or expiry is true in storage and false at the write

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: stored unlock time / expiry / cooldown vs write that still moves value
- SEAMS: `bridge`, `privilege`, `payments`
- CONSTRUCTION: Call before unlock, after expiry, or by changing the clock source the check does not read.
- WITNESS: block.timestamp < unlockTime AND withdraw succeeded (or expired==true AND settle succeeded)
- MONETIZATION / KILL: Early exit or stale right. Dies if every write uses the same clock and inclusive bound.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 17036; severity Medium; PoC present: yes; cluster size 1. Distilled, not a report dump.
