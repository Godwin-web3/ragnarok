# SHAPE-K165 — Message or receipt accepted on one side without the lock or burn on the other (vault seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: message / receipt / validator signature on destination vs lock / burn / escrow on source
- SEAMS: `vault`, `bridge`, `accounting`
- CONSTRUCTION: Replay, forge, or reorder a message so destination mints or unlocks while source never committed. Valid-action sketch from this seam: a permissionless actor reaches approve, wrap, each call returning success.
- WITNESS: mint/unlock succeeded AND lock/burn on source is absent
- MONETIZATION / KILL: Minted destination assets are sold. Dies if destination verifies a source commitment that cannot be replayed.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 19068; severity High; PoC present: yes; cluster size 1. Distilled, not a report dump.
