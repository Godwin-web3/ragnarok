# SHAPE-K052 — Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (privilege seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: debt share / borrowed amount vs collateral posted / seized
- SEAMS: `privilege`, `accounting`, `lending`, `oracle`
- CONSTRUCTION: Borrow, lever, or liquidate along a path that updates one side of health and not the other.
- WITNESS: debt > 0 AND collateral backing that debt == 0 (or collateral seized AND debt unchanged)
- MONETIZATION / KILL: Bad debt socialized, or seized collateral kept while debt remains. Dies if health is re-checked after both writes.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 19450, 23413; severity High; PoC present: yes; cluster size 2. Distilled, not a report dump.
