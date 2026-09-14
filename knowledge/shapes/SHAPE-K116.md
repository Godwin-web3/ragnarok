# SHAPE-K116 — Prepaid execution credit and actual settlement charge disagree, moving value

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: deposited / prepaid gas or fee credit vs amount actually charged or refunded at settle
- SEAMS: `bridge`, `privilege`, `accounting`, `payments`
- CONSTRUCTION: Force a remote call, fallback, or retry so the credit is over-refunded or under-charged until custody drains. Valid-action sketch from this seam: a permissionless actor reaches transferFrom, transfer, approve, execute, each call returning success.
- WITNESS: refunded > prepaid - actualCost AND custody fell (or charge skipped AND call succeeded)
- MONETIZATION / KILL: Drain the gas tank or make peers pay. Dies if charge uses a measured cost bounded by the prepaid amount.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 13, 18620; severity High; PoC present: yes; cluster size 2. Distilled, not a report dump.
