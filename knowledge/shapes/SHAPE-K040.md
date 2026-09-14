# SHAPE-K040 — Authorization in A, execution in B (vault seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: identity / nonce / context that passed the check vs identity / nonce / context that received the write
- SEAMS: `vault`, `oracle`, `privilege`, `amm`
- CONSTRUCTION: Pass a check against one caller, signature, or allowance, then land the value movement on a different subject. Valid-action sketch from this seam: a permissionless actor reaches deposit, withdraw, redeem, transferFrom, each call returning success.
- WITNESS: auth.context != execution.context AND value moved
- MONETIZATION / KILL: The unauthorized subject keeps the value. Dies if the execution binds the same bytes the check hashed.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 958, 1057, 1338, 1430, 1904, 2227, 2365, 3996, 4551, 4573, 4752, 4796; severity High; PoC present: yes; cluster size 25. Distilled, not a report dump.
