# oracle seam — shape index

Browse file. **Do not load this file on a hunt.** Use:

`scripts/shape_retrieve.sh oracle`

55 shapes tagged `oracle`.

| ID | Name | Other seams |
| :--- | :--- | :--- |
| `SHAPE-K005` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (oracle seam) | privilege, amm, accounting |
| `SHAPE-K006` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (payments seam) | payments, privilege, lending |
| `SHAPE-K021` | Authorization in A, execution in B (oracle seam) | privilege, payments, lending |
| `SHAPE-K022` | Authorization in A, execution in B (oracle #2) | privilege, payments |
| `SHAPE-K038` | Authorization in A, execution in B (stablecoin #2) | stablecoin, privilege, callback |
| `SHAPE-K040` | Authorization in A, execution in B (vault seam) | vault, privilege, amm |
| `SHAPE-K047` | Authorization in A, execution in B (vault #5) | vault, payments, privilege |
| `SHAPE-K048` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing | accounting, lending |
| `SHAPE-K049` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (lending seam) | lending, amm, accounting |
| `SHAPE-K050` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (oracle seam) | lending |
| `SHAPE-K051` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (payments seam) | payments, privilege, lending |
| `SHAPE-K052` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (privilege seam) | privilege, accounting, lending |
| `SHAPE-K054` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (vault seam) | vault, stablecoin, payments |
| `SHAPE-K070` | Claims stay constant while redeemable assets fall (vault seam) | vault, lending, accounting |
| `SHAPE-K074` | Claims stay constant while redeemable assets fall via settle | vault, payments, lending |
| `SHAPE-K076` | Empty, dust, or first-actor rate lets the next actor's claim dominate | stablecoin, lending, amm |
| `SHAPE-K085` | Entitlement exists without a corresponding payment obligation via transfer | vault, stablecoin, amm |
| `SHAPE-K086` | Time or epoch boundary where a right survives into the next epoch's parameters | amm, staking, payments |
| `SHAPE-K087` | Time or epoch boundary where a right survives into the next epoch's parameters (nft seam) | nft, payments, lending |
| `SHAPE-K088` | Time or epoch boundary where a right survives into the next epoch's parameters (oracle seam) | payments, lending |
| `SHAPE-K089` | Time or epoch boundary where a right survives into the next epoch's parameters (payments seam) | payments, privilege, lending |
| `SHAPE-K090` | Time or epoch boundary where a right survives into the next epoch's parameters (privilege seam) | privilege, amm, accounting |
| `SHAPE-K091` | Time or epoch boundary where a right survives into the next epoch's parameters (stablecoin seam) | stablecoin, payments, lending |
| `SHAPE-K092` | Time or epoch boundary where a right survives into the next epoch's parameters (staking seam) | staking, payments, lending |
| `SHAPE-K093` | Time or epoch boundary where a right survives into the next epoch's parameters (vault seam) | vault, staking, payments |
| `SHAPE-K110` | Flag says closed while a write path still treats the surface as open (oracle seam) | privilege, amm |
| `SHAPE-K133` | Identity that passed a check is not the identity that receives value (oracle seam) | privilege, lending, payments |
| `SHAPE-K145` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (oracle seam) | privilege, lending, staking |
| `SHAPE-K194` | A role that looks view-only writes a parameter that reprices claims | accounting, privilege |
| `SHAPE-K195` | A role that looks view-only writes a parameter that reprices claims (amm seam) | amm, privilege |
| `SHAPE-K196` | A role that looks view-only writes a parameter that reprices claims (bridge seam) | bridge, privilege |
| `SHAPE-K197` | A role that looks view-only writes a parameter that reprices claims (lending seam) | lending, privilege |
| `SHAPE-K198` | A role that looks view-only writes a parameter that reprices claims (payments seam) | payments, nft, privilege |
| `SHAPE-K199` | A role that looks view-only writes a parameter that reprices claims (privilege seam) | privilege, lending, amm |
| `SHAPE-K200` | A role that looks view-only writes a parameter that reprices claims (stablecoin seam) | stablecoin, privilege, amm |
| `SHAPE-K201` | A role that looks view-only writes a parameter that reprices claims (staking seam) | staking, privilege, accounting |
| `SHAPE-K202` | A role that looks view-only writes a parameter that reprices claims (vault seam) | vault, bridge, privilege |
| `SHAPE-K203` | Price used to create a position is not the price that keeps the system solvent | amm, lending, stablecoin |
| `SHAPE-K204` | Price used to create a position is not the price that keeps the system solvent (bridge seam) | bridge, callback, lending |
| `SHAPE-K205` | Price used to create a position is not the price that keeps the system solvent (callback seam) | callback, lending, stablecoin |
| `SHAPE-K206` | Price used to create a position is not the price that keeps the system solvent (lending seam) | lending, staking, stablecoin |
| `SHAPE-K207` | Price used to create a position is not the price that keeps the system solvent (nft seam) | nft, lending, stablecoin |
| `SHAPE-K208` | Price used to create a position is not the price that keeps the system solvent (oracle seam) | lending, stablecoin, amm |
| `SHAPE-K210` | Price used to create a position is not the price that keeps the system solvent (privilege seam) | privilege, amm, lending |
| `SHAPE-K211` | Price used to create a position is not the price that keeps the system solvent (stablecoin seam) | stablecoin, lending, amm |
| `SHAPE-K212` | Price used to create a position is not the price that keeps the system solvent (staking seam) | staking, lending, stablecoin |
| `SHAPE-K213` | Price used to create a position is not the price that keeps the system solvent (vault seam) | vault, stablecoin, amm |
| `SHAPE-K251` | Liquidation or redemption uses a mark a same-tx actor can move | amm, lending |
| `SHAPE-K252` | Liquidation or redemption uses a mark a same-tx actor can move (oracle seam) | amm, lending |
| `SHAPE-K253` | Liquidation or redemption uses a mark a same-tx actor can move (payments seam) | payments, amm, lending |
| `SHAPE-K254` | Liquidation or redemption uses a mark a same-tx actor can move (privilege seam) | privilege, nft, accounting |
| `SHAPE-K255` | Liquidation or redemption uses a mark a same-tx actor can move (stablecoin seam) | stablecoin, payments, amm |
| `SHAPE-K256` | Liquidation or redemption uses a mark a same-tx actor can move (vault seam) | vault, amm, lending |
| `SHAPE-K258` | Signed bytes authorize a different execution context than the signer saw (bridge seam) | bridge, privilege, signature |
| `SHAPE-K281` | Two ledgers of the same fact disagree after every call returns success (vault seam) | vault, privilege, amm |
