# Answer key — do not load during a hunt

## Pairing

Pool ETH balance ↔ `balances[user]` deposit ledger.

## Impossible state

`address(pool).balance` is unchanged after a flash loan (repay check passes) while `balances[attacker]` equals the amount borrowed. The same ETH is counted as repaid liquidity and as an owned deposit.

## Witness

After `flashLoan(pool.balance)` whose callback calls `deposit{value: msg.value}()`:

```
address(pool).balance == balanceBefore
pool.balances(attacker) == balanceBefore
```

Then `withdraw()` sends `balanceBefore` to the attacker and pool ETH goes to 0.

## Class

EXTRACT.
