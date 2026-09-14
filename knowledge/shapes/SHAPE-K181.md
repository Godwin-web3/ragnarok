# SHAPE-K181 — Pause or kill-switch blocks the documented path but not a value-moving sibling (payments seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: paused / guardian flag vs sibling entry that still moves claims or assets
- SEAMS: `payments`, `privilege`, `nft`, `callback`
- CONSTRUCTION: Set or observe paused=true, then call harvest, donate, settle, or a legacy entry. Valid-action sketch from this seam: a permissionless actor reaches initialize, approve, each call returning success.
- WITNESS: paused() == true AND sibling call moved value
- MONETIZATION / KILL: Value leaves during the emergency. Dies if every value-moving entry reads the same flag first.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 47, 19297, 19675; severity High; PoC present: yes; cluster size 3. Distilled, not a report dump.
