# SHAPE-K026 — Authorization in A, execution in B (payments #2)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: identity / nonce / context that passed the check vs identity / nonce / context that received the write
- SEAMS: `payments`, `privilege`, `accounting`, `lending`
- CONSTRUCTION: Pass a check against one caller, signature, or allowance, then land the value movement on a different subject.
- WITNESS: auth.context != execution.context AND value moved
- MONETIZATION / KILL: The unauthorized subject keeps the value. Dies if the execution binds the same bytes the check hashed.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 2648, 5994, 7360, 7467, 17047, 17066, 18326, 18413, 18436; severity High; PoC present: yes; cluster size 9. Distilled, not a report dump.
