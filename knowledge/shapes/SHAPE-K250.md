# SHAPE-K250 — Rounding direction on a conservation-neutral action creates or destroys value (vault seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: amount in (deposited, burned, paid) vs amount out (minted, released, received)
- SEAMS: `vault`, `accounting`
- CONSTRUCTION: Repeat a tiny action, or take a path that always rounds in the actor's favor, until claims exceed backing.
- WITNESS: sum(out) > sum(in) by more than dust across the sequence AND each call succeeded
- MONETIZATION / KILL: Accumulate the dust into extractable size. Dies if rounding favors the protocol on every value-out.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 5891, 19094, 20420; severity High; PoC present: yes; cluster size 3. Distilled, not a report dump.
