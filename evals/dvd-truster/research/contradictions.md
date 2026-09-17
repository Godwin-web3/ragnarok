# Contradictions

## CX-001 — repay check vs pool-signed call

- STATE: After `flashLoan`, pool token balance is intact and `allowance(pool, attacker)` equals the pool balance.
- CONTRADICTION: Repayment is defined as token balance not dropping. The same function lets the pool execute arbitrary calldata. Approve is not a balance drop.
- PAIRING: `token.balanceOf(pool)` ↔ `target.call(data)` with pool as `msg.sender`.
- CONSTRUCTION: `flashLoan(0, player, token, approve(player, 1_000_000e18))` then `transferFrom`.
- SEQUENCE:
  1. Pool holds 1_000_000 DVT.
  2. Zero-amount flash loan.
  3. Data = `token.approve(player, type_or_balance)`.
  4. Repay check passes.
  5. Player `transferFrom` drains the pool.
- WITNESS: `token.balanceOf(player) == 1_000_000 ether` and pool is 0.
- MONETIZATION: `transferFrom` moves the pool inventory. EXTRACT.
- CHEAPEST FALSIFIER: `test_witness_approval_during_flashloan_extracts_pool`.
- FALSIFIER RESULT: PASS.
- KILL: A loan that does not restore the token balance reverts. `test_kill_flashloan_that_does_not_repay_fails` PASS.
- CLASS: EXTRACT
- STATUS: CONFIRMED on local harness
