# Answer key — do not load during a hunt

## Pairing

Token balance repay check ↔ target call executed as the pool.

## Impossible state

`token.balanceOf(pool)` is unchanged at end of `flashLoan` while `token.allowance(pool, attacker) == poolBalance`. Authorization to move the tokens was granted by the pool itself.

## Witness

`flashLoan(0, attacker, token, approve(attacker, amount))` then `transferFrom(pool, attacker, amount)`.

## Class

EXTRACT.
