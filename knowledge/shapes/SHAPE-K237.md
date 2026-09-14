# SHAPE-K237 — Refund or cancel does not restore the original claim, or restores it twice (payments seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: original claim / escrow vs post-unwind claim / escrow
- SEAMS: `payments`, `amm`, `privilege`, `nft`
- CONSTRUCTION: Cancel, abort, or refund a filled or partially filled action.
- WITNESS: after unwind, claim != original by more than fees (duplicate or zero)
- MONETIZATION / KILL: Duplicate claim is redeemed, or the user is zeroed and the leftover sits in the contract. Dies if unwind is the inverse of the original writes.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 13482, 15819, 17001, 17218, 22649, 23125, 23463; severity High; PoC present: yes; cluster size 7. Distilled, not a report dump.
