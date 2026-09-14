# SHAPE-K128 — Yield or harvest credits a ledger that cannot be the depositor's claim (vault seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: harvest / reward / leftover accounting vs share / convertToAssets claim
- SEAMS: `vault`, `privilege`, `staking`, `amm`
- CONSTRUCTION: Call harvest, notify, or distribute so value lands in a leftover, fee, or unseen-reward bucket that redeem does not follow.
- WITNESS: harvest increased leftover AND convertToAssets(shares) did not
- MONETIZATION / KILL: Claim the leftover via the sibling path. Dies if harvest mints shares or raises convertToAssets for holders.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 1550, 2406, 5039, 8512, 18026, 19054, 19066, 19587, 21702, 21793; severity High; PoC present: yes; cluster size 10. Distilled, not a report dump.
