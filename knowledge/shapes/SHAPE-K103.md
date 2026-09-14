# SHAPE-K103 — Fast path updates a subset of the state the slow path updates (payments seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: short-circuit writes vs full-path conservation writes
- SEAMS: `payments`, `staking`, `accounting`, `vault`
- CONSTRUCTION: Take the helper / cache / multiHop / zap path that skips a write the canonical path uses as conservation.
- WITNESS: after fast path, slow-path storage field unchanged AND value moved
- MONETIZATION / KILL: The skipped write is the one that would have billed the attacker. Dies if both paths share one internal settle.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 6347, 19069, 19074; severity High; PoC present: yes; cluster size 3. Distilled, not a report dump.
