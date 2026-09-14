# SHAPE-K281 — Two ledgers of the same fact disagree after every call returns success (vault seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: component A record of the fact vs component B record of the same fact
- SEAMS: `vault`, `oracle`, `privilege`, `amm`
- CONSTRUCTION: A sequence of valid calls updates one ledger and not the other. No function reverts. Valid-action sketch from this seam: a permissionless actor reaches initialize, mint, approve, each call returning success.
- WITNESS: reprA != reprB AND last call success
- MONETIZATION / KILL: Settle against the more favorable ledger. Dies if a single conservation identity is written in both places.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 1023, 9078, 11441, 18587, 20766, 21122, 23447, 23547, 23550, 23559, 23563, 23578; severity Critical; PoC present: yes; cluster size 13. Distilled, not a report dump.
