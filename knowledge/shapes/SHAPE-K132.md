# SHAPE-K132 — Identity that passed a check is not the identity that receives value (nft seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: address that satisfied the predicate vs address that is paid or credited
- SEAMS: `nft`, `payments`, `privilege`
- CONSTRUCTION: Satisfy a signature, merkle proof, or owner check, then set recipient / token / handler to an attacker-controlled address. Valid-action sketch from this seam: a permissionless actor reaches transferFrom, mint, burn, transfer, each call returning success.
- WITNESS: payer != recipient relative to the check that passed AND value moved
- MONETIZATION / KILL: Attacker receives the transfer. Dies if recipient is bound into the checked digest.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 16778, 16825, 18411, 18412, 18427, 19440, 19668, 20753; severity High; PoC present: yes; cluster size 8. Distilled, not a report dump.
