# SHAPE-K200 — A role that looks view-only writes a parameter that reprices claims (stablecoin seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: peripheral / keeper / strategy setter vs core rate / whitelist / oracle used at redeem
- SEAMS: `stablecoin`, `privilege`, `amm`, `oracle`
- CONSTRUCTION: Call a 'helper' setter that is permissionless or weakly gated, then redeem or liquidate on the new number.
- WITNESS: non-admin call changed rate/whitelist AND redeem uses the new number
- MONETIZATION / KILL: Attacker reprices everyone else's claims. Dies if the setter is admin-only and out of bounty scope (then CLASS PRIVILEGED, not EXTRACT).
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 2475, 8468, 22347, 23487, 23513; severity High; PoC present: yes; cluster size 5. Distilled, not a report dump.
