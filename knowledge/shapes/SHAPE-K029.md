# SHAPE-K029 — Authorization in A, execution in B (privilege seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: identity / nonce / context that passed the check vs identity / nonce / context that received the write
- SEAMS: `privilege`, `payments`, `nft`, `amm`
- CONSTRUCTION: Pass a check against one caller, signature, or allowance, then land the value movement on a different subject.
- WITNESS: auth.context != execution.context AND value moved
- MONETIZATION / KILL: The unauthorized subject keeps the value. Dies if the execution binds the same bytes the check hashed.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 1667, 1694, 2927, 4765, 4910, 4994, 5881, 8612, 11420, 11428, 11492, 11503; severity Critical; PoC present: yes; cluster size 39. Distilled, not a report dump.
