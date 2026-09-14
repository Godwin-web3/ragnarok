# SHAPE-K093 — Time or epoch boundary where a right survives into the next epoch's parameters (vault seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: right.epoch vs execution epoch rates / oracles / caps
- SEAMS: `vault`, `staking`, `oracle`, `payments`
- CONSTRUCTION: Acquire a right just before an epoch, round, or funding event; execute just after. Valid-action sketch from this seam: a permissionless actor reaches stake, transfer, approve, deposit, each call returning success.
- WITNESS: right.epoch < exec.epoch AND exec uses exec.epoch parameters
- MONETIZATION / KILL: Capture the parameter jump. Dies if execution uses the stored epoch's parameters.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 16883, 17341, 20842, 23455, 23534, 23556, 23571, 23577; severity High; PoC present: yes; cluster size 8. Distilled, not a report dump.
