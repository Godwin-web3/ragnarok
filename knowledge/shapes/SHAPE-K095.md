# SHAPE-K095 — Two representations of the same fact can diverge while every individual function returns success (lending seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: the protocol's recorded fact vs the transferable or redeemable fact
- SEAMS: `lending`, `accounting`
- CONSTRUCTION: Sequence valid user actions on this seam until two components disagree about the same fact.
- WITNESS: reprA != reprB AND last call success
- MONETIZATION / KILL: Settle against the more favorable representation. Dies if a conservation identity is checked at the seam.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 10187; severity High; PoC present: yes; cluster size 1. Distilled, not a report dump.
