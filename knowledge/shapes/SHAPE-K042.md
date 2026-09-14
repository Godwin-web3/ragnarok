# SHAPE-K042 — Authorization in A, execution in B via mint/approve

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: identity / nonce / context that passed the check vs identity / nonce / context that received the write
- SEAMS: `vault`, `privilege`, `payments`, `stablecoin`
- CONSTRUCTION: Pass a check against one caller, signature, or allowance, then land the value movement on a different subject. Valid-action sketch from this seam: a permissionless actor reaches mint, approve, deposit, redeem, each call returning success.
- WITNESS: auth.context != execution.context AND value moved
- MONETIZATION / KILL: The unauthorized subject keeps the value. Dies if the execution binds the same bytes the check hashed.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 5075, 5898, 8167, 9056, 11360, 11415, 11436, 11437, 11505, 18395, 19296, 20756; severity Critical; PoC present: yes; cluster size 16. Distilled, not a report dump.
