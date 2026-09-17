# Contradictions

## CX-001 — DEX spot vs pool solvency

- STATE: After a one-sided swap on the oracle pair, `calculateDepositRequired(pool.tokenBalance)` is payable with the player's starting ETH, and `borrow` transfers the pool inventory.
- CONTRADICTION: Solvency is priced from a thin spot. The pool's token inventory is not that spot. Price and backing diverge.
- PAIRING: `uniswapPair.balance / token.balanceOf(pair)` ↔ pool DVT inventory.
- CONSTRUCTION: Sell 1000 DVT into a 10 ETH / 10 DVT pair. Price collapses. Borrow 100_000 DVT with the leftover ETH.
- SEQUENCE:
  1. Pair 10/10. Pool 100_000 DVT. Player 1000 DVT + 25 ETH.
  2. `tokenToEth(1000 DVT)`.
  3. `borrow(100_000 DVT)` with `depositRequired` after the dump.
- WITNESS: `token.balanceOf(pool) == 0` and player holds the 100_000 DVT.
- MONETIZATION: `borrow` transfers pool tokens. EXTRACT.
- CHEAPEST FALSIFIER: `test_witness_spot_price_desyncs_from_solvency`.
- FALSIFIER RESULT: PASS.
- KILL: Same borrow at the unmanipulated price reverts `NotEnoughCollateral`. PASS.
- CLASS: EXTRACT
- STATUS: CONFIRMED on local harness
