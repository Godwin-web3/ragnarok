# SHAPE-K025 — Authorization in A, execution in B via transfer/execute

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: identity / nonce / context that passed the check vs identity / nonce / context that received the write
- SEAMS: `payments`, `privilege`, `amm`, `callback`
- CONSTRUCTION: Pass a check against one caller, signature, or allowance, then land the value movement on a different subject. Valid-action sketch from this seam: a permissionless actor reaches transfer, execute, cancel, each call returning success.
- WITNESS: auth.context != execution.context AND value moved
- MONETIZATION / KILL: The unauthorized subject keeps the value. Dies if the execution binds the same bytes the check hashed.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 900, 1923, 2465, 3479, 4763, 4977, 5933, 8168, 16847, 18013; severity Critical; PoC present: yes; cluster size 10. Distilled, not a report dump.
