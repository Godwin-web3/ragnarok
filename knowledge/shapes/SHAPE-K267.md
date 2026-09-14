# SHAPE-K267 — Supply and backing move in opposite directions on a conservation-neutral user action (lending seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: totalSupply / shares vs totalAssets / collateral
- SEAMS: `lending`, `vault`, `accounting`
- CONSTRUCTION: A deposit, withdraw, or harvest that should be value-neutral mints claims or leaks backing. Valid-action sketch from this seam: a permissionless actor reaches borrow, repay, approve, mint, each call returning success.
- WITNESS: user action AND totalSupply up AND totalAssets down (or inverse)
- MONETIZATION / KILL: Inflated shares redeem more than deposited. Dies if the action writes both sides with the same amount.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 19109; severity High; PoC present: yes; cluster size 1. Distilled, not a report dump.
