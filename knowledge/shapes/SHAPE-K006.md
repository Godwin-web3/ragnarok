# SHAPE-K006 — Pool reserves and LP claims disagree after a valid swap, mint, or hook (payments seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: reserve / tick / inventory vs LP shares / position accounting
- SEAMS: `payments`, `oracle`, `privilege`, `lending`
- CONSTRUCTION: Swap, donate, or hook-write so reserves move without matching LP burns (or LP burns without reserve movement). Valid-action sketch from this seam: a permissionless actor reaches approve, deposit, claim, each call returning success.
- WITNESS: reserveDelta and lpDelta have opposite economic sign AND both calls succeeded
- MONETIZATION / KILL: Drain reserves against stale LP math. Dies if every reserve write updates LP invariant in the same function.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 1026, 1220, 2078, 4722, 4985, 15816, 18291, 18724, 19495, 21623, 21652, 22627; severity High; PoC present: yes; cluster size 12. Distilled, not a report dump.
