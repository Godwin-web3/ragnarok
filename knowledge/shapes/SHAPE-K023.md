# SHAPE-K023 — Authorization in A, execution in B (payments seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: identity / nonce / context that passed the check vs identity / nonce / context that received the write
- SEAMS: `payments`, `lending`, `nft`, `accounting`
- CONSTRUCTION: Pass a check against one caller, signature, or allowance, then land the value movement on a different subject. Valid-action sketch from this seam: a permissionless actor reaches mint, cancel, transferFrom, each call returning success.
- WITNESS: auth.context != execution.context AND value moved
- MONETIZATION / KILL: The unauthorized subject keeps the value. Dies if the execution binds the same bytes the check hashed.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 7455, 11427, 12725, 12726, 12849, 14956, 15805, 17006, 17115, 18056, 18414, 18439; severity High; PoC present: yes; cluster size 21. Distilled, not a report dump.
