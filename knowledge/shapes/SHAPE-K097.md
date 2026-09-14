# SHAPE-K097 — Two representations of the same fact can diverge while every individual function returns success (privilege seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: the protocol's recorded fact vs the transferable or redeemable fact
- SEAMS: `privilege`, `staking`, `accounting`
- CONSTRUCTION: Sequence valid user actions on this seam until two components disagree about the same fact.
- WITNESS: reprA != reprB AND last call success
- MONETIZATION / KILL: Settle against the more favorable representation. Dies if a conservation identity is checked at the seam.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 5880, 8603, 11508, 11761, 18029, 18783, 19189, 19313, 20737, 21641, 22623, 23392; severity Critical; PoC present: yes; cluster size 13. Distilled, not a report dump.
