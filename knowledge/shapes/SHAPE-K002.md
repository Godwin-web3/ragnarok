# SHAPE-K002 — Pool reserves and LP claims disagree after a valid swap, mint, or hook (amm seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: reserve / tick / inventory vs LP shares / position accounting
- SEAMS: `amm`, `staking`, `nft`, `callback`
- CONSTRUCTION: Swap, donate, or hook-write so reserves move without matching LP burns (or LP burns without reserve movement). Valid-action sketch from this seam: a permissionless actor reaches mint, approve, each call returning success.
- WITNESS: reserveDelta and lpDelta have opposite economic sign AND both calls succeeded
- MONETIZATION / KILL: Drain reserves against stale LP math. Dies if every reserve write updates LP invariant in the same function.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 924, 930, 1237, 1240, 1708, 4730, 4764, 4971, 9689, 11035, 11502, 15306; severity High; PoC present: yes; cluster size 41. Distilled, not a report dump.
