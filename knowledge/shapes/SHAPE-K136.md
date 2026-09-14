# SHAPE-K136 — Identity that passed a check is not the identity that receives value (privilege seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: address that satisfied the predicate vs address that is paid or credited
- SEAMS: `privilege`, `payments`, `nft`, `amm`
- CONSTRUCTION: Satisfy a signature, merkle proof, or owner check, then set recipient / token / handler to an attacker-controlled address. Valid-action sketch from this seam: a permissionless actor reaches mint, approve, each call returning success.
- WITNESS: payer != recipient relative to the check that passed AND value moved
- MONETIZATION / KILL: Attacker receives the transfer. Dies if recipient is bound into the checked digest.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 1590, 4588, 10901, 14855, 16779, 16977, 17175, 18467, 18791, 18977, 19053, 19439; severity Critical; PoC present: yes; cluster size 21. Distilled, not a report dump.
