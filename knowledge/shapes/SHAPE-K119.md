# SHAPE-K119 — Yield or harvest credits a ledger that cannot be the depositor's claim

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: harvest / reward / leftover accounting vs share / convertToAssets claim
- SEAMS: `amm`, `vault`, `staking`, `accounting`
- CONSTRUCTION: Call harvest, notify, or distribute so value lands in a leftover, fee, or unseen-reward bucket that redeem does not follow.
- WITNESS: harvest increased leftover AND convertToAssets(shares) did not
- MONETIZATION / KILL: Claim the leftover via the sibling path. Dies if harvest mints shares or raises convertToAssets for holders.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 1052, 1555, 4963, 14053, 14054, 18129, 18437, 18527, 20612, 20623, 22016, 22459; severity Critical; PoC present: yes; cluster size 12. Distilled, not a report dump.
