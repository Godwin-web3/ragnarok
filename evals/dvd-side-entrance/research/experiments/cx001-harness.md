# Experiment — CX-001

Runtime: Foundry 1.8.3, solc 0.8.25
Date: 2026-09-17

DVD repay check:

```
uint256 balanceBefore = address(this).balance;
IFlashLoanEtherReceiver(msg.sender).execute{value: amount}();
if (address(this).balance < balanceBefore) revert RepayFailed();
```

Deposit writes a second book:

```
balances[msg.sender] += msg.value;
```

```
forge test -vv
[PASS] test_witness_deposit_ledger_desyncs_from_pool_eth()
[PASS] test_kill_flashLoan_without_deposit_must_repay()
```

Pool starts at 1000 ETH. After attack, pool is 0 and recovery holds 1000 ETH.
