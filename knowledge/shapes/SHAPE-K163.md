# SHAPE-K163 — Message or receipt accepted on one side without the lock or burn on the other (privilege seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: message / receipt / validator signature on destination vs lock / burn / escrow on source
- SEAMS: `privilege`, `signature`, `bridge`, `nft`
- CONSTRUCTION: Replay, forge, or reorder a message so destination mints or unlocks while source never committed.
- WITNESS: mint/unlock succeeded AND lock/burn on source is absent
- MONETIZATION / KILL: Minted destination assets are sold. Dies if destination verifies a source commitment that cannot be replayed.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 2286, 3539, 4462, 17941, 17943, 18008, 20928; severity Critical; PoC present: yes; cluster size 7. Distilled, not a report dump.
