# SHAPE-K030 — Authorization in A, execution in B via initialize

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: identity / nonce / context that passed the check vs identity / nonce / context that received the write
- SEAMS: `privilege`, `amm`, `payments`, `nft`
- CONSTRUCTION: Pass a check against one caller, signature, or allowance, then land the value movement on a different subject. Valid-action sketch from this seam: a permissionless actor reaches initialize, transfer, approve, transferFrom, each call returning success.
- WITNESS: auth.context != execution.context AND value moved
- MONETIZATION / KILL: The unauthorized subject keeps the value. Dies if the execution binds the same bytes the check hashed.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 913, 1083, 1345, 1383, 1529, 1554, 1735, 2084, 2636, 3672, 4581, 4726; severity Critical; PoC present: yes; cluster size 20. Distilled, not a report dump.
