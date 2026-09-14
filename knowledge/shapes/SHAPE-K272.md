# SHAPE-K272 — A time lock, cooldown, or expiry is true in storage and false at the write (privilege seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: stored unlock time / expiry / cooldown vs write that still moves value
- SEAMS: `privilege`, `staking`, `payments`
- CONSTRUCTION: Call before unlock, after expiry, or by changing the clock source the check does not read.
- WITNESS: block.timestamp < unlockTime AND withdraw succeeded (or expired==true AND settle succeeded)
- MONETIZATION / KILL: Early exit or stale right. Dies if every write uses the same clock and inclusive bound.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 17337, 20934; severity High; PoC present: yes; cluster size 2. Distilled, not a report dump.
