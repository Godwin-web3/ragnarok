# SHAPE-K009 — Pool reserves and LP claims disagree after a valid swap, mint, or hook (staking seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: reserve / tick / inventory vs LP shares / position accounting
- SEAMS: `staking`, `amm`
- CONSTRUCTION: Swap, donate, or hook-write so reserves move without matching LP burns (or LP burns without reserve movement).
- WITNESS: reserveDelta and lpDelta have opposite economic sign AND both calls succeeded
- MONETIZATION / KILL: Drain reserves against stale LP math. Dies if every reserve write updates LP invariant in the same function.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 17086, 17257; severity High; PoC present: yes; cluster size 2. Distilled, not a report dump.
