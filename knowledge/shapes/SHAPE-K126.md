# SHAPE-K126 — Yield or harvest credits a ledger that cannot be the depositor's claim (stablecoin seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: harvest / reward / leftover accounting vs share / convertToAssets claim
- SEAMS: `stablecoin`, `staking`, `callback`, `accounting`
- CONSTRUCTION: Call harvest, notify, or distribute so value lands in a leftover, fee, or unseen-reward bucket that redeem does not follow.
- WITNESS: harvest increased leftover AND convertToAssets(shares) did not
- MONETIZATION / KILL: Claim the leftover via the sibling path. Dies if harvest mints shares or raises convertToAssets for holders.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 1077, 18478, 19387, 22686, 23113, 23444; severity High; PoC present: yes; cluster size 6. Distilled, not a report dump.
