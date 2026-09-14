# privilege seam — shape index

Browse file. **Do not load this file on a hunt.** Use:

`scripts/shape_retrieve.sh privilege`

162 shapes tagged `privilege`.

| ID | Name | Other seams |
| :--- | :--- | :--- |
| `SHAPE-K003` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (bridge seam) | bridge, amm |
| `SHAPE-K005` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (oracle seam) | oracle, amm, accounting |
| `SHAPE-K006` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (payments seam) | payments, oracle, lending |
| `SHAPE-K007` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (privilege seam) | staking, amm, lending |
| `SHAPE-K008` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (stablecoin seam) | stablecoin, amm, lending |
| `SHAPE-K010` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (vault seam) | vault, stablecoin, amm |
| `SHAPE-K012` | Authorization in A, execution in B | accounting, payments |
| `SHAPE-K013` | Authorization in A, execution in B (amm seam) | amm, callback, payments |
| `SHAPE-K014` | Authorization in A, execution in B (amm #2) | amm, payments, nft |
| `SHAPE-K015` | Authorization in A, execution in B (bridge seam) | bridge, payments, accounting |
| `SHAPE-K016` | Authorization in A, execution in B via burn | bridge, payments, callback |
| `SHAPE-K017` | Authorization in A, execution in B via wrap | bridge, amm, nft |
| `SHAPE-K018` | Authorization in A, execution in B (callback seam) | callback, payments |
| `SHAPE-K019` | Authorization in A, execution in B (lending seam) | lending, payments, amm |
| `SHAPE-K020` | Authorization in A, execution in B (nft seam) | nft, payments, callback |
| `SHAPE-K021` | Authorization in A, execution in B (oracle seam) | oracle, payments, lending |
| `SHAPE-K022` | Authorization in A, execution in B (oracle #2) | oracle, payments |
| `SHAPE-K024` | Authorization in A, execution in B via transfer | payments, amm, bridge |
| `SHAPE-K025` | Authorization in A, execution in B via transfer/execute | payments, amm, callback |
| `SHAPE-K026` | Authorization in A, execution in B (payments #2) | payments, accounting, lending |
| `SHAPE-K027` | Authorization in A, execution in B (payments #3) | payments, bridge, signature |
| `SHAPE-K028` | Authorization in A, execution in B (payments #4) | payments, nft, callback |
| `SHAPE-K029` | Authorization in A, execution in B (privilege seam) | payments, nft, amm |
| `SHAPE-K030` | Authorization in A, execution in B via initialize | amm, payments, nft |
| `SHAPE-K031` | Authorization in A, execution in B (privilege #2) | payments, callback, amm |
| `SHAPE-K032` | Authorization in A, execution in B via mint | payments, nft, staking |
| `SHAPE-K033` | Authorization in A, execution in B (privilege #3) | amm, payments, staking |
| `SHAPE-K034` | Authorization in A, execution in B (signature seam) | signature, payments |
| `SHAPE-K035` | Authorization in A, execution in B (stablecoin seam) | stablecoin, amm, staking |
| `SHAPE-K037` | Authorization in A, execution in B via mint/cancel | stablecoin, accounting, payments |
| `SHAPE-K038` | Authorization in A, execution in B (stablecoin #2) | stablecoin, oracle, callback |
| `SHAPE-K039` | Authorization in A, execution in B (staking seam) | staking, payments, nft |
| `SHAPE-K040` | Authorization in A, execution in B (vault seam) | vault, oracle, amm |
| `SHAPE-K041` | Authorization in A, execution in B via approve/deposit | vault, amm, callback |
| `SHAPE-K042` | Authorization in A, execution in B via mint/approve | vault, payments, stablecoin |
| `SHAPE-K043` | Authorization in A, execution in B via deposit | vault, amm, payments |
| `SHAPE-K044` | Authorization in A, execution in B (vault #2) | vault, payments, lending |
| `SHAPE-K045` | Authorization in A, execution in B (vault #3) | vault, payments, amm |
| `SHAPE-K046` | Authorization in A, execution in B (vault #4) | vault, payments, amm |
| `SHAPE-K047` | Authorization in A, execution in B (vault #5) | vault, payments, oracle |
| `SHAPE-K051` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (payments seam) | payments, oracle, lending |
| `SHAPE-K052` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (privilege seam) | accounting, lending, oracle |
| `SHAPE-K053` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (stablecoin seam) | stablecoin, payments, lending |
| `SHAPE-K056` | Burn without matching release, or release without matching burn (vault seam) | vault, amm, callback |
| `SHAPE-K057` | A documented cap, floor, or uniqueness bound is not the bound the write path honors | accounting |
| `SHAPE-K061` | A check's meaning is invalidated between pass and settlement (payments seam) | payments, amm, callback |
| `SHAPE-K062` | A check's meaning is invalidated between pass and settlement (privilege seam) | lending, nft, callback |
| `SHAPE-K065` | A check's meaning is invalidated between pass and settlement (vault #2) | vault, amm, nft |
| `SHAPE-K066` | Claims stay constant while redeemable assets fall | payments, bridge, accounting |
| `SHAPE-K067` | Claims stay constant while redeemable assets fall (privilege seam) | staking, vault, accounting |
| `SHAPE-K071` | Claims stay constant while redeemable assets fall via deposit | vault, stablecoin, signature |
| `SHAPE-K072` | Claims stay constant while redeemable assets fall via mint | vault, accounting, amm |
| `SHAPE-K073` | Claims stay constant while redeemable assets fall via queue | vault, amm, accounting |
| `SHAPE-K078` | Entitlement exists without a corresponding payment obligation | bridge, nft, vault |
| `SHAPE-K080` | Entitlement exists without a corresponding payment obligation (payments seam) | payments, vault, stablecoin |
| `SHAPE-K081` | Entitlement exists without a corresponding payment obligation (privilege seam) | vault, stablecoin, payments |
| `SHAPE-K082` | Entitlement exists without a corresponding payment obligation (stablecoin seam) | stablecoin, vault, payments |
| `SHAPE-K089` | Time or epoch boundary where a right survives into the next epoch's parameters (payments seam) | payments, oracle, lending |
| `SHAPE-K090` | Time or epoch boundary where a right survives into the next epoch's parameters (privilege seam) | amm, accounting, oracle |
| `SHAPE-K097` | Two representations of the same fact can diverge while every individual function returns success (privilege seam) | staking, accounting |
| `SHAPE-K100` | Two representations of the same fact can diverge while every individual function returns success (vault seam) | vault, accounting, payments |
| `SHAPE-K104` | Fast path updates a subset of the state the slow path updates (privilege seam) | vault, payments, lending |
| `SHAPE-K105` | Fast path updates a subset of the state the slow path updates (stablecoin seam) | stablecoin, vault, payments |
| `SHAPE-K108` | Flag says closed while a write path still treats the surface as open | callback |
| `SHAPE-K109` | Flag says closed while a write path still treats the surface as open (lending seam) | lending, amm |
| `SHAPE-K110` | Flag says closed while a write path still treats the surface as open (oracle seam) | oracle, amm |
| `SHAPE-K111` | Flag says closed while a write path still treats the surface as open (payments seam) | payments, staking, callback |
| `SHAPE-K112` | Flag says closed while a write path still treats the surface as open (privilege seam) | amm, nft, accounting |
| `SHAPE-K113` | Flag says closed while a write path still treats the surface as open (privilege #2) | staking, amm |
| `SHAPE-K114` | Flag says closed while a write path still treats the surface as open (stablecoin seam) | stablecoin, amm, accounting |
| `SHAPE-K115` | Flag says closed while a write path still treats the surface as open (vault seam) | vault, staking, lending |
| `SHAPE-K116` | Prepaid execution credit and actual settlement charge disagree, moving value | bridge, accounting, payments |
| `SHAPE-K117` | Prepaid execution credit and actual settlement charge disagree, moving value (payments seam) | payments, bridge, amm |
| `SHAPE-K118` | Prepaid execution credit and actual settlement charge disagree, moving value (vault seam) | vault, amm, bridge |
| `SHAPE-K124` | Yield or harvest credits a ledger that cannot be the depositor's claim (payments seam) | payments, staking, vault |
| `SHAPE-K125` | Yield or harvest credits a ledger that cannot be the depositor's claim (privilege seam) | amm, vault, staking |
| `SHAPE-K128` | Yield or harvest credits a ledger that cannot be the depositor's claim (vault seam) | vault, staking, amm |
| `SHAPE-K132` | Identity that passed a check is not the identity that receives value (nft seam) | nft, payments |
| `SHAPE-K133` | Identity that passed a check is not the identity that receives value (oracle seam) | oracle, lending, payments |
| `SHAPE-K134` | Identity that passed a check is not the identity that receives value (payments seam) | payments, nft, amm |
| `SHAPE-K135` | Identity that passed a check is not the identity that receives value (payments #2) | payments, nft, amm |
| `SHAPE-K136` | Identity that passed a check is not the identity that receives value (privilege seam) | payments, nft, amm |
| `SHAPE-K137` | Identity that passed a check is not the identity that receives value via permit | signature, payments, nft |
| `SHAPE-K138` | Identity that passed a check is not the identity that receives value (stablecoin seam) | stablecoin, payments, nft |
| `SHAPE-K139` | Identity that passed a check is not the identity that receives value (staking seam) | staking, payments, nft |
| `SHAPE-K140` | Identity that passed a check is not the identity that receives value (vault seam) | vault, staking, payments |
| `SHAPE-K142` | Keeper or permissioned settle that a permissionless actor can force-order to capture value | amm, staking, payments |
| `SHAPE-K143` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (bridge seam) | bridge, payments, lending |
| `SHAPE-K144` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (nft seam) | nft, payments, lending |
| `SHAPE-K145` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (oracle seam) | oracle, lending, staking |
| `SHAPE-K146` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (payments seam) | payments, amm, lending |
| `SHAPE-K147` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (privilege seam) | payments, lending, amm |
| `SHAPE-K148` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (stablecoin seam) | stablecoin, bridge, amm |
| `SHAPE-K149` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (vault seam) | vault, stablecoin, payments |
| `SHAPE-K150` | Legacy path still ACTIVE after new accounting took over | amm, vault |
| `SHAPE-K156` | Two components each locally conservative, jointly creating unbacked claims (privilege seam) | staking, accounting, callback |
| `SHAPE-K161` | Message or receipt accepted on one side without the lock or burn on the other | bridge, nft, callback |
| `SHAPE-K162` | Message or receipt accepted on one side without the lock or burn on the other (payments seam) | payments, bridge, amm |
| `SHAPE-K163` | Message or receipt accepted on one side without the lock or burn on the other (privilege seam) | signature, bridge, nft |
| `SHAPE-K167` | Custody of a unique token diverges from the rental or borrow right that should control it (bridge seam) | bridge, amm, nft |
| `SHAPE-K171` | Custody of a unique token diverges from the rental or borrow right that should control it (privilege seam) | amm, nft, callback |
| `SHAPE-K174` | Custody of a unique token diverges from the rental or borrow right that should control it (vault seam) | vault, nft, callback |
| `SHAPE-K177` | A one-shot right can be consumed twice across two adapters (privilege seam) | payments, bridge, signature |
| `SHAPE-K180` | Pause or kill-switch blocks the documented path but not a value-moving sibling | bridge |
| `SHAPE-K181` | Pause or kill-switch blocks the documented path but not a value-moving sibling (payments seam) | payments, nft, callback |
| `SHAPE-K182` | Pause or kill-switch blocks the documented path but not a value-moving sibling (privilege seam) | signature, nft, callback |
| `SHAPE-K183` | Pause or kill-switch blocks the documented path but not a value-moving sibling (stablecoin seam) | stablecoin |
| `SHAPE-K184` | Pause or kill-switch blocks the documented path but not a value-moving sibling (vault seam) | vault, amm, staking |
| `SHAPE-K186` | Payment obligation exists without a remaining entitlement (bridge seam) | bridge, amm, accounting |
| `SHAPE-K188` | Payment obligation exists without a remaining entitlement (payments seam) | payments, nft, vault |
| `SHAPE-K189` | Payment obligation exists without a remaining entitlement (privilege seam) | amm, payments, vault |
| `SHAPE-K190` | Payment obligation exists without a remaining entitlement (stablecoin seam) | stablecoin, payments, vault |
| `SHAPE-K192` | Payment obligation exists without a remaining entitlement (vault seam) | vault, callback, payments |
| `SHAPE-K194` | A role that looks view-only writes a parameter that reprices claims | accounting, oracle |
| `SHAPE-K195` | A role that looks view-only writes a parameter that reprices claims (amm seam) | amm, oracle |
| `SHAPE-K196` | A role that looks view-only writes a parameter that reprices claims (bridge seam) | bridge, oracle |
| `SHAPE-K197` | A role that looks view-only writes a parameter that reprices claims (lending seam) | lending, oracle |
| `SHAPE-K198` | A role that looks view-only writes a parameter that reprices claims (payments seam) | payments, nft, oracle |
| `SHAPE-K199` | A role that looks view-only writes a parameter that reprices claims (privilege seam) | oracle, lending, amm |
| `SHAPE-K200` | A role that looks view-only writes a parameter that reprices claims (stablecoin seam) | stablecoin, amm, oracle |
| `SHAPE-K201` | A role that looks view-only writes a parameter that reprices claims (staking seam) | staking, oracle, accounting |
| `SHAPE-K202` | A role that looks view-only writes a parameter that reprices claims (vault seam) | vault, bridge, oracle |
| `SHAPE-K210` | Price used to create a position is not the price that keeps the system solvent (privilege seam) | amm, oracle, lending |
| `SHAPE-K214` | Price used to create a position is not the price that keeps the system solvent (vault #2) | vault, payments, lending |
| `SHAPE-K217` | A queued claim is transferable into a different backing or settlement state (bridge seam) | bridge, nft, payments |
| `SHAPE-K219` | A queued claim is transferable into a different backing or settlement state (payments seam) | payments, nft, vault |
| `SHAPE-K220` | A queued claim is transferable into a different backing or settlement state (privilege seam) | callback, payments, vault |
| `SHAPE-K221` | A queued claim is transferable into a different backing or settlement state (stablecoin seam) | stablecoin, payments, lending |
| `SHAPE-K222` | A queued claim is transferable into a different backing or settlement state (vault seam) | vault, staking, payments |
| `SHAPE-K225` | Recorded balance exceeds transferable balance (bridge seam) | bridge, amm, nft |
| `SHAPE-K228` | Recorded balance exceeds transferable balance (payments seam) | payments, accounting, vault |
| `SHAPE-K229` | Recorded balance exceeds transferable balance (privilege seam) | amm, staking, vault |
| `SHAPE-K230` | Recorded balance exceeds transferable balance (stablecoin seam) | stablecoin, lending, vault |
| `SHAPE-K233` | Recorded balance exceeds transferable balance via execute | vault, payments, accounting |
| `SHAPE-K234` | Recorded balance exceeds transferable balance via initialize | vault, staking, accounting |
| `SHAPE-K237` | Refund or cancel does not restore the original claim, or restores it twice (payments seam) | payments, amm, nft |
| `SHAPE-K238` | Refund or cancel does not restore the original claim, or restores it twice (privilege seam) | payments |
| `SHAPE-K241` | Same intent settled twice after validator, implementation, or config change (bridge seam) | bridge, signature |
| `SHAPE-K242` | Same intent settled twice after validator, implementation, or config change (payments seam) | payments, nft, bridge |
| `SHAPE-K243` | Same intent settled twice after validator, implementation, or config change (privilege seam) | staking, bridge, signature |
| `SHAPE-K244` | Same intent settled twice after validator, implementation, or config change (stablecoin seam) | stablecoin, signature, bridge |
| `SHAPE-K245` | Same intent settled twice after validator, implementation, or config change (vault seam) | vault, payments, nft |
| `SHAPE-K254` | Liquidation or redemption uses a mark a same-tx actor can move (privilege seam) | nft, accounting, oracle |
| `SHAPE-K257` | Signed bytes authorize a different execution context than the signer saw | amm, nft, signature |
| `SHAPE-K258` | Signed bytes authorize a different execution context than the signer saw (bridge seam) | bridge, signature, oracle |
| `SHAPE-K259` | Signed bytes authorize a different execution context than the signer saw (lending seam) | lending, signature |
| `SHAPE-K260` | Signed bytes authorize a different execution context than the signer saw (nft seam) | nft, signature |
| `SHAPE-K261` | Signed bytes authorize a different execution context than the signer saw (payments seam) | payments, amm, signature |
| `SHAPE-K262` | Signed bytes authorize a different execution context than the signer saw (privilege seam) | signature, nft, callback |
| `SHAPE-K263` | Signed bytes authorize a different execution context than the signer saw (signature seam) | signature |
| `SHAPE-K264` | Signed bytes authorize a different execution context than the signer saw (stablecoin seam) | stablecoin, payments, bridge |
| `SHAPE-K265` | Signed bytes authorize a different execution context than the signer saw (vault seam) | vault, stablecoin, lending |
| `SHAPE-K268` | Supply and backing move in opposite directions on a conservation-neutral user action (privilege seam) | accounting, vault, lending |
| `SHAPE-K269` | Supply and backing move in opposite directions on a conservation-neutral user action (stablecoin seam) | stablecoin, vault, accounting |
| `SHAPE-K270` | Supply and backing move in opposite directions on a conservation-neutral user action (vault seam) | vault, amm, accounting |
| `SHAPE-K271` | A time lock, cooldown, or expiry is true in storage and false at the write | bridge, payments |
| `SHAPE-K272` | A time lock, cooldown, or expiry is true in storage and false at the write (privilege seam) | staking, payments |
| `SHAPE-K273` | A time lock, cooldown, or expiry is true in storage and false at the write (staking seam) | staking, payments |
| `SHAPE-K278` | Two ledgers of the same fact disagree after every call returns success (payments seam) | payments, bridge, accounting |
| `SHAPE-K279` | Two ledgers of the same fact disagree after every call returns success (privilege seam) | signature, accounting, amm |
| `SHAPE-K280` | Two ledgers of the same fact disagree after every call returns success (stablecoin seam) | stablecoin, staking, accounting |
| `SHAPE-K281` | Two ledgers of the same fact disagree after every call returns success (vault seam) | vault, oracle, amm |
