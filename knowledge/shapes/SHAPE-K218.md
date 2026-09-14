# SHAPE-K218 — A queued claim is transferable into a different backing or settlement state (lending seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: ticket at issuance vs backing / oracle / config at settlement
- SEAMS: `lending`, `payments`, `vault`, `stablecoin`
- CONSTRUCTION: Enter a queue or vest, transfer the ticket, then settle after backing, oracle, or cap changed.
- WITNESS: ticket.owner changed AND backingEpoch changed AND redeem succeeds
- MONETIZATION / KILL: The new owner redeems under richer backing. Dies if the ticket snapshots backing and settlement honors the snapshot.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 10201; severity High; PoC present: yes; cluster size 1. Distilled, not a report dump.
