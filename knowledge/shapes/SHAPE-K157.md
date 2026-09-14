# SHAPE-K157 — Two components each locally conservative, jointly creating unbacked claims (signature seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: invariant of component A vs invariant of component B
- SEAMS: `signature`, `accounting`, `callback`
- CONSTRUCTION: Drive A and B through internally-legal calls whose composition mints value from nowhere.
- WITNESS: A.ok AND B.ok AND systemClaims > systemAssets
- MONETIZATION / KILL: Redeem the joint surplus. Dies if a system-level conservation identity is checked at the seam.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 22025; severity High; PoC present: yes; cluster size 1. Distilled, not a report dump.
