# payments seam — shape index

Browse file. **Do not load this file on a hunt.** Use:

`scripts/shape_retrieve.sh payments`

136 shapes tagged `payments`.

| ID | Name | Other seams |
| :--- | :--- | :--- |
| `SHAPE-K006` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (payments seam) | oracle, privilege, lending |
| `SHAPE-K012` | Authorization in A, execution in B | accounting, privilege |
| `SHAPE-K013` | Authorization in A, execution in B (amm seam) | amm, callback, privilege |
| `SHAPE-K014` | Authorization in A, execution in B (amm #2) | amm, privilege, nft |
| `SHAPE-K015` | Authorization in A, execution in B (bridge seam) | bridge, privilege, accounting |
| `SHAPE-K016` | Authorization in A, execution in B via burn | bridge, privilege, callback |
| `SHAPE-K018` | Authorization in A, execution in B (callback seam) | callback, privilege |
| `SHAPE-K019` | Authorization in A, execution in B (lending seam) | lending, privilege, amm |
| `SHAPE-K020` | Authorization in A, execution in B (nft seam) | nft, privilege, callback |
| `SHAPE-K021` | Authorization in A, execution in B (oracle seam) | oracle, privilege, lending |
| `SHAPE-K022` | Authorization in A, execution in B (oracle #2) | oracle, privilege |
| `SHAPE-K023` | Authorization in A, execution in B (payments seam) | lending, nft, accounting |
| `SHAPE-K024` | Authorization in A, execution in B via transfer | privilege, amm, bridge |
| `SHAPE-K025` | Authorization in A, execution in B via transfer/execute | privilege, amm, callback |
| `SHAPE-K026` | Authorization in A, execution in B (payments #2) | privilege, accounting, lending |
| `SHAPE-K027` | Authorization in A, execution in B (payments #3) | bridge, privilege, signature |
| `SHAPE-K028` | Authorization in A, execution in B (payments #4) | nft, callback, privilege |
| `SHAPE-K029` | Authorization in A, execution in B (privilege seam) | privilege, nft, amm |
| `SHAPE-K030` | Authorization in A, execution in B via initialize | privilege, amm, nft |
| `SHAPE-K031` | Authorization in A, execution in B (privilege #2) | privilege, callback, amm |
| `SHAPE-K032` | Authorization in A, execution in B via mint | privilege, nft, staking |
| `SHAPE-K033` | Authorization in A, execution in B (privilege #3) | privilege, amm, staking |
| `SHAPE-K034` | Authorization in A, execution in B (signature seam) | signature, privilege |
| `SHAPE-K036` | Authorization in A, execution in B via approve | stablecoin, lending, amm |
| `SHAPE-K037` | Authorization in A, execution in B via mint/cancel | stablecoin, accounting, privilege |
| `SHAPE-K039` | Authorization in A, execution in B (staking seam) | staking, privilege, nft |
| `SHAPE-K042` | Authorization in A, execution in B via mint/approve | vault, privilege, stablecoin |
| `SHAPE-K043` | Authorization in A, execution in B via deposit | vault, privilege, amm |
| `SHAPE-K044` | Authorization in A, execution in B (vault #2) | vault, privilege, lending |
| `SHAPE-K045` | Authorization in A, execution in B (vault #3) | vault, privilege, amm |
| `SHAPE-K046` | Authorization in A, execution in B (vault #4) | vault, privilege, amm |
| `SHAPE-K047` | Authorization in A, execution in B (vault #5) | vault, privilege, oracle |
| `SHAPE-K051` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (payments seam) | oracle, privilege, lending |
| `SHAPE-K053` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (stablecoin seam) | stablecoin, privilege, lending |
| `SHAPE-K054` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (vault seam) | vault, stablecoin, oracle |
| `SHAPE-K058` | A check's meaning is invalidated between pass and settlement | amm, callback |
| `SHAPE-K059` | A check's meaning is invalidated between pass and settlement (callback seam) | callback |
| `SHAPE-K060` | A check's meaning is invalidated between pass and settlement (lending seam) | lending, nft, callback |
| `SHAPE-K061` | A check's meaning is invalidated between pass and settlement (payments seam) | amm, callback, privilege |
| `SHAPE-K063` | A check's meaning is invalidated between pass and settlement (stablecoin seam) | stablecoin, staking, callback |
| `SHAPE-K064` | A check's meaning is invalidated between pass and settlement (vault seam) | vault, stablecoin, bridge |
| `SHAPE-K066` | Claims stay constant while redeemable assets fall | bridge, privilege, accounting |
| `SHAPE-K074` | Claims stay constant while redeemable assets fall via settle | vault, oracle, lending |
| `SHAPE-K079` | Entitlement exists without a corresponding payment obligation (lending seam) | lending, vault, stablecoin |
| `SHAPE-K080` | Entitlement exists without a corresponding payment obligation (payments seam) | vault, stablecoin, privilege |
| `SHAPE-K081` | Entitlement exists without a corresponding payment obligation (privilege seam) | privilege, vault, stablecoin |
| `SHAPE-K082` | Entitlement exists without a corresponding payment obligation (stablecoin seam) | stablecoin, privilege, vault |
| `SHAPE-K083` | Entitlement exists without a corresponding payment obligation (staking seam) | staking, vault, stablecoin |
| `SHAPE-K084` | Entitlement exists without a corresponding payment obligation (vault seam) | vault, nft, stablecoin |
| `SHAPE-K086` | Time or epoch boundary where a right survives into the next epoch's parameters | amm, staking, oracle |
| `SHAPE-K087` | Time or epoch boundary where a right survives into the next epoch's parameters (nft seam) | nft, oracle, lending |
| `SHAPE-K088` | Time or epoch boundary where a right survives into the next epoch's parameters (oracle seam) | oracle, lending |
| `SHAPE-K089` | Time or epoch boundary where a right survives into the next epoch's parameters (payments seam) | privilege, oracle, lending |
| `SHAPE-K091` | Time or epoch boundary where a right survives into the next epoch's parameters (stablecoin seam) | stablecoin, oracle, lending |
| `SHAPE-K092` | Time or epoch boundary where a right survives into the next epoch's parameters (staking seam) | staking, oracle, lending |
| `SHAPE-K093` | Time or epoch boundary where a right survives into the next epoch's parameters (vault seam) | vault, staking, oracle |
| `SHAPE-K096` | Two representations of the same fact can diverge while every individual function returns success (payments seam) | accounting |
| `SHAPE-K098` | Two representations of the same fact can diverge while every individual function returns success (stablecoin seam) | stablecoin, accounting |
| `SHAPE-K100` | Two representations of the same fact can diverge while every individual function returns success (vault seam) | vault, accounting, privilege |
| `SHAPE-K101` | Fast path updates a subset of the state the slow path updates | accounting, vault, lending |
| `SHAPE-K102` | Fast path updates a subset of the state the slow path updates (bridge seam) | bridge, vault, lending |
| `SHAPE-K103` | Fast path updates a subset of the state the slow path updates (payments seam) | staking, accounting, vault |
| `SHAPE-K104` | Fast path updates a subset of the state the slow path updates (privilege seam) | privilege, vault, lending |
| `SHAPE-K105` | Fast path updates a subset of the state the slow path updates (stablecoin seam) | stablecoin, privilege, vault |
| `SHAPE-K106` | Fast path updates a subset of the state the slow path updates (staking seam) | staking, accounting, vault |
| `SHAPE-K107` | Fast path updates a subset of the state the slow path updates (vault seam) | vault, staking, lending |
| `SHAPE-K111` | Flag says closed while a write path still treats the surface as open (payments seam) | privilege, staking, callback |
| `SHAPE-K116` | Prepaid execution credit and actual settlement charge disagree, moving value | bridge, privilege, accounting |
| `SHAPE-K117` | Prepaid execution credit and actual settlement charge disagree, moving value (payments seam) | bridge, privilege, amm |
| `SHAPE-K124` | Yield or harvest credits a ledger that cannot be the depositor's claim (payments seam) | privilege, staking, vault |
| `SHAPE-K129` | Identity that passed a check is not the identity that receives value | amm, accounting, nft |
| `SHAPE-K130` | Identity that passed a check is not the identity that receives value (bridge seam) | bridge, lending, nft |
| `SHAPE-K131` | Identity that passed a check is not the identity that receives value (lending seam) | lending, amm, nft |
| `SHAPE-K132` | Identity that passed a check is not the identity that receives value (nft seam) | nft, privilege |
| `SHAPE-K133` | Identity that passed a check is not the identity that receives value (oracle seam) | oracle, privilege, lending |
| `SHAPE-K134` | Identity that passed a check is not the identity that receives value (payments seam) | nft, privilege, amm |
| `SHAPE-K135` | Identity that passed a check is not the identity that receives value (payments #2) | nft, privilege, amm |
| `SHAPE-K136` | Identity that passed a check is not the identity that receives value (privilege seam) | privilege, nft, amm |
| `SHAPE-K137` | Identity that passed a check is not the identity that receives value via permit | privilege, signature, nft |
| `SHAPE-K138` | Identity that passed a check is not the identity that receives value (stablecoin seam) | stablecoin, privilege, nft |
| `SHAPE-K139` | Identity that passed a check is not the identity that receives value (staking seam) | staking, nft, privilege |
| `SHAPE-K140` | Identity that passed a check is not the identity that receives value (vault seam) | vault, privilege, staking |
| `SHAPE-K141` | Identity that passed a check is not the identity that receives value (vault #2) | vault, signature, nft |
| `SHAPE-K142` | Keeper or permissioned settle that a permissionless actor can force-order to capture value | amm, staking, privilege |
| `SHAPE-K143` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (bridge seam) | bridge, privilege, lending |
| `SHAPE-K144` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (nft seam) | nft, privilege, lending |
| `SHAPE-K146` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (payments seam) | amm, privilege, lending |
| `SHAPE-K147` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (privilege seam) | privilege, lending, amm |
| `SHAPE-K149` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (vault seam) | vault, stablecoin, privilege |
| `SHAPE-K155` | Two components each locally conservative, jointly creating unbacked claims (payments seam) | signature, accounting, callback |
| `SHAPE-K160` | Two components each locally conservative, jointly creating unbacked claims (vault seam) | vault, accounting, callback |
| `SHAPE-K162` | Message or receipt accepted on one side without the lock or burn on the other (payments seam) | bridge, privilege, amm |
| `SHAPE-K164` | Message or receipt accepted on one side without the lock or burn on the other (stablecoin seam) | stablecoin, bridge, nft |
| `SHAPE-K170` | Custody of a unique token diverges from the rental or borrow right that should control it (payments seam) | staking, nft, callback |
| `SHAPE-K175` | A one-shot right can be consumed twice across two adapters | lending, amm, bridge |
| `SHAPE-K176` | A one-shot right can be consumed twice across two adapters (payments seam) | bridge, signature |
| `SHAPE-K177` | A one-shot right can be consumed twice across two adapters (privilege seam) | privilege, bridge, signature |
| `SHAPE-K178` | A one-shot right can be consumed twice across two adapters (stablecoin seam) | stablecoin, signature, callback |
| `SHAPE-K179` | A one-shot right can be consumed twice across two adapters (vault seam) | vault, nft, callback |
| `SHAPE-K181` | Pause or kill-switch blocks the documented path but not a value-moving sibling (payments seam) | privilege, nft, callback |
| `SHAPE-K185` | Payment obligation exists without a remaining entitlement | amm, vault |
| `SHAPE-K187` | Payment obligation exists without a remaining entitlement (lending seam) | lending, amm, accounting |
| `SHAPE-K188` | Payment obligation exists without a remaining entitlement (payments seam) | privilege, nft, vault |
| `SHAPE-K189` | Payment obligation exists without a remaining entitlement (privilege seam) | privilege, amm, vault |
| `SHAPE-K190` | Payment obligation exists without a remaining entitlement (stablecoin seam) | stablecoin, privilege, vault |
| `SHAPE-K191` | Payment obligation exists without a remaining entitlement (staking seam) | staking, vault, signature |
| `SHAPE-K192` | Payment obligation exists without a remaining entitlement (vault seam) | vault, privilege, callback |
| `SHAPE-K193` | Payment obligation exists without a remaining entitlement via unwrap | vault, bridge, lending |
| `SHAPE-K198` | A role that looks view-only writes a parameter that reprices claims (payments seam) | nft, privilege, oracle |
| `SHAPE-K209` | Price used to create a position is not the price that keeps the system solvent (payments seam) | lending, amm, nft |
| `SHAPE-K214` | Price used to create a position is not the price that keeps the system solvent (vault #2) | vault, privilege, lending |
| `SHAPE-K215` | A queued claim is transferable into a different backing or settlement state | accounting, vault, stablecoin |
| `SHAPE-K216` | A queued claim is transferable into a different backing or settlement state (amm seam) | amm, accounting, vault |
| `SHAPE-K217` | A queued claim is transferable into a different backing or settlement state (bridge seam) | bridge, privilege, nft |
| `SHAPE-K218` | A queued claim is transferable into a different backing or settlement state (lending seam) | lending, vault, stablecoin |
| `SHAPE-K219` | A queued claim is transferable into a different backing or settlement state (payments seam) | privilege, nft, vault |
| `SHAPE-K220` | A queued claim is transferable into a different backing or settlement state (privilege seam) | privilege, callback, vault |
| `SHAPE-K221` | A queued claim is transferable into a different backing or settlement state (stablecoin seam) | stablecoin, privilege, lending |
| `SHAPE-K222` | A queued claim is transferable into a different backing or settlement state (vault seam) | vault, privilege, staking |
| `SHAPE-K228` | Recorded balance exceeds transferable balance (payments seam) | privilege, accounting, vault |
| `SHAPE-K233` | Recorded balance exceeds transferable balance via execute | vault, privilege, accounting |
| `SHAPE-K236` | Refund or cancel does not restore the original claim, or restores it twice | nft |
| `SHAPE-K237` | Refund or cancel does not restore the original claim, or restores it twice (payments seam) | amm, privilege, nft |
| `SHAPE-K238` | Refund or cancel does not restore the original claim, or restores it twice (privilege seam) | privilege |
| `SHAPE-K239` | Refund or cancel does not restore the original claim, or restores it twice (stablecoin seam) | stablecoin, amm |
| `SHAPE-K242` | Same intent settled twice after validator, implementation, or config change (payments seam) | nft, bridge, privilege |
| `SHAPE-K245` | Same intent settled twice after validator, implementation, or config change (vault seam) | vault, privilege, nft |
| `SHAPE-K249` | Rounding direction on a conservation-neutral action creates or destroys value (payments seam) | accounting, vault |
| `SHAPE-K253` | Liquidation or redemption uses a mark a same-tx actor can move (payments seam) | amm, oracle, lending |
| `SHAPE-K255` | Liquidation or redemption uses a mark a same-tx actor can move (stablecoin seam) | stablecoin, amm, oracle |
| `SHAPE-K261` | Signed bytes authorize a different execution context than the signer saw (payments seam) | privilege, amm, signature |
| `SHAPE-K264` | Signed bytes authorize a different execution context than the signer saw (stablecoin seam) | stablecoin, bridge, privilege |
| `SHAPE-K271` | A time lock, cooldown, or expiry is true in storage and false at the write | bridge, privilege |
| `SHAPE-K272` | A time lock, cooldown, or expiry is true in storage and false at the write (privilege seam) | privilege, staking |
| `SHAPE-K273` | A time lock, cooldown, or expiry is true in storage and false at the write (staking seam) | staking, privilege |
| `SHAPE-K278` | Two ledgers of the same fact disagree after every call returns success (payments seam) | bridge, accounting, privilege |
