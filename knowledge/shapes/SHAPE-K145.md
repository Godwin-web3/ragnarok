# SHAPE-K145 — Keeper or permissioned settle that a permissionless actor can force-order to capture value (oracle seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: keeper / solver / cranker expected order vs permissionless sandwich or same-tx top
- SEAMS: `oracle`, `privilege`, `lending`, `staking`
- CONSTRUCTION: Observe a profitable keeper action and wrap it atomically, or prevent it until a private order lands. Valid-action sketch from this seam: a permissionless actor reaches approve, deposit, each call returning success.
- WITNESS: same-tx ordering captures value that a delayed keeper would have denied
- MONETIZATION / KILL: MEV on the settle. Dies if the profit requires a privileged key the program treats as trusted (then PRIVILEGED/GRIEF, not EXTRACT).
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 23434; severity High; PoC present: yes; cluster size 1. Distilled, not a report dump.
