# Architecture

## Component graph
Component | Type | Address | Role | Trusts | Trusted by
--- | --- | --- | --- | --- | ---
UnstoppableVault | ERC4626 + IERC3156 | challenge | custody + shares + flash loans | DVT, borrower callback | Player, Monitor
UnstoppableMonitor | watcher | challenge | observes flash-loan health | Vault | Challenge setup
DVT | ERC20 | challenge | underlying | — | Vault, Player
Player | EOA | challenge | attacker budget 100 DVT | — | —
feeRecipient | address | vault | receives flash fees after grace | — | Vault

## Entry Points

- `deposit` / `mint` / `withdraw` / `redeem` (ERC4626)
- `flashLoan(receiver, token, amount, data)` — permissionless
- ERC20 `transfer` to vault — permissionless, not an entrypoint on the vault, still a state write on `totalAssets()`

## Privileged Functions & Upgrade Paths

- `feeRecipient` set at construct. No upgrade path in the challenge vault.

## External Dependencies & Callback Surfaces

- `receiver.onFlashLoan(...)` must return the IERC3156 magic value.
- `totalAssets()` reads token balance.

## Actor → Entry → Check → State → Effect Traces

```
Player → token.transfer(vault, x) → no vault check → vault.balanceOf increases → totalAssets() rises, shares unchanged
Player → vault.flashLoan → convertToShares(totalSupply) == totalAssets() → loan or InvalidBalance
```
