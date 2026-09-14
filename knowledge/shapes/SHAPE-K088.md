# SHAPE-K088 — Time or epoch boundary where a right survives into the next epoch's parameters (oracle seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: right.epoch vs execution epoch rates / oracles / caps
- SEAMS: `oracle`, `payments`, `lending`
- CONSTRUCTION: Acquire a right just before an epoch, round, or funding event; execute just after. Valid-action sketch from this seam: a permissionless actor reaches Transfer, transferFrom, mint, each call returning success.
- WITNESS: right.epoch < exec.epoch AND exec uses exec.epoch parameters
- MONETIZATION / KILL: Capture the parameter jump. Dies if execution uses the stored epoch's parameters.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 1333, 1334, 1336, 16102, 17353, 18124, 18251, 18295; severity High; PoC present: yes; cluster size 8. Distilled, not a report dump.
