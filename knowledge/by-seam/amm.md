# amm seam — shape index

Browse file. **Do not load this file on a hunt.** Use:

`scripts/shape_retrieve.sh amm`

102 shapes tagged `amm`.

| ID | Name | Other seams |
| :--- | :--- | :--- |
| `SHAPE-K001` | Pool reserves and LP claims disagree after a valid swap, mint, or hook | accounting |
| `SHAPE-K002` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (amm seam) | staking, nft, callback |
| `SHAPE-K003` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (bridge seam) | bridge, privilege |
| `SHAPE-K004` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (lending seam) | lending, callback, accounting |
| `SHAPE-K005` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (oracle seam) | oracle, privilege, accounting |
| `SHAPE-K007` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (privilege seam) | privilege, staking, lending |
| `SHAPE-K008` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (stablecoin seam) | stablecoin, lending, privilege |
| `SHAPE-K009` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (staking seam) | staking |
| `SHAPE-K010` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (vault seam) | vault, stablecoin, privilege |
| `SHAPE-K011` | Pool reserves and LP claims disagree after a valid swap, mint, or hook via borrow | vault, lending, accounting |
| `SHAPE-K013` | Authorization in A, execution in B (amm seam) | callback, privilege, payments |
| `SHAPE-K014` | Authorization in A, execution in B (amm #2) | privilege, payments, nft |
| `SHAPE-K017` | Authorization in A, execution in B via wrap | bridge, privilege, nft |
| `SHAPE-K019` | Authorization in A, execution in B (lending seam) | lending, privilege, payments |
| `SHAPE-K024` | Authorization in A, execution in B via transfer | payments, privilege, bridge |
| `SHAPE-K025` | Authorization in A, execution in B via transfer/execute | payments, privilege, callback |
| `SHAPE-K029` | Authorization in A, execution in B (privilege seam) | privilege, payments, nft |
| `SHAPE-K030` | Authorization in A, execution in B via initialize | privilege, payments, nft |
| `SHAPE-K031` | Authorization in A, execution in B (privilege #2) | privilege, payments, callback |
| `SHAPE-K033` | Authorization in A, execution in B (privilege #3) | privilege, payments, staking |
| `SHAPE-K035` | Authorization in A, execution in B (stablecoin seam) | stablecoin, privilege, staking |
| `SHAPE-K036` | Authorization in A, execution in B via approve | stablecoin, payments, lending |
| `SHAPE-K040` | Authorization in A, execution in B (vault seam) | vault, oracle, privilege |
| `SHAPE-K041` | Authorization in A, execution in B via approve/deposit | vault, privilege, callback |
| `SHAPE-K043` | Authorization in A, execution in B via deposit | vault, privilege, payments |
| `SHAPE-K045` | Authorization in A, execution in B (vault #3) | vault, payments, privilege |
| `SHAPE-K046` | Authorization in A, execution in B (vault #4) | vault, privilege, payments |
| `SHAPE-K049` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (lending seam) | lending, oracle, accounting |
| `SHAPE-K056` | Burn without matching release, or release without matching burn (vault seam) | vault, privilege, callback |
| `SHAPE-K058` | A check's meaning is invalidated between pass and settlement | callback, payments |
| `SHAPE-K061` | A check's meaning is invalidated between pass and settlement (payments seam) | payments, callback, privilege |
| `SHAPE-K065` | A check's meaning is invalidated between pass and settlement (vault #2) | vault, privilege, nft |
| `SHAPE-K072` | Claims stay constant while redeemable assets fall via mint | vault, privilege, accounting |
| `SHAPE-K073` | Claims stay constant while redeemable assets fall via queue | vault, accounting, privilege |
| `SHAPE-K076` | Empty, dust, or first-actor rate lets the next actor's claim dominate | stablecoin, oracle, lending |
| `SHAPE-K077` | Empty, dust, or first-actor rate lets the next actor's claim dominate (vault seam) | vault, stablecoin, accounting |
| `SHAPE-K085` | Entitlement exists without a corresponding payment obligation via transfer | vault, stablecoin, oracle |
| `SHAPE-K086` | Time or epoch boundary where a right survives into the next epoch's parameters | staking, oracle, payments |
| `SHAPE-K090` | Time or epoch boundary where a right survives into the next epoch's parameters (privilege seam) | privilege, accounting, oracle |
| `SHAPE-K109` | Flag says closed while a write path still treats the surface as open (lending seam) | lending, privilege |
| `SHAPE-K110` | Flag says closed while a write path still treats the surface as open (oracle seam) | oracle, privilege |
| `SHAPE-K112` | Flag says closed while a write path still treats the surface as open (privilege seam) | privilege, nft, accounting |
| `SHAPE-K113` | Flag says closed while a write path still treats the surface as open (privilege #2) | privilege, staking |
| `SHAPE-K114` | Flag says closed while a write path still treats the surface as open (stablecoin seam) | stablecoin, privilege, accounting |
| `SHAPE-K117` | Prepaid execution credit and actual settlement charge disagree, moving value (payments seam) | payments, bridge, privilege |
| `SHAPE-K118` | Prepaid execution credit and actual settlement charge disagree, moving value (vault seam) | vault, privilege, bridge |
| `SHAPE-K119` | Yield or harvest credits a ledger that cannot be the depositor's claim | vault, staking, accounting |
| `SHAPE-K120` | Yield or harvest credits a ledger that cannot be the depositor's claim (bridge seam) | bridge, lending, nft |
| `SHAPE-K125` | Yield or harvest credits a ledger that cannot be the depositor's claim (privilege seam) | privilege, vault, staking |
| `SHAPE-K128` | Yield or harvest credits a ledger that cannot be the depositor's claim (vault seam) | vault, privilege, staking |
| `SHAPE-K129` | Identity that passed a check is not the identity that receives value | accounting, payments, nft |
| `SHAPE-K131` | Identity that passed a check is not the identity that receives value (lending seam) | lending, payments, nft |
| `SHAPE-K134` | Identity that passed a check is not the identity that receives value (payments seam) | payments, nft, privilege |
| `SHAPE-K135` | Identity that passed a check is not the identity that receives value (payments #2) | payments, nft, privilege |
| `SHAPE-K136` | Identity that passed a check is not the identity that receives value (privilege seam) | privilege, payments, nft |
| `SHAPE-K142` | Keeper or permissioned settle that a permissionless actor can force-order to capture value | staking, payments, privilege |
| `SHAPE-K146` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (payments seam) | payments, privilege, lending |
| `SHAPE-K147` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (privilege seam) | privilege, payments, lending |
| `SHAPE-K148` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (stablecoin seam) | stablecoin, bridge, privilege |
| `SHAPE-K150` | Legacy path still ACTIVE after new accounting took over | privilege, vault |
| `SHAPE-K152` | Two components each locally conservative, jointly creating unbacked claims (amm seam) | staking, accounting, callback |
| `SHAPE-K158` | Two components each locally conservative, jointly creating unbacked claims (stablecoin seam) | stablecoin, accounting, callback |
| `SHAPE-K162` | Message or receipt accepted on one side without the lock or burn on the other (payments seam) | payments, bridge, privilege |
| `SHAPE-K166` | Custody of a unique token diverges from the rental or borrow right that should control it | nft, accounting, callback |
| `SHAPE-K167` | Custody of a unique token diverges from the rental or borrow right that should control it (bridge seam) | bridge, privilege, nft |
| `SHAPE-K171` | Custody of a unique token diverges from the rental or borrow right that should control it (privilege seam) | privilege, nft, callback |
| `SHAPE-K175` | A one-shot right can be consumed twice across two adapters | lending, payments, bridge |
| `SHAPE-K184` | Pause or kill-switch blocks the documented path but not a value-moving sibling (vault seam) | vault, privilege, staking |
| `SHAPE-K185` | Payment obligation exists without a remaining entitlement | payments, vault |
| `SHAPE-K186` | Payment obligation exists without a remaining entitlement (bridge seam) | bridge, privilege, accounting |
| `SHAPE-K187` | Payment obligation exists without a remaining entitlement (lending seam) | lending, accounting, payments |
| `SHAPE-K189` | Payment obligation exists without a remaining entitlement (privilege seam) | privilege, payments, vault |
| `SHAPE-K195` | A role that looks view-only writes a parameter that reprices claims (amm seam) | privilege, oracle |
| `SHAPE-K199` | A role that looks view-only writes a parameter that reprices claims (privilege seam) | privilege, oracle, lending |
| `SHAPE-K200` | A role that looks view-only writes a parameter that reprices claims (stablecoin seam) | stablecoin, privilege, oracle |
| `SHAPE-K203` | Price used to create a position is not the price that keeps the system solvent | oracle, lending, stablecoin |
| `SHAPE-K208` | Price used to create a position is not the price that keeps the system solvent (oracle seam) | oracle, lending, stablecoin |
| `SHAPE-K209` | Price used to create a position is not the price that keeps the system solvent (payments seam) | payments, lending, nft |
| `SHAPE-K210` | Price used to create a position is not the price that keeps the system solvent (privilege seam) | privilege, oracle, lending |
| `SHAPE-K211` | Price used to create a position is not the price that keeps the system solvent (stablecoin seam) | stablecoin, oracle, lending |
| `SHAPE-K213` | Price used to create a position is not the price that keeps the system solvent (vault seam) | vault, stablecoin, oracle |
| `SHAPE-K216` | A queued claim is transferable into a different backing or settlement state (amm seam) | accounting, payments, vault |
| `SHAPE-K224` | Recorded balance exceeds transferable balance (amm seam) | vault, accounting, staking |
| `SHAPE-K225` | Recorded balance exceeds transferable balance (bridge seam) | bridge, privilege, nft |
| `SHAPE-K229` | Recorded balance exceeds transferable balance (privilege seam) | privilege, staking, vault |
| `SHAPE-K232` | Recorded balance exceeds transferable balance (vault seam) | vault, lending, accounting |
| `SHAPE-K237` | Refund or cancel does not restore the original claim, or restores it twice (payments seam) | payments, privilege, nft |
| `SHAPE-K239` | Refund or cancel does not restore the original claim, or restores it twice (stablecoin seam) | stablecoin, payments |
| `SHAPE-K240` | Same intent settled twice after validator, implementation, or config change | staking, accounting, bridge |
| `SHAPE-K251` | Liquidation or redemption uses a mark a same-tx actor can move | oracle, lending |
| `SHAPE-K252` | Liquidation or redemption uses a mark a same-tx actor can move (oracle seam) | oracle, lending |
| `SHAPE-K253` | Liquidation or redemption uses a mark a same-tx actor can move (payments seam) | payments, oracle, lending |
| `SHAPE-K255` | Liquidation or redemption uses a mark a same-tx actor can move (stablecoin seam) | stablecoin, payments, oracle |
| `SHAPE-K256` | Liquidation or redemption uses a mark a same-tx actor can move (vault seam) | vault, oracle, lending |
| `SHAPE-K257` | Signed bytes authorize a different execution context than the signer saw | nft, signature, privilege |
| `SHAPE-K261` | Signed bytes authorize a different execution context than the signer saw (payments seam) | payments, privilege, signature |
| `SHAPE-K266` | Supply and backing move in opposite directions on a conservation-neutral user action | nft, vault, accounting |
| `SHAPE-K270` | Supply and backing move in opposite directions on a conservation-neutral user action (vault seam) | vault, accounting, privilege |
| `SHAPE-K275` | Two ledgers of the same fact disagree after every call returns success (amm seam) | accounting, staking |
| `SHAPE-K279` | Two ledgers of the same fact disagree after every call returns success (privilege seam) | privilege, signature, accounting |
| `SHAPE-K281` | Two ledgers of the same fact disagree after every call returns success (vault seam) | vault, oracle, privilege |
| `SHAPE-K282` | An unsolicited transfer changes a rate used by a later mint without minting shares | staking, accounting, vault |
