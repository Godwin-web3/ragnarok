# SHAPE-K077 — Empty, dust, or first-actor rate lets the next actor's claim dominate (vault seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: near-zero denominator / first shares vs subsequent minter's claim on real assets
- SEAMS: `vault`, `stablecoin`, `amm`, `accounting`
- CONSTRUCTION: Donate, withdraw to dust, or be first depositor so convertToShares becomes extreme, then mint cheaply against donated backing. Valid-action sketch from this seam: a permissionless actor reaches deposit, approve, transfer, each call returning success.
- WITNESS: convertToShares(1) extreme AND attackerShares / totalShares high
- MONETIZATION / KILL: Attacker owns almost all redeemable assets. Dies if virtual shares/assets floor the rate, or first deposit is seeded.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 1427, 3950, 7382, 18020, 20424, 20674, 22789, 23147; severity High; PoC present: yes; cluster size 8. Distilled, not a report dump.
