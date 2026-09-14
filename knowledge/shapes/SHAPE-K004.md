# SHAPE-K004 — Pool reserves and LP claims disagree after a valid swap, mint, or hook (lending seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: reserve / tick / inventory vs LP shares / position accounting
- SEAMS: `lending`, `amm`, `callback`, `accounting`
- CONSTRUCTION: Swap, donate, or hook-write so reserves move without matching LP burns (or LP burns without reserve movement).
- WITNESS: reserveDelta and lpDelta have opposite economic sign AND both calls succeeded
- MONETIZATION / KILL: Drain reserves against stale LP math. Dies if every reserve write updates LP invariant in the same function.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 1051, 1459, 1484, 3567, 3678, 4596, 17054, 18685, 18756, 23398; severity High; PoC present: yes; cluster size 10. Distilled, not a report dump.
