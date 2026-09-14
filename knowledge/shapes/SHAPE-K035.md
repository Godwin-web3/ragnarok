# SHAPE-K035 — Authorization in A, execution in B (stablecoin seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: identity / nonce / context that passed the check vs identity / nonce / context that received the write
- SEAMS: `stablecoin`, `privilege`, `amm`, `staking`
- CONSTRUCTION: Pass a check against one caller, signature, or allowance, then land the value movement on a different subject.
- WITNESS: auth.context != execution.context AND value moved
- MONETIZATION / KILL: The unauthorized subject keeps the value. Dies if the execution binds the same bytes the check hashed.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 10549, 18480, 18628, 18689, 19318, 20641, 20834, 20900, 20965, 21151, 21189, 21242; severity High; PoC present: yes; cluster size 15. Distilled, not a report dump.
