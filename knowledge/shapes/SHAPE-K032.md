# SHAPE-K032 — Authorization in A, execution in B via mint

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: identity / nonce / context that passed the check vs identity / nonce / context that received the write
- SEAMS: `privilege`, `payments`, `nft`, `staking`
- CONSTRUCTION: Pass a check against one caller, signature, or allowance, then land the value movement on a different subject. Valid-action sketch from this seam: a permissionless actor reaches mint, transfer, each call returning success.
- WITNESS: auth.context != execution.context AND value moved
- MONETIZATION / KILL: The unauthorized subject keeps the value. Dies if the execution binds the same bytes the check hashed.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 18235, 18440, 18534, 18594, 18829, 19211, 19434, 19535, 19667, 21383, 21618, 21662; severity High; PoC present: yes; cluster size 14. Distilled, not a report dump.
