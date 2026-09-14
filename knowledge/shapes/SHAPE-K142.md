# SHAPE-K142 — Keeper or permissioned settle that a permissionless actor can force-order to capture value

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: keeper / solver / cranker expected order vs permissionless sandwich or same-tx top
- SEAMS: `amm`, `staking`, `payments`, `privilege`
- CONSTRUCTION: Observe a profitable keeper action and wrap it atomically, or prevent it until a private order lands.
- WITNESS: same-tx ordering captures value that a delayed keeper would have denied
- MONETIZATION / KILL: MEV on the settle. Dies if the profit requires a privileged key the program treats as trusted (then PRIVILEGED/GRIEF, not EXTRACT).
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 1206, 17133, 19171, 19499, 19593; severity High; PoC present: yes; cluster size 5. Distilled, not a report dump.
