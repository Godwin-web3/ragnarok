# Experiment — CX-001

Runtime: Foundry 1.8.3, solc 0.8.25
Date: 2026-09-17

Source of the check (DVD):

```
uint256 balanceBefore = totalAssets();
if (convertToShares(totalSupply) != balanceBefore) revert InvalidBalance();
```

Harness is a mechanism replica of that gate plus ERC4626-style `convertToShares`. It is not the full DVD repo with solmate/openzeppelin deps.

```
forge test -vv
[PASS] test_witness_donation_breaks_share_token_pairing()
[PASS] test_kill_zero_donation_does_not_break()
```

Witness after `token.transfer(vault, 1 ether)`:
`convertToShares(totalSupply) != totalAssets()`
Then `flashLoan(1 ether)` reverts `InvalidBalance`.
