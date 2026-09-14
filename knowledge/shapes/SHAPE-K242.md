# SHAPE-K242 — Same intent settled twice after validator, implementation, or config change (payments seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: spent receipt under old impl / signer set vs live receipt under new impl / signer set
- SEAMS: `payments`, `nft`, `bridge`, `privilege`
- CONSTRUCTION: Consume a message, upgrade or rotate validators, then settle the same intent again.
- WITNESS: second settle/mint succeeded for the same intent id
- MONETIZATION / KILL: Replay across the upgrade. Dies if spent-ids live in a storage contract that survives the upgrade.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 6911; severity High; PoC present: yes; cluster size 1. Distilled, not a report dump.
