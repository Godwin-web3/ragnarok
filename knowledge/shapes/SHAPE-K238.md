# SHAPE-K238 — Refund or cancel does not restore the original claim, or restores it twice (privilege seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: original claim / escrow vs post-unwind claim / escrow
- SEAMS: `privilege`, `payments`
- CONSTRUCTION: Cancel, abort, or refund a filled or partially filled action. Valid-action sketch from this seam: a permissionless actor reaches execute, cancel, each call returning success.
- WITNESS: after unwind, claim != original by more than fees (duplicate or zero)
- MONETIZATION / KILL: Duplicate claim is redeemed, or the user is zeroed and the leftover sits in the contract. Dies if unwind is the inverse of the original writes.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 5930; severity High; PoC present: yes; cluster size 1. Distilled, not a report dump.
