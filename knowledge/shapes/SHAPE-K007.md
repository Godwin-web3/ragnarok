# SHAPE-K007 — Pool reserves and LP claims disagree after a valid swap, mint, or hook (privilege seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: reserve / tick / inventory vs LP shares / position accounting
- SEAMS: `privilege`, `staking`, `amm`, `lending`
- CONSTRUCTION: Swap, donate, or hook-write so reserves move without matching LP burns (or LP burns without reserve movement). Valid-action sketch from this seam: a permissionless actor reaches mint, approve, stake, each call returning success.
- WITNESS: reserveDelta and lpDelta have opposite economic sign AND both calls succeeded
- MONETIZATION / KILL: Drain reserves against stale LP math. Dies if every reserve write updates LP invariant in the same function.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 1376, 1823, 1885, 2440, 2628, 4723, 4771, 7180, 13866, 17252, 18109, 18344; severity High; PoC present: yes; cluster size 18. Distilled, not a report dump.
