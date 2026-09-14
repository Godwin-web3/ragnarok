# SHAPE-K158 — Two components each locally conservative, jointly creating unbacked claims (stablecoin seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: invariant of component A vs invariant of component B
- SEAMS: `stablecoin`, `amm`, `accounting`, `callback`
- CONSTRUCTION: Drive A and B through internally-legal calls whose composition mints value from nowhere. Valid-action sketch from this seam: a permissionless actor reaches transfer, approve, each call returning success.
- WITNESS: A.ok AND B.ok AND systemClaims > systemAssets
- MONETIZATION / KILL: Redeem the joint surplus. Dies if a system-level conservation identity is checked at the seam.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 19175; severity High; PoC present: yes; cluster size 1. Distilled, not a report dump.
