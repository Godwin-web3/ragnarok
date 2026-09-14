# PHASE 13 — Primitive expansion

When a vulnerability survives, stop treating it as a single bug. Name the primitive. Hunt every consumer of it on the map.

Examples: stale oracle → mint, redeem, liquidate, collateral, rewards, secondary markets. Share accounting error → deposit, withdraw, donation, rewards, liquidation, cross-market.

Each manifestation keeps its own status **and** evidence level. Write `research/survivors.md`. Growing the dive to a new consumer is required. Shrinking the map to the first hit is forbidden.

Adding a consumer often adds a node or entrypoint. That is map growth. `gate_check --write` will queue `killed.md` revisit-if items. Re-open before you declare the primitive locally dead.
