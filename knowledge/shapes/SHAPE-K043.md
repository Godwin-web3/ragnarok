# SHAPE-K043 — Authorization in A, execution in B via deposit

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: identity / nonce / context that passed the check vs identity / nonce / context that received the write
- SEAMS: `vault`, `privilege`, `amm`, `payments`
- CONSTRUCTION: Pass a check against one caller, signature, or allowance, then land the value movement on a different subject. Valid-action sketch from this seam: a permissionless actor reaches deposit, transfer, each call returning success.
- WITNESS: auth.context != execution.context AND value moved
- MONETIZATION / KILL: The unauthorized subject keeps the value. Dies if the execution binds the same bytes the check hashed.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 11382, 17901, 18573, 18585, 19101, 19298, 19303, 19550, 20610, 20620, 20811, 20917; severity Critical; PoC present: yes; cluster size 16. Distilled, not a report dump.
