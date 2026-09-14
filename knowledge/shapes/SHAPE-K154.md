# SHAPE-K154 — Two components each locally conservative, jointly creating unbacked claims (nft seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: invariant of component A vs invariant of component B
- SEAMS: `nft`, `accounting`, `callback`
- CONSTRUCTION: Drive A and B through internally-legal calls whose composition mints value from nowhere. Valid-action sketch from this seam: a permissionless actor reaches burn, mint, each call returning success.
- WITNESS: A.ok AND B.ok AND systemClaims > systemAssets
- MONETIZATION / KILL: Redeem the joint surplus. Dies if a system-level conservation identity is checked at the seam.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 6368, 22388; severity High; PoC present: yes; cluster size 2. Distilled, not a report dump.
