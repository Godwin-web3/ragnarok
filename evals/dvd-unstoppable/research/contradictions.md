# Contradictions

## CX-001 — share book vs token book

- STATE: `convertToShares(totalSupply) != totalAssets()` while `flashLoan` remains an entrypoint.
- CONTRADICTION: Share supply still accounts 1:1 for the original deposit. Token balance of the vault is higher. `flashLoan` requires those two representations to be equal.
- PAIRING: UnstoppableVault share accounting ↔ DVT `balanceOf(vault)` / `totalAssets()`.
- CONSTRUCTION: Permissionless ERC20 `transfer` into the vault. No `deposit`/`mint`. Shares unchanged. `totalAssets()` rises.
- SEQUENCE:
  1. Vault holds 1_000_000 DVT credited as shares.
  2. Player `token.transfer(vault, 1 ether)`.
  3. `vault.flashLoan(...)` hits `InvalidBalance`.
- WITNESS: `vault.convertToShares(vault.totalSupply()) != vault.totalAssets()` after a positive donation.
- MONETIZATION: None on this path. Flash loans halt. The 1_000_000 DVT is not withdrawn by the donor.
- CHEAPEST FALSIFIER: Local harness `test_witness_donation_breaks_share_token_pairing`.
- FALSIFIER RESULT: PASS. Witness holds. `flashLoan` reverts `InvalidBalance`.
- KILL: Zero donation does not break the equality. `test_kill_zero_donation_does_not_break` PASS.
- CLASS: GRIEF
- STATUS: REACHABLE

Not EXTRACT. Report gate must not promote this card to permissionless CONFIRMED EXTRACT.
