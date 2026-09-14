# SHAPE-K090 — Time or epoch boundary where a right survives into the next epoch's parameters (privilege seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: right.epoch vs execution epoch rates / oracles / caps
- SEAMS: `privilege`, `amm`, `accounting`, `oracle`
- CONSTRUCTION: Acquire a right just before an epoch, round, or funding event; execute just after.
- WITNESS: right.epoch < exec.epoch AND exec uses exec.epoch parameters
- MONETIZATION / KILL: Capture the parameter jump. Dies if execution uses the stored epoch's parameters.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 21678, 22019; severity Medium; PoC present: yes; cluster size 2. Distilled, not a report dump.
