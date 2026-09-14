# SHAPE-K182 — Pause or kill-switch blocks the documented path but not a value-moving sibling (privilege seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: paused / guardian flag vs sibling entry that still moves claims or assets
- SEAMS: `privilege`, `signature`, `nft`, `callback`
- CONSTRUCTION: Set or observe paused=true, then call harvest, donate, settle, or a legacy entry.
- WITNESS: paused() == true AND sibling call moved value
- MONETIZATION / KILL: Value leaves during the emergency. Dies if every value-moving entry reads the same flag first.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 11501, 18458, 18773, 18957, 19586, 21007; severity High; PoC present: yes; cluster size 6. Distilled, not a report dump.
