# SHAPE-K092 — Time or epoch boundary where a right survives into the next epoch's parameters (staking seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: right.epoch vs execution epoch rates / oracles / caps
- SEAMS: `staking`, `oracle`, `payments`, `lending`
- CONSTRUCTION: Acquire a right just before an epoch, round, or funding event; execute just after.
- WITNESS: right.epoch < exec.epoch AND exec uses exec.epoch parameters
- MONETIZATION / KILL: Capture the parameter jump. Dies if execution uses the stored epoch's parameters.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 18576; severity High; PoC present: yes; cluster size 1. Distilled, not a report dump.
