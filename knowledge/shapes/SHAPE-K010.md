# SHAPE-K010 — Pool reserves and LP claims disagree after a valid swap, mint, or hook (vault seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: reserve / tick / inventory vs LP shares / position accounting
- SEAMS: `vault`, `stablecoin`, `privilege`, `amm`
- CONSTRUCTION: Swap, donate, or hook-write so reserves move without matching LP burns (or LP burns without reserve movement). Valid-action sketch from this seam: a permissionless actor reaches approve, initialize, removeLiquidity, each call returning success.
- WITNESS: reserveDelta and lpDelta have opposite economic sign AND both calls succeeded
- MONETIZATION / KILL: Drain reserves against stale LP math. Dies if every reserve write updates LP invariant in the same function.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 964, 1710, 2468, 2584, 2615, 2619, 2621, 2622, 4969, 7219, 7294, 8245; severity Critical; PoC present: yes; cluster size 34. Distilled, not a report dump.
