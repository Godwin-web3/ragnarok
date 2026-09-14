# SHAPE-K278 — Two ledgers of the same fact disagree after every call returns success (payments seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: component A record of the fact vs component B record of the same fact
- SEAMS: `payments`, `bridge`, `accounting`, `privilege`
- CONSTRUCTION: A sequence of valid calls updates one ledger and not the other. No function reverts. Valid-action sketch from this seam: a permissionless actor reaches mint, approve, deposit, each call returning success.
- WITNESS: reprA != reprB AND last call success
- MONETIZATION / KILL: Settle against the more favorable ledger. Dies if a single conservation identity is written in both places.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 3566, 18584, 21398, 21831; severity High; PoC present: yes; cluster size 4. Distilled, not a report dump.
