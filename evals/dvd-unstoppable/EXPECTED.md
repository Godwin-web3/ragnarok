# Answer key — do not load during a hunt

## Pairing

Vault share accounting ↔ ERC20 `balanceOf(vault)`.

## Impossible state

`convertToShares(totalSupply) != totalAssets()` while `flashLoan` still exists as an entrypoint.

`flashLoan` reads `totalAssets()` then reverts `InvalidBalance` unless that equality holds. Direct token transfer into the vault increases `totalAssets()` and does not mint shares. After one donation, every flash loan reverts.

## Witness

```
vault.convertToShares(vault.totalSupply()) != vault.totalAssets()
```

After `token.transfer(address(vault), amount)` with `amount > 0` and no `deposit`/`mint`.

## Sequence

1. Player holds DVT.
2. `token.transfer(vault, 1)` or any positive amount.
3. `vault.flashLoan(...)` reverts `InvalidBalance`.

## Class

GRIEF. Flash loans halt. The million DVT is not extracted by this path.

EXTRACT on this card is a fail.

## Kill checks

- Donation of 0 does not break the equality. Kill that mutation.
- Deposit/mint that credits shares should restore or preserve equality. If a deposit also breaks it, that is a different card.
