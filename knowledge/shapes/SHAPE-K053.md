# SHAPE-K053 — Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (stablecoin seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: debt share / borrowed amount vs collateral posted / seized
- SEAMS: `stablecoin`, `payments`, `privilege`, `lending`
- CONSTRUCTION: Borrow, lever, or liquidate along a path that updates one side of health and not the other. Valid-action sketch from this seam: a permissionless actor reaches initialize, mint, approve, borrow, each call returning success.
- WITNESS: debt > 0 AND collateral backing that debt == 0 (or collateral seized AND debt unchanged)
- MONETIZATION / KILL: Bad debt socialized, or seized collateral kept while debt remains. Dies if health is re-checked after both writes.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 4305, 4558, 19596, 19601, 21534; severity High; PoC present: yes; cluster size 5. Distilled, not a report dump.
