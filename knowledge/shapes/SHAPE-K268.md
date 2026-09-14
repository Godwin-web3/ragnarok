# SHAPE-K268 — Supply and backing move in opposite directions on a conservation-neutral user action (privilege seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: totalSupply / shares vs totalAssets / collateral
- SEAMS: `privilege`, `accounting`, `vault`, `lending`
- CONSTRUCTION: A deposit, withdraw, or harvest that should be value-neutral mints claims or leaks backing.
- WITNESS: user action AND totalSupply up AND totalAssets down (or inverse)
- MONETIZATION / KILL: Inflated shares redeem more than deposited. Dies if the action writes both sides with the same amount.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 16075, 16686, 18451, 19496; severity High; PoC present: yes; cluster size 4. Distilled, not a report dump.
