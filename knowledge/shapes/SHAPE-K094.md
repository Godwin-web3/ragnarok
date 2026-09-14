# SHAPE-K094 — Two representations of the same fact can diverge while every individual function returns success

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: the protocol's recorded fact vs the transferable or redeemable fact
- SEAMS: `accounting`
- CONSTRUCTION: Sequence valid user actions on this seam until two components disagree about the same fact.
- WITNESS: reprA != reprB AND last call success
- MONETIZATION / KILL: Settle against the more favorable representation. Dies if a conservation identity is checked at the seam.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 1169, 1314, 1332, 1384, 1516, 1822, 2072, 4865, 4877, 5737, 5738, 7384; severity Critical; PoC present: yes; cluster size 41. Distilled, not a report dump.
