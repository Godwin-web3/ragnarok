# SHAPE-K275 — Two ledgers of the same fact disagree after every call returns success (amm seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: component A record of the fact vs component B record of the same fact
- SEAMS: `amm`, `accounting`, `staking`
- CONSTRUCTION: A sequence of valid calls updates one ledger and not the other. No function reverts.
- WITNESS: reprA != reprB AND last call success
- MONETIZATION / KILL: Settle against the more favorable ledger. Dies if a single conservation identity is written in both places.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 4590, 23448, 23579; severity High; PoC present: yes; cluster size 3. Distilled, not a report dump.
