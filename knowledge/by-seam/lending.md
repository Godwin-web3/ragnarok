# lending seam — shape index

Browse file. **Do not load this file on a hunt.** Use:

`scripts/shape_retrieve.sh lending`

80 shapes tagged `lending`.

| ID | Name | Other seams |
| :--- | :--- | :--- |
| `SHAPE-K004` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (lending seam) | amm, callback, accounting |
| `SHAPE-K006` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (payments seam) | payments, oracle, privilege |
| `SHAPE-K007` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (privilege seam) | privilege, staking, amm |
| `SHAPE-K008` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (stablecoin seam) | stablecoin, amm, privilege |
| `SHAPE-K011` | Pool reserves and LP claims disagree after a valid swap, mint, or hook via borrow | vault, amm, accounting |
| `SHAPE-K019` | Authorization in A, execution in B (lending seam) | privilege, payments, amm |
| `SHAPE-K021` | Authorization in A, execution in B (oracle seam) | oracle, privilege, payments |
| `SHAPE-K023` | Authorization in A, execution in B (payments seam) | payments, nft, accounting |
| `SHAPE-K026` | Authorization in A, execution in B (payments #2) | payments, privilege, accounting |
| `SHAPE-K036` | Authorization in A, execution in B via approve | stablecoin, payments, amm |
| `SHAPE-K044` | Authorization in A, execution in B (vault #2) | vault, privilege, payments |
| `SHAPE-K048` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing | accounting, oracle |
| `SHAPE-K049` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (lending seam) | amm, oracle, accounting |
| `SHAPE-K050` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (oracle seam) | oracle |
| `SHAPE-K051` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (payments seam) | payments, oracle, privilege |
| `SHAPE-K052` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (privilege seam) | privilege, accounting, oracle |
| `SHAPE-K053` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (stablecoin seam) | stablecoin, payments, privilege |
| `SHAPE-K060` | A check's meaning is invalidated between pass and settlement (lending seam) | nft, callback, payments |
| `SHAPE-K062` | A check's meaning is invalidated between pass and settlement (privilege seam) | privilege, nft, callback |
| `SHAPE-K068` | Claims stay constant while redeemable assets fall (stablecoin seam) | stablecoin, nft, vault |
| `SHAPE-K070` | Claims stay constant while redeemable assets fall (vault seam) | vault, oracle, accounting |
| `SHAPE-K074` | Claims stay constant while redeemable assets fall via settle | vault, payments, oracle |
| `SHAPE-K076` | Empty, dust, or first-actor rate lets the next actor's claim dominate | stablecoin, oracle, amm |
| `SHAPE-K079` | Entitlement exists without a corresponding payment obligation (lending seam) | vault, stablecoin, payments |
| `SHAPE-K087` | Time or epoch boundary where a right survives into the next epoch's parameters (nft seam) | nft, oracle, payments |
| `SHAPE-K088` | Time or epoch boundary where a right survives into the next epoch's parameters (oracle seam) | oracle, payments |
| `SHAPE-K089` | Time or epoch boundary where a right survives into the next epoch's parameters (payments seam) | payments, privilege, oracle |
| `SHAPE-K091` | Time or epoch boundary where a right survives into the next epoch's parameters (stablecoin seam) | stablecoin, payments, oracle |
| `SHAPE-K092` | Time or epoch boundary where a right survives into the next epoch's parameters (staking seam) | staking, oracle, payments |
| `SHAPE-K095` | Two representations of the same fact can diverge while every individual function returns success (lending seam) | accounting |
| `SHAPE-K101` | Fast path updates a subset of the state the slow path updates | accounting, vault, payments |
| `SHAPE-K102` | Fast path updates a subset of the state the slow path updates (bridge seam) | bridge, vault, payments |
| `SHAPE-K104` | Fast path updates a subset of the state the slow path updates (privilege seam) | privilege, vault, payments |
| `SHAPE-K107` | Fast path updates a subset of the state the slow path updates (vault seam) | vault, staking, payments |
| `SHAPE-K109` | Flag says closed while a write path still treats the surface as open (lending seam) | amm, privilege |
| `SHAPE-K115` | Flag says closed while a write path still treats the surface as open (vault seam) | vault, privilege, staking |
| `SHAPE-K120` | Yield or harvest credits a ledger that cannot be the depositor's claim (bridge seam) | bridge, amm, nft |
| `SHAPE-K122` | Yield or harvest credits a ledger that cannot be the depositor's claim (lending seam) | vault, staking |
| `SHAPE-K130` | Identity that passed a check is not the identity that receives value (bridge seam) | bridge, payments, nft |
| `SHAPE-K131` | Identity that passed a check is not the identity that receives value (lending seam) | amm, payments, nft |
| `SHAPE-K133` | Identity that passed a check is not the identity that receives value (oracle seam) | oracle, privilege, payments |
| `SHAPE-K143` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (bridge seam) | bridge, privilege, payments |
| `SHAPE-K144` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (nft seam) | nft, payments, privilege |
| `SHAPE-K145` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (oracle seam) | oracle, privilege, staking |
| `SHAPE-K146` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (payments seam) | payments, amm, privilege |
| `SHAPE-K147` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (privilege seam) | privilege, payments, amm |
| `SHAPE-K153` | Two components each locally conservative, jointly creating unbacked claims (lending seam) | accounting, callback |
| `SHAPE-K168` | Custody of a unique token diverges from the rental or borrow right that should control it (lending seam) | nft, callback |
| `SHAPE-K175` | A one-shot right can be consumed twice across two adapters | amm, payments, bridge |
| `SHAPE-K187` | Payment obligation exists without a remaining entitlement (lending seam) | amm, accounting, payments |
| `SHAPE-K193` | Payment obligation exists without a remaining entitlement via unwrap | vault, payments, bridge |
| `SHAPE-K197` | A role that looks view-only writes a parameter that reprices claims (lending seam) | privilege, oracle |
| `SHAPE-K199` | A role that looks view-only writes a parameter that reprices claims (privilege seam) | privilege, oracle, amm |
| `SHAPE-K203` | Price used to create a position is not the price that keeps the system solvent | amm, oracle, stablecoin |
| `SHAPE-K204` | Price used to create a position is not the price that keeps the system solvent (bridge seam) | bridge, oracle, callback |
| `SHAPE-K205` | Price used to create a position is not the price that keeps the system solvent (callback seam) | callback, oracle, stablecoin |
| `SHAPE-K206` | Price used to create a position is not the price that keeps the system solvent (lending seam) | staking, oracle, stablecoin |
| `SHAPE-K207` | Price used to create a position is not the price that keeps the system solvent (nft seam) | nft, oracle, stablecoin |
| `SHAPE-K208` | Price used to create a position is not the price that keeps the system solvent (oracle seam) | oracle, stablecoin, amm |
| `SHAPE-K209` | Price used to create a position is not the price that keeps the system solvent (payments seam) | payments, amm, nft |
| `SHAPE-K210` | Price used to create a position is not the price that keeps the system solvent (privilege seam) | privilege, amm, oracle |
| `SHAPE-K211` | Price used to create a position is not the price that keeps the system solvent (stablecoin seam) | stablecoin, oracle, amm |
| `SHAPE-K212` | Price used to create a position is not the price that keeps the system solvent (staking seam) | staking, oracle, stablecoin |
| `SHAPE-K214` | Price used to create a position is not the price that keeps the system solvent (vault #2) | vault, payments, privilege |
| `SHAPE-K218` | A queued claim is transferable into a different backing or settlement state (lending seam) | payments, vault, stablecoin |
| `SHAPE-K221` | A queued claim is transferable into a different backing or settlement state (stablecoin seam) | stablecoin, payments, privilege |
| `SHAPE-K227` | Recorded balance exceeds transferable balance (lending seam) | vault, accounting, staking |
| `SHAPE-K230` | Recorded balance exceeds transferable balance (stablecoin seam) | stablecoin, privilege, vault |
| `SHAPE-K232` | Recorded balance exceeds transferable balance (vault seam) | vault, amm, accounting |
| `SHAPE-K248` | Rounding direction on a conservation-neutral action creates or destroys value (lending seam) | accounting, vault |
| `SHAPE-K251` | Liquidation or redemption uses a mark a same-tx actor can move | amm, oracle |
| `SHAPE-K252` | Liquidation or redemption uses a mark a same-tx actor can move (oracle seam) | oracle, amm |
| `SHAPE-K253` | Liquidation or redemption uses a mark a same-tx actor can move (payments seam) | payments, amm, oracle |
| `SHAPE-K256` | Liquidation or redemption uses a mark a same-tx actor can move (vault seam) | vault, oracle, amm |
| `SHAPE-K259` | Signed bytes authorize a different execution context than the signer saw (lending seam) | signature, privilege |
| `SHAPE-K265` | Signed bytes authorize a different execution context than the signer saw (vault seam) | vault, stablecoin, privilege |
| `SHAPE-K267` | Supply and backing move in opposite directions on a conservation-neutral user action (lending seam) | vault, accounting |
| `SHAPE-K268` | Supply and backing move in opposite directions on a conservation-neutral user action (privilege seam) | privilege, accounting, vault |
| `SHAPE-K276` | Two ledgers of the same fact disagree after every call returns success (bridge seam) | bridge, accounting |
| `SHAPE-K277` | Two ledgers of the same fact disagree after every call returns success (lending seam) | staking, accounting, callback |
