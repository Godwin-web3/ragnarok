# SHAPE-K282 — An unsolicited transfer changes a rate used by a later mint without minting shares

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: totalAssets after raw transfer vs totalSupply unchanged
- SEAMS: `amm`, `staking`, `accounting`, `vault`
- CONSTRUCTION: Transfer tokens directly to the vault/pool, then mint at the new rate. Valid-action sketch from this seam: a permissionless actor reaches claim, deposit, stake, each call returning success.
- WITNESS: totalAssets up with totalSupply unchanged, then mint cheaper than before
- MONETIZATION / KILL: Next minter is diluted or the donor extracts via a sandwich mint. Dies if donations mint shares or are excluded from the rate.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 21349; severity High; PoC present: yes; cluster size 1. Distilled, not a report dump.
