# vault seam — shape index

Browse file. **Do not load this file on a hunt.** Use:

`scripts/shape_retrieve.sh vault`

104 shapes tagged `vault`.

| ID | Name | Other seams |
| :--- | :--- | :--- |
| `SHAPE-K010` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (vault seam) | stablecoin, privilege, amm |
| `SHAPE-K011` | Pool reserves and LP claims disagree after a valid swap, mint, or hook via borrow | lending, amm, accounting |
| `SHAPE-K040` | Authorization in A, execution in B (vault seam) | oracle, privilege, amm |
| `SHAPE-K041` | Authorization in A, execution in B via approve/deposit | privilege, amm, callback |
| `SHAPE-K042` | Authorization in A, execution in B via mint/approve | privilege, payments, stablecoin |
| `SHAPE-K043` | Authorization in A, execution in B via deposit | privilege, amm, payments |
| `SHAPE-K044` | Authorization in A, execution in B (vault #2) | privilege, payments, lending |
| `SHAPE-K045` | Authorization in A, execution in B (vault #3) | payments, privilege, amm |
| `SHAPE-K046` | Authorization in A, execution in B (vault #4) | privilege, payments, amm |
| `SHAPE-K047` | Authorization in A, execution in B (vault #5) | payments, privilege, oracle |
| `SHAPE-K054` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (vault seam) | stablecoin, payments, oracle |
| `SHAPE-K055` | Burn without matching release, or release without matching burn | accounting, stablecoin, bridge |
| `SHAPE-K056` | Burn without matching release, or release without matching burn (vault seam) | privilege, amm, callback |
| `SHAPE-K064` | A check's meaning is invalidated between pass and settlement (vault seam) | stablecoin, payments, bridge |
| `SHAPE-K065` | A check's meaning is invalidated between pass and settlement (vault #2) | privilege, amm, nft |
| `SHAPE-K067` | Claims stay constant while redeemable assets fall (privilege seam) | privilege, staking, accounting |
| `SHAPE-K068` | Claims stay constant while redeemable assets fall (stablecoin seam) | stablecoin, lending, nft |
| `SHAPE-K069` | Claims stay constant while redeemable assets fall (staking seam) | staking, accounting |
| `SHAPE-K070` | Claims stay constant while redeemable assets fall (vault seam) | oracle, lending, accounting |
| `SHAPE-K071` | Claims stay constant while redeemable assets fall via deposit | stablecoin, privilege, signature |
| `SHAPE-K072` | Claims stay constant while redeemable assets fall via mint | privilege, accounting, amm |
| `SHAPE-K073` | Claims stay constant while redeemable assets fall via queue | amm, accounting, privilege |
| `SHAPE-K074` | Claims stay constant while redeemable assets fall via settle | payments, oracle, lending |
| `SHAPE-K075` | Claims stay constant while redeemable assets fall via stake | staking, accounting |
| `SHAPE-K077` | Empty, dust, or first-actor rate lets the next actor's claim dominate (vault seam) | stablecoin, amm, accounting |
| `SHAPE-K078` | Entitlement exists without a corresponding payment obligation | bridge, privilege, nft |
| `SHAPE-K079` | Entitlement exists without a corresponding payment obligation (lending seam) | lending, stablecoin, payments |
| `SHAPE-K080` | Entitlement exists without a corresponding payment obligation (payments seam) | payments, stablecoin, privilege |
| `SHAPE-K081` | Entitlement exists without a corresponding payment obligation (privilege seam) | privilege, stablecoin, payments |
| `SHAPE-K082` | Entitlement exists without a corresponding payment obligation (stablecoin seam) | stablecoin, privilege, payments |
| `SHAPE-K083` | Entitlement exists without a corresponding payment obligation (staking seam) | staking, stablecoin, payments |
| `SHAPE-K084` | Entitlement exists without a corresponding payment obligation (vault seam) | nft, stablecoin, payments |
| `SHAPE-K085` | Entitlement exists without a corresponding payment obligation via transfer | stablecoin, oracle, amm |
| `SHAPE-K093` | Time or epoch boundary where a right survives into the next epoch's parameters (vault seam) | staking, oracle, payments |
| `SHAPE-K100` | Two representations of the same fact can diverge while every individual function returns success (vault seam) | accounting, privilege, payments |
| `SHAPE-K101` | Fast path updates a subset of the state the slow path updates | accounting, payments, lending |
| `SHAPE-K102` | Fast path updates a subset of the state the slow path updates (bridge seam) | bridge, payments, lending |
| `SHAPE-K103` | Fast path updates a subset of the state the slow path updates (payments seam) | payments, staking, accounting |
| `SHAPE-K104` | Fast path updates a subset of the state the slow path updates (privilege seam) | privilege, payments, lending |
| `SHAPE-K105` | Fast path updates a subset of the state the slow path updates (stablecoin seam) | stablecoin, privilege, payments |
| `SHAPE-K106` | Fast path updates a subset of the state the slow path updates (staking seam) | staking, accounting, payments |
| `SHAPE-K107` | Fast path updates a subset of the state the slow path updates (vault seam) | staking, payments, lending |
| `SHAPE-K115` | Flag says closed while a write path still treats the surface as open (vault seam) | privilege, staking, lending |
| `SHAPE-K118` | Prepaid execution credit and actual settlement charge disagree, moving value (vault seam) | privilege, amm, bridge |
| `SHAPE-K119` | Yield or harvest credits a ledger that cannot be the depositor's claim | amm, staking, accounting |
| `SHAPE-K121` | Yield or harvest credits a ledger that cannot be the depositor's claim (callback seam) | callback, accounting, staking |
| `SHAPE-K122` | Yield or harvest credits a ledger that cannot be the depositor's claim (lending seam) | lending, staking |
| `SHAPE-K123` | Yield or harvest credits a ledger that cannot be the depositor's claim (nft seam) | nft, staking |
| `SHAPE-K124` | Yield or harvest credits a ledger that cannot be the depositor's claim (payments seam) | payments, privilege, staking |
| `SHAPE-K125` | Yield or harvest credits a ledger that cannot be the depositor's claim (privilege seam) | privilege, amm, staking |
| `SHAPE-K127` | Yield or harvest credits a ledger that cannot be the depositor's claim (staking seam) | staking |
| `SHAPE-K128` | Yield or harvest credits a ledger that cannot be the depositor's claim (vault seam) | privilege, staking, amm |
| `SHAPE-K140` | Identity that passed a check is not the identity that receives value (vault seam) | privilege, staking, payments |
| `SHAPE-K141` | Identity that passed a check is not the identity that receives value (vault #2) | payments, signature, nft |
| `SHAPE-K149` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (vault seam) | stablecoin, payments, privilege |
| `SHAPE-K150` | Legacy path still ACTIVE after new accounting took over | amm, privilege |
| `SHAPE-K160` | Two components each locally conservative, jointly creating unbacked claims (vault seam) | payments, accounting, callback |
| `SHAPE-K165` | Message or receipt accepted on one side without the lock or burn on the other (vault seam) | bridge, accounting |
| `SHAPE-K174` | Custody of a unique token diverges from the rental or borrow right that should control it (vault seam) | nft, callback, privilege |
| `SHAPE-K179` | A one-shot right can be consumed twice across two adapters (vault seam) | payments, nft, callback |
| `SHAPE-K184` | Pause or kill-switch blocks the documented path but not a value-moving sibling (vault seam) | privilege, amm, staking |
| `SHAPE-K185` | Payment obligation exists without a remaining entitlement | amm, payments |
| `SHAPE-K188` | Payment obligation exists without a remaining entitlement (payments seam) | payments, privilege, nft |
| `SHAPE-K189` | Payment obligation exists without a remaining entitlement (privilege seam) | privilege, amm, payments |
| `SHAPE-K190` | Payment obligation exists without a remaining entitlement (stablecoin seam) | stablecoin, privilege, payments |
| `SHAPE-K191` | Payment obligation exists without a remaining entitlement (staking seam) | staking, payments, signature |
| `SHAPE-K192` | Payment obligation exists without a remaining entitlement (vault seam) | privilege, callback, payments |
| `SHAPE-K193` | Payment obligation exists without a remaining entitlement via unwrap | payments, bridge, lending |
| `SHAPE-K202` | A role that looks view-only writes a parameter that reprices claims (vault seam) | bridge, privilege, oracle |
| `SHAPE-K213` | Price used to create a position is not the price that keeps the system solvent (vault seam) | stablecoin, oracle, amm |
| `SHAPE-K214` | Price used to create a position is not the price that keeps the system solvent (vault #2) | payments, privilege, lending |
| `SHAPE-K215` | A queued claim is transferable into a different backing or settlement state | accounting, payments, stablecoin |
| `SHAPE-K216` | A queued claim is transferable into a different backing or settlement state (amm seam) | amm, accounting, payments |
| `SHAPE-K218` | A queued claim is transferable into a different backing or settlement state (lending seam) | lending, payments, stablecoin |
| `SHAPE-K219` | A queued claim is transferable into a different backing or settlement state (payments seam) | payments, privilege, nft |
| `SHAPE-K220` | A queued claim is transferable into a different backing or settlement state (privilege seam) | privilege, callback, payments |
| `SHAPE-K222` | A queued claim is transferable into a different backing or settlement state (vault seam) | privilege, staking, payments |
| `SHAPE-K223` | Recorded balance exceeds transferable balance | accounting |
| `SHAPE-K224` | Recorded balance exceeds transferable balance (amm seam) | amm, accounting, staking |
| `SHAPE-K226` | Recorded balance exceeds transferable balance (callback seam) | callback, accounting |
| `SHAPE-K227` | Recorded balance exceeds transferable balance (lending seam) | lending, accounting, staking |
| `SHAPE-K228` | Recorded balance exceeds transferable balance (payments seam) | payments, privilege, accounting |
| `SHAPE-K229` | Recorded balance exceeds transferable balance (privilege seam) | privilege, amm, staking |
| `SHAPE-K230` | Recorded balance exceeds transferable balance (stablecoin seam) | stablecoin, privilege, lending |
| `SHAPE-K231` | Recorded balance exceeds transferable balance (staking seam) | staking, accounting |
| `SHAPE-K232` | Recorded balance exceeds transferable balance (vault seam) | lending, amm, accounting |
| `SHAPE-K233` | Recorded balance exceeds transferable balance via execute | payments, privilege, accounting |
| `SHAPE-K234` | Recorded balance exceeds transferable balance via initialize | privilege, staking, accounting |
| `SHAPE-K235` | Recorded balance exceeds transferable balance (vault #2) | stablecoin, nft, accounting |
| `SHAPE-K245` | Same intent settled twice after validator, implementation, or config change (vault seam) | payments, privilege, nft |
| `SHAPE-K246` | Rounding direction on a conservation-neutral action creates or destroys value | accounting |
| `SHAPE-K247` | Rounding direction on a conservation-neutral action creates or destroys value (bridge seam) | bridge, accounting |
| `SHAPE-K248` | Rounding direction on a conservation-neutral action creates or destroys value (lending seam) | lending, accounting |
| `SHAPE-K249` | Rounding direction on a conservation-neutral action creates or destroys value (payments seam) | payments, accounting |
| `SHAPE-K250` | Rounding direction on a conservation-neutral action creates or destroys value (vault seam) | accounting |
| `SHAPE-K256` | Liquidation or redemption uses a mark a same-tx actor can move (vault seam) | oracle, amm, lending |
| `SHAPE-K265` | Signed bytes authorize a different execution context than the signer saw (vault seam) | stablecoin, privilege, lending |
| `SHAPE-K266` | Supply and backing move in opposite directions on a conservation-neutral user action | amm, nft, accounting |
| `SHAPE-K267` | Supply and backing move in opposite directions on a conservation-neutral user action (lending seam) | lending, accounting |
| `SHAPE-K268` | Supply and backing move in opposite directions on a conservation-neutral user action (privilege seam) | privilege, accounting, lending |
| `SHAPE-K269` | Supply and backing move in opposite directions on a conservation-neutral user action (stablecoin seam) | stablecoin, privilege, accounting |
| `SHAPE-K270` | Supply and backing move in opposite directions on a conservation-neutral user action (vault seam) | amm, accounting, privilege |
| `SHAPE-K281` | Two ledgers of the same fact disagree after every call returns success (vault seam) | oracle, privilege, amm |
| `SHAPE-K282` | An unsolicited transfer changes a rate used by a later mint without minting shares | amm, staking, accounting |
