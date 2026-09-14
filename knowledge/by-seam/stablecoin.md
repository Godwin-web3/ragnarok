# stablecoin seam — shape index

Browse file. **Do not load this file on a hunt.** Use:

`scripts/shape_retrieve.sh stablecoin`

58 shapes tagged `stablecoin`.

| ID | Name | Other seams |
| :--- | :--- | :--- |
| `SHAPE-K008` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (stablecoin seam) | amm, lending, privilege |
| `SHAPE-K010` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (vault seam) | vault, privilege, amm |
| `SHAPE-K035` | Authorization in A, execution in B (stablecoin seam) | privilege, amm, staking |
| `SHAPE-K036` | Authorization in A, execution in B via approve | payments, lending, amm |
| `SHAPE-K037` | Authorization in A, execution in B via mint/cancel | accounting, privilege, payments |
| `SHAPE-K038` | Authorization in A, execution in B (stablecoin #2) | oracle, privilege, callback |
| `SHAPE-K042` | Authorization in A, execution in B via mint/approve | vault, privilege, payments |
| `SHAPE-K053` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (stablecoin seam) | payments, privilege, lending |
| `SHAPE-K054` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (vault seam) | vault, payments, oracle |
| `SHAPE-K055` | Burn without matching release, or release without matching burn | accounting, bridge, vault |
| `SHAPE-K063` | A check's meaning is invalidated between pass and settlement (stablecoin seam) | staking, callback, payments |
| `SHAPE-K064` | A check's meaning is invalidated between pass and settlement (vault seam) | vault, payments, bridge |
| `SHAPE-K068` | Claims stay constant while redeemable assets fall (stablecoin seam) | lending, nft, vault |
| `SHAPE-K071` | Claims stay constant while redeemable assets fall via deposit | vault, privilege, signature |
| `SHAPE-K076` | Empty, dust, or first-actor rate lets the next actor's claim dominate | oracle, lending, amm |
| `SHAPE-K077` | Empty, dust, or first-actor rate lets the next actor's claim dominate (vault seam) | vault, amm, accounting |
| `SHAPE-K079` | Entitlement exists without a corresponding payment obligation (lending seam) | lending, vault, payments |
| `SHAPE-K080` | Entitlement exists without a corresponding payment obligation (payments seam) | payments, vault, privilege |
| `SHAPE-K081` | Entitlement exists without a corresponding payment obligation (privilege seam) | privilege, vault, payments |
| `SHAPE-K082` | Entitlement exists without a corresponding payment obligation (stablecoin seam) | privilege, vault, payments |
| `SHAPE-K083` | Entitlement exists without a corresponding payment obligation (staking seam) | staking, vault, payments |
| `SHAPE-K084` | Entitlement exists without a corresponding payment obligation (vault seam) | vault, nft, payments |
| `SHAPE-K085` | Entitlement exists without a corresponding payment obligation via transfer | vault, oracle, amm |
| `SHAPE-K091` | Time or epoch boundary where a right survives into the next epoch's parameters (stablecoin seam) | payments, oracle, lending |
| `SHAPE-K098` | Two representations of the same fact can diverge while every individual function returns success (stablecoin seam) | accounting, payments |
| `SHAPE-K105` | Fast path updates a subset of the state the slow path updates (stablecoin seam) | privilege, vault, payments |
| `SHAPE-K114` | Flag says closed while a write path still treats the surface as open (stablecoin seam) | privilege, amm, accounting |
| `SHAPE-K126` | Yield or harvest credits a ledger that cannot be the depositor's claim (stablecoin seam) | staking, callback, accounting |
| `SHAPE-K138` | Identity that passed a check is not the identity that receives value (stablecoin seam) | payments, privilege, nft |
| `SHAPE-K148` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (stablecoin seam) | bridge, privilege, amm |
| `SHAPE-K149` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (vault seam) | vault, payments, privilege |
| `SHAPE-K158` | Two components each locally conservative, jointly creating unbacked claims (stablecoin seam) | amm, accounting, callback |
| `SHAPE-K164` | Message or receipt accepted on one side without the lock or burn on the other (stablecoin seam) | bridge, nft, payments |
| `SHAPE-K172` | Custody of a unique token diverges from the rental or borrow right that should control it (stablecoin seam) | nft, accounting, callback |
| `SHAPE-K178` | A one-shot right can be consumed twice across two adapters (stablecoin seam) | payments, signature, callback |
| `SHAPE-K183` | Pause or kill-switch blocks the documented path but not a value-moving sibling (stablecoin seam) | privilege |
| `SHAPE-K190` | Payment obligation exists without a remaining entitlement (stablecoin seam) | privilege, payments, vault |
| `SHAPE-K200` | A role that looks view-only writes a parameter that reprices claims (stablecoin seam) | privilege, amm, oracle |
| `SHAPE-K203` | Price used to create a position is not the price that keeps the system solvent | amm, oracle, lending |
| `SHAPE-K205` | Price used to create a position is not the price that keeps the system solvent (callback seam) | callback, oracle, lending |
| `SHAPE-K206` | Price used to create a position is not the price that keeps the system solvent (lending seam) | lending, staking, oracle |
| `SHAPE-K207` | Price used to create a position is not the price that keeps the system solvent (nft seam) | nft, oracle, lending |
| `SHAPE-K208` | Price used to create a position is not the price that keeps the system solvent (oracle seam) | oracle, lending, amm |
| `SHAPE-K211` | Price used to create a position is not the price that keeps the system solvent (stablecoin seam) | oracle, lending, amm |
| `SHAPE-K212` | Price used to create a position is not the price that keeps the system solvent (staking seam) | staking, oracle, lending |
| `SHAPE-K213` | Price used to create a position is not the price that keeps the system solvent (vault seam) | vault, oracle, amm |
| `SHAPE-K215` | A queued claim is transferable into a different backing or settlement state | accounting, payments, vault |
| `SHAPE-K218` | A queued claim is transferable into a different backing or settlement state (lending seam) | lending, payments, vault |
| `SHAPE-K221` | A queued claim is transferable into a different backing or settlement state (stablecoin seam) | payments, privilege, lending |
| `SHAPE-K230` | Recorded balance exceeds transferable balance (stablecoin seam) | privilege, lending, vault |
| `SHAPE-K235` | Recorded balance exceeds transferable balance (vault #2) | vault, nft, accounting |
| `SHAPE-K239` | Refund or cancel does not restore the original claim, or restores it twice (stablecoin seam) | payments, amm |
| `SHAPE-K244` | Same intent settled twice after validator, implementation, or config change (stablecoin seam) | privilege, signature, bridge |
| `SHAPE-K255` | Liquidation or redemption uses a mark a same-tx actor can move (stablecoin seam) | payments, amm, oracle |
| `SHAPE-K264` | Signed bytes authorize a different execution context than the signer saw (stablecoin seam) | payments, bridge, privilege |
| `SHAPE-K265` | Signed bytes authorize a different execution context than the signer saw (vault seam) | vault, privilege, lending |
| `SHAPE-K269` | Supply and backing move in opposite directions on a conservation-neutral user action (stablecoin seam) | privilege, vault, accounting |
| `SHAPE-K280` | Two ledgers of the same fact disagree after every call returns success (stablecoin seam) | privilege, staking, accounting |
