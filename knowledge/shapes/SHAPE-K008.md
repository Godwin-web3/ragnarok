# SHAPE-K008 — Pool reserves and LP claims disagree after a valid swap, mint, or hook (stablecoin seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: reserve / tick / inventory vs LP shares / position accounting
- SEAMS: `stablecoin`, `amm`, `lending`, `privilege`
- CONSTRUCTION: Swap, donate, or hook-write so reserves move without matching LP burns (or LP burns without reserve movement). Valid-action sketch from this seam: a permissionless actor reaches mint, deposit, each call returning success.
- WITNESS: reserveDelta and lpDelta have opposite economic sign AND both calls succeeded
- MONETIZATION / KILL: Drain reserves against stale LP math. Dies if every reserve write updates LP invariant in the same function.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 923, 931, 1105, 1486, 1902, 3516, 3552, 3959, 4222, 4906, 4968, 7386; severity Critical; PoC present: yes; cluster size 28. Distilled, not a report dump.
