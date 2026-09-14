# SHAPE-K036 — Authorization in A, execution in B via approve

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: identity / nonce / context that passed the check vs identity / nonce / context that received the write
- SEAMS: `stablecoin`, `payments`, `lending`, `amm`
- CONSTRUCTION: Pass a check against one caller, signature, or allowance, then land the value movement on a different subject. Valid-action sketch from this seam: a permissionless actor reaches approve, repay, each call returning success.
- WITNESS: auth.context != execution.context AND value moved
- MONETIZATION / KILL: The unauthorized subject keeps the value. Dies if the execution binds the same bytes the check hashed.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 1480, 1741, 1836, 2905, 7017, 17061, 18379, 18438, 19098, 19366, 19492, 19642; severity High; PoC present: yes; cluster size 12. Distilled, not a report dump.
