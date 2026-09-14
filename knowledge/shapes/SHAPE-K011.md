# SHAPE-K011 — Pool reserves and LP claims disagree after a valid swap, mint, or hook via borrow

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: reserve / tick / inventory vs LP shares / position accounting
- SEAMS: `vault`, `lending`, `amm`, `accounting`
- CONSTRUCTION: Swap, donate, or hook-write so reserves move without matching LP burns (or LP burns without reserve movement).
- WITNESS: reserveDelta and lpDelta have opposite economic sign AND both calls succeeded
- MONETIZATION / KILL: Drain reserves against stale LP math. Dies if every reserve write updates LP invariant in the same function.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 18581, 18650, 18999, 19205, 20406, 20710, 20827, 20831, 20884, 21724, 23155, 23164; severity Critical; PoC present: yes; cluster size 18. Distilled, not a report dump.
