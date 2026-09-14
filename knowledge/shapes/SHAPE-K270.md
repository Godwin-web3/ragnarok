# SHAPE-K270 — Supply and backing move in opposite directions on a conservation-neutral user action (vault seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: totalSupply / shares vs totalAssets / collateral
- SEAMS: `vault`, `amm`, `accounting`, `privilege`
- CONSTRUCTION: A deposit, withdraw, or harvest that should be value-neutral mints claims or leaks backing.
- WITNESS: user action AND totalSupply up AND totalAssets down (or inverse)
- MONETIZATION / KILL: Inflated shares redeem more than deposited. Dies if the action writes both sides with the same amount.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 4817, 4827, 14151, 18517, 20413, 20972, 22573, 23362; severity Critical; PoC present: yes; cluster size 8. Distilled, not a report dump.
