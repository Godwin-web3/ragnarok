# nft seam — shape index

Browse file. **Do not load this file on a hunt.** Use:

`scripts/shape_retrieve.sh nft`

65 shapes tagged `nft`.

| ID | Name | Other seams |
| :--- | :--- | :--- |
| `SHAPE-K002` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (amm seam) | amm, staking, callback |
| `SHAPE-K014` | Authorization in A, execution in B (amm #2) | amm, privilege, payments |
| `SHAPE-K017` | Authorization in A, execution in B via wrap | bridge, privilege, amm |
| `SHAPE-K020` | Authorization in A, execution in B (nft seam) | privilege, payments, callback |
| `SHAPE-K023` | Authorization in A, execution in B (payments seam) | payments, lending, accounting |
| `SHAPE-K028` | Authorization in A, execution in B (payments #4) | payments, callback, privilege |
| `SHAPE-K029` | Authorization in A, execution in B (privilege seam) | privilege, payments, amm |
| `SHAPE-K030` | Authorization in A, execution in B via initialize | privilege, amm, payments |
| `SHAPE-K032` | Authorization in A, execution in B via mint | privilege, payments, staking |
| `SHAPE-K039` | Authorization in A, execution in B (staking seam) | staking, privilege, payments |
| `SHAPE-K060` | A check's meaning is invalidated between pass and settlement (lending seam) | lending, callback, payments |
| `SHAPE-K062` | A check's meaning is invalidated between pass and settlement (privilege seam) | privilege, lending, callback |
| `SHAPE-K065` | A check's meaning is invalidated between pass and settlement (vault #2) | vault, privilege, amm |
| `SHAPE-K068` | Claims stay constant while redeemable assets fall (stablecoin seam) | stablecoin, lending, vault |
| `SHAPE-K078` | Entitlement exists without a corresponding payment obligation | bridge, privilege, vault |
| `SHAPE-K084` | Entitlement exists without a corresponding payment obligation (vault seam) | vault, stablecoin, payments |
| `SHAPE-K087` | Time or epoch boundary where a right survives into the next epoch's parameters (nft seam) | oracle, payments, lending |
| `SHAPE-K112` | Flag says closed while a write path still treats the surface as open (privilege seam) | privilege, amm, accounting |
| `SHAPE-K120` | Yield or harvest credits a ledger that cannot be the depositor's claim (bridge seam) | bridge, lending, amm |
| `SHAPE-K123` | Yield or harvest credits a ledger that cannot be the depositor's claim (nft seam) | vault, staking |
| `SHAPE-K129` | Identity that passed a check is not the identity that receives value | amm, accounting, payments |
| `SHAPE-K130` | Identity that passed a check is not the identity that receives value (bridge seam) | bridge, lending, payments |
| `SHAPE-K131` | Identity that passed a check is not the identity that receives value (lending seam) | lending, amm, payments |
| `SHAPE-K132` | Identity that passed a check is not the identity that receives value (nft seam) | payments, privilege |
| `SHAPE-K134` | Identity that passed a check is not the identity that receives value (payments seam) | payments, privilege, amm |
| `SHAPE-K135` | Identity that passed a check is not the identity that receives value (payments #2) | payments, privilege, amm |
| `SHAPE-K136` | Identity that passed a check is not the identity that receives value (privilege seam) | privilege, payments, amm |
| `SHAPE-K137` | Identity that passed a check is not the identity that receives value via permit | privilege, signature, payments |
| `SHAPE-K138` | Identity that passed a check is not the identity that receives value (stablecoin seam) | stablecoin, payments, privilege |
| `SHAPE-K139` | Identity that passed a check is not the identity that receives value (staking seam) | staking, payments, privilege |
| `SHAPE-K141` | Identity that passed a check is not the identity that receives value (vault #2) | vault, payments, signature |
| `SHAPE-K144` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (nft seam) | payments, privilege, lending |
| `SHAPE-K154` | Two components each locally conservative, jointly creating unbacked claims (nft seam) | accounting, callback |
| `SHAPE-K161` | Message or receipt accepted on one side without the lock or burn on the other | bridge, privilege, callback |
| `SHAPE-K163` | Message or receipt accepted on one side without the lock or burn on the other (privilege seam) | privilege, signature, bridge |
| `SHAPE-K164` | Message or receipt accepted on one side without the lock or burn on the other (stablecoin seam) | stablecoin, bridge, payments |
| `SHAPE-K166` | Custody of a unique token diverges from the rental or borrow right that should control it | amm, accounting, callback |
| `SHAPE-K167` | Custody of a unique token diverges from the rental or borrow right that should control it (bridge seam) | bridge, privilege, amm |
| `SHAPE-K168` | Custody of a unique token diverges from the rental or borrow right that should control it (lending seam) | lending, callback |
| `SHAPE-K169` | Custody of a unique token diverges from the rental or borrow right that should control it (nft seam) | accounting, callback |
| `SHAPE-K170` | Custody of a unique token diverges from the rental or borrow right that should control it (payments seam) | payments, staking, callback |
| `SHAPE-K171` | Custody of a unique token diverges from the rental or borrow right that should control it (privilege seam) | privilege, amm, callback |
| `SHAPE-K172` | Custody of a unique token diverges from the rental or borrow right that should control it (stablecoin seam) | stablecoin, accounting, callback |
| `SHAPE-K173` | Custody of a unique token diverges from the rental or borrow right that should control it (staking seam) | staking, callback |
| `SHAPE-K174` | Custody of a unique token diverges from the rental or borrow right that should control it (vault seam) | vault, callback, privilege |
| `SHAPE-K179` | A one-shot right can be consumed twice across two adapters (vault seam) | vault, payments, callback |
| `SHAPE-K181` | Pause or kill-switch blocks the documented path but not a value-moving sibling (payments seam) | payments, privilege, callback |
| `SHAPE-K182` | Pause or kill-switch blocks the documented path but not a value-moving sibling (privilege seam) | privilege, signature, callback |
| `SHAPE-K188` | Payment obligation exists without a remaining entitlement (payments seam) | payments, privilege, vault |
| `SHAPE-K198` | A role that looks view-only writes a parameter that reprices claims (payments seam) | payments, privilege, oracle |
| `SHAPE-K207` | Price used to create a position is not the price that keeps the system solvent (nft seam) | oracle, lending, stablecoin |
| `SHAPE-K209` | Price used to create a position is not the price that keeps the system solvent (payments seam) | payments, lending, amm |
| `SHAPE-K217` | A queued claim is transferable into a different backing or settlement state (bridge seam) | bridge, privilege, payments |
| `SHAPE-K219` | A queued claim is transferable into a different backing or settlement state (payments seam) | payments, privilege, vault |
| `SHAPE-K225` | Recorded balance exceeds transferable balance (bridge seam) | bridge, privilege, amm |
| `SHAPE-K235` | Recorded balance exceeds transferable balance (vault #2) | vault, stablecoin, accounting |
| `SHAPE-K236` | Refund or cancel does not restore the original claim, or restores it twice | payments |
| `SHAPE-K237` | Refund or cancel does not restore the original claim, or restores it twice (payments seam) | payments, amm, privilege |
| `SHAPE-K242` | Same intent settled twice after validator, implementation, or config change (payments seam) | payments, bridge, privilege |
| `SHAPE-K245` | Same intent settled twice after validator, implementation, or config change (vault seam) | vault, payments, privilege |
| `SHAPE-K254` | Liquidation or redemption uses a mark a same-tx actor can move (privilege seam) | privilege, accounting, oracle |
| `SHAPE-K257` | Signed bytes authorize a different execution context than the signer saw | amm, signature, privilege |
| `SHAPE-K260` | Signed bytes authorize a different execution context than the signer saw (nft seam) | signature, privilege |
| `SHAPE-K262` | Signed bytes authorize a different execution context than the signer saw (privilege seam) | privilege, signature, callback |
| `SHAPE-K266` | Supply and backing move in opposite directions on a conservation-neutral user action | amm, vault, accounting |
