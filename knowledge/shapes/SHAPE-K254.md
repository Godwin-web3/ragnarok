# SHAPE-K254 — Liquidation or redemption uses a mark a same-tx actor can move (privilege seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: spot / reserve / tick the actor just pushed vs liquidation / redeem / mint using that mark
- SEAMS: `privilege`, `nft`, `accounting`, `oracle`
- CONSTRUCTION: Move a thin pool or manipulate a readable reserve, then liquidate or redeem in the same transaction.
- WITNESS: attacker-moved reserve AND liquidation using that reserve in the same tx
- MONETIZATION / KILL: Seize collateral or mint against the pushed mark. Dies if the mark is a bounded TWAP or an external heartbeat feed.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 15342, 16788; severity High; PoC present: yes; cluster size 2. Distilled, not a report dump.
