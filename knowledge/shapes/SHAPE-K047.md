# SHAPE-K047 — Authorization in A, execution in B (vault #5)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: identity / nonce / context that passed the check vs identity / nonce / context that received the write
- SEAMS: `vault`, `payments`, `privilege`, `oracle`
- CONSTRUCTION: Pass a check against one caller, signature, or allowance, then land the value movement on a different subject.
- WITNESS: auth.context != execution.context AND value moved
- MONETIZATION / KILL: The unauthorized subject keeps the value. Dies if the execution binds the same bytes the check hashed.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 19095, 19140, 19452, 20328, 20922, 21552; severity High; PoC present: yes; cluster size 6. Distilled, not a report dump.
