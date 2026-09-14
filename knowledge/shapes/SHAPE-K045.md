# SHAPE-K045 — Authorization in A, execution in B (vault #3)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: identity / nonce / context that passed the check vs identity / nonce / context that received the write
- SEAMS: `vault`, `payments`, `privilege`, `amm`
- CONSTRUCTION: Pass a check against one caller, signature, or allowance, then land the value movement on a different subject. Valid-action sketch from this seam: a permissionless actor reaches mint, approve, unlock, each call returning success.
- WITNESS: auth.context != execution.context AND value moved
- MONETIZATION / KILL: The unauthorized subject keeps the value. Dies if the execution binds the same bytes the check hashed.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 7469, 11439, 14509, 17163, 17253, 17270, 18272, 18995, 19058, 19089, 22923, 23255; severity High; PoC present: yes; cluster size 12. Distilled, not a report dump.
