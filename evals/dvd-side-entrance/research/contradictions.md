# Contradictions

## CX-001 — pool ETH book vs deposit ledger

- STATE: After a flash loan, `address(pool).balance >= balanceBefore` and `balances[attacker] == amount_borrowed` at the same time.
- CONTRADICTION: Flash-loan repayment is defined as pool ETH not dropping. Deposit credits a personal claim on that same ETH. One unit of ETH satisfies both books.
- PAIRING: `address(pool).balance` ↔ `balances[msg.sender]`.
- CONSTRUCTION: `flashLoan` sends ETH to the receiver. Receiver `deposit{value: msg.value}()`. Pool ETH returns. Ledger credits the receiver. Receiver `withdraw()`.
- SEQUENCE:
  1. Pool holds 1000 ETH. No deposits.
  2. Attacker `flashLoan(1000 ether)`.
  3. Callback `deposit{value: 1000 ether}()`.
  4. Repay check passes.
  5. `withdraw()` takes 1000 ETH.
- WITNESS: After attack, `address(pool).balance == 0` and attacker/recovery holds the 1000 ETH.
- MONETIZATION: `withdraw()` transfers pool ETH to the attacker. CLASS EXTRACT.
- CHEAPEST FALSIFIER: `test_witness_deposit_ledger_desyncs_from_pool_eth`.
- FALSIFIER RESULT: PASS. Pool drained. Player received 1000 ETH.
- KILL: Keeping the flash-loaned ETH without deposit must fail `RepayFailed`. `test_kill_flashLoan_without_deposit_must_repay` PASS.
- CLASS: EXTRACT
- STATUS: REACHABLE / CONFIRMED on local harness
