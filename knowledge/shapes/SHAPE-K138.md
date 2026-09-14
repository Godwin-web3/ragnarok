# SHAPE-K138 — Identity that passed a check is not the identity that receives value (stablecoin seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: address that satisfied the predicate vs address that is paid or credited
- SEAMS: `stablecoin`, `payments`, `privilege`, `nft`
- CONSTRUCTION: Satisfy a signature, merkle proof, or owner check, then set recipient / token / handler to an attacker-controlled address. Valid-action sketch from this seam: a permissionless actor reaches mint, approve, redeem, each call returning success.
- WITNESS: payer != recipient relative to the check that passed AND value moved
- MONETIZATION / KILL: Attacker receives the transfer. Dies if recipient is bound into the checked digest.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 1920, 3603, 4904, 5372, 5989, 19614, 19643, 20643, 21531, 21533, 21711, 21722; severity Critical; PoC present: yes; cluster size 13. Distilled, not a report dump.
