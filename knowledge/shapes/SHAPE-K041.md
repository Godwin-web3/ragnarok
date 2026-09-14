# SHAPE-K041 — Authorization in A, execution in B via approve/deposit

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: identity / nonce / context that passed the check vs identity / nonce / context that received the write
- SEAMS: `vault`, `privilege`, `amm`, `callback`
- CONSTRUCTION: Pass a check against one caller, signature, or allowance, then land the value movement on a different subject. Valid-action sketch from this seam: a permissionless actor reaches approve, deposit, each call returning success.
- WITNESS: auth.context != execution.context AND value moved
- MONETIZATION / KILL: The unauthorized subject keeps the value. Dies if the execution binds the same bytes the check hashed.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 6012, 7154, 7388, 9774, 9857, 13873, 13875, 14015, 17140, 17141, 17269, 18592; severity High; PoC present: yes; cluster size 18. Distilled, not a report dump.
