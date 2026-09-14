# SHAPE-K134 — Identity that passed a check is not the identity that receives value (payments seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: address that satisfied the predicate vs address that is paid or credited
- SEAMS: `payments`, `nft`, `privilege`, `amm`
- CONSTRUCTION: Satisfy a signature, merkle proof, or owner check, then set recipient / token / handler to an attacker-controlled address.
- WITNESS: payer != recipient relative to the check that passed AND value moved
- MONETIZATION / KILL: Attacker receives the transfer. Dies if recipient is bound into the checked digest.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 17, 20, 1437, 1591, 1891, 3906, 5890, 7151, 16534, 16913, 16960, 18012; severity High; PoC present: yes; cluster size 20. Distilled, not a report dump.
