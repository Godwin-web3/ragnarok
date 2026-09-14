# SHAPE-K024 — Authorization in A, execution in B via transfer

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: identity / nonce / context that passed the check vs identity / nonce / context that received the write
- SEAMS: `payments`, `privilege`, `amm`, `bridge`
- CONSTRUCTION: Pass a check against one caller, signature, or allowance, then land the value movement on a different subject.
- WITNESS: auth.context != execution.context AND value moved
- MONETIZATION / KILL: The unauthorized subject keeps the value. Dies if the execution binds the same bytes the check hashed.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 15900, 18099, 18432, 18921, 19108, 19185, 19302, 19456, 20642, 21532, 22557; severity High; PoC present: yes; cluster size 11. Distilled, not a report dump.
