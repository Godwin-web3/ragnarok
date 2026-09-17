# Representations

FACT-001 | Vault backing of existing shares
Component | Representation
--- | ---
Share supply | convertToShares(totalSupply)
Token book | totalAssets() / balanceOf(vault)
Flash-loan gate | those two must be equal or flashLoan reverts InvalidBalance
