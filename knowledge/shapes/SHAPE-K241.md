# SHAPE-K241 — Same intent settled twice after validator, implementation, or config change (bridge seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: spent receipt under old impl / signer set vs live receipt under new impl / signer set
- SEAMS: `bridge`, `privilege`, `signature`
- CONSTRUCTION: Consume a message, upgrade or rotate validators, then settle the same intent again.
- WITNESS: second settle/mint succeeded for the same intent id
- MONETIZATION / KILL: Replay across the upgrade. Dies if spent-ids live in a storage contract that survives the upgrade.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 23446, 23576; severity High; PoC present: yes; cluster size 2. Distilled, not a report dump.
