# SHAPE-K135 — Identity that passed a check is not the identity that receives value (payments #2)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: address that satisfied the predicate vs address that is paid or credited
- SEAMS: `payments`, `nft`, `privilege`, `amm`
- CONSTRUCTION: Satisfy a signature, merkle proof, or owner check, then set recipient / token / handler to an attacker-controlled address.
- WITNESS: payer != recipient relative to the check that passed AND value moved
- MONETIZATION / KILL: Attacker receives the transfer. Dies if recipient is bound into the checked digest.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 18383, 18410, 18649, 19446, 20650, 20667, 21017, 21620, 22351, 22363, 22385, 23347; severity High; PoC present: yes; cluster size 13. Distilled, not a report dump.
