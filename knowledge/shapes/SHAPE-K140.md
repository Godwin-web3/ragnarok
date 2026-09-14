# SHAPE-K140 — Identity that passed a check is not the identity that receives value (vault seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: address that satisfied the predicate vs address that is paid or credited
- SEAMS: `vault`, `privilege`, `staking`, `payments`
- CONSTRUCTION: Satisfy a signature, merkle proof, or owner check, then set recipient / token / handler to an attacker-controlled address. Valid-action sketch from this seam: a permissionless actor reaches initialize, mint, approve, stake, each call returning success.
- WITNESS: payer != recipient relative to the check that passed AND value moved
- MONETIZATION / KILL: Attacker receives the transfer. Dies if recipient is bound into the checked digest.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 19, 1414, 2048, 2063, 2383, 17259, 17999, 18010, 18018, 18676, 19665, 19676; severity High; PoC present: yes; cluster size 20. Distilled, not a report dump.
