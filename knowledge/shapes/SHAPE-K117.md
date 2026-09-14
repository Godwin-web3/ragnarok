# SHAPE-K117 — Prepaid execution credit and actual settlement charge disagree, moving value (payments seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: deposited / prepaid gas or fee credit vs amount actually charged or refunded at settle
- SEAMS: `payments`, `bridge`, `privilege`, `amm`
- CONSTRUCTION: Force a remote call, fallback, or retry so the credit is over-refunded or under-charged until custody drains. Valid-action sketch from this seam: a permissionless actor reaches mint, approve, Bridge, each call returning success.
- WITNESS: refunded > prepaid - actualCost AND custody fell (or charge skipped AND call succeeded)
- MONETIZATION / KILL: Drain the gas tank or make peers pay. Dies if charge uses a measured cost bounded by the prepaid amount.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 1680, 2892, 18574; severity High; PoC present: yes; cluster size 3. Distilled, not a report dump.
