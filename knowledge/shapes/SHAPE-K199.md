# SHAPE-K199 — A role that looks view-only writes a parameter that reprices claims (privilege seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: peripheral / keeper / strategy setter vs core rate / whitelist / oracle used at redeem
- SEAMS: `privilege`, `oracle`, `lending`, `amm`
- CONSTRUCTION: Call a 'helper' setter that is permissionless or weakly gated, then redeem or liquidate on the new number. Valid-action sketch from this seam: a permissionless actor reaches approve, deposit, each call returning success.
- WITNESS: non-admin call changed rate/whitelist AND redeem uses the new number
- MONETIZATION / KILL: Attacker reprices everyone else's claims. Dies if the setter is admin-only and out of bounty scope (then CLASS PRIVILEGED, not EXTRACT).
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 4998, 6379, 9968, 14072, 18784, 19090, 19216, 19409, 20649, 20941, 21794, 23123; severity Critical; PoC present: yes; cluster size 14. Distilled, not a report dump.
