# SHAPE-K245 — Same intent settled twice after validator, implementation, or config change (vault seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: spent receipt under old impl / signer set vs live receipt under new impl / signer set
- SEAMS: `vault`, `payments`, `privilege`, `nft`
- CONSTRUCTION: Consume a message, upgrade or rotate validators, then settle the same intent again. Valid-action sketch from this seam: a permissionless actor reaches mint, transfer, each call returning success.
- WITNESS: second settle/mint succeeded for the same intent id
- MONETIZATION / KILL: Replay across the upgrade. Dies if spent-ids live in a storage contract that survives the upgrade.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 11760, 16773, 23554, 23568; severity High; PoC present: yes; cluster size 4. Distilled, not a report dump.
