# accounting seam — shape index

Browse file. **Do not load this file on a hunt.** Use:

`scripts/shape_retrieve.sh accounting`

90 shapes tagged `accounting`.

| ID | Name | Other seams |
| :--- | :--- | :--- |
| `SHAPE-K001` | Pool reserves and LP claims disagree after a valid swap, mint, or hook | amm |
| `SHAPE-K004` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (lending seam) | lending, amm, callback |
| `SHAPE-K005` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (oracle seam) | oracle, privilege, amm |
| `SHAPE-K011` | Pool reserves and LP claims disagree after a valid swap, mint, or hook via borrow | vault, lending, amm |
| `SHAPE-K012` | Authorization in A, execution in B | privilege, payments |
| `SHAPE-K015` | Authorization in A, execution in B (bridge seam) | bridge, privilege, payments |
| `SHAPE-K023` | Authorization in A, execution in B (payments seam) | payments, lending, nft |
| `SHAPE-K026` | Authorization in A, execution in B (payments #2) | payments, privilege, lending |
| `SHAPE-K037` | Authorization in A, execution in B via mint/cancel | stablecoin, privilege, payments |
| `SHAPE-K048` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing | lending, oracle |
| `SHAPE-K049` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (lending seam) | lending, amm, oracle |
| `SHAPE-K052` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (privilege seam) | privilege, lending, oracle |
| `SHAPE-K055` | Burn without matching release, or release without matching burn | stablecoin, bridge, vault |
| `SHAPE-K057` | A documented cap, floor, or uniqueness bound is not the bound the write path honors | privilege |
| `SHAPE-K066` | Claims stay constant while redeemable assets fall | payments, bridge, privilege |
| `SHAPE-K067` | Claims stay constant while redeemable assets fall (privilege seam) | privilege, staking, vault |
| `SHAPE-K069` | Claims stay constant while redeemable assets fall (staking seam) | staking, vault |
| `SHAPE-K070` | Claims stay constant while redeemable assets fall (vault seam) | vault, oracle, lending |
| `SHAPE-K072` | Claims stay constant while redeemable assets fall via mint | vault, privilege, amm |
| `SHAPE-K073` | Claims stay constant while redeemable assets fall via queue | vault, amm, privilege |
| `SHAPE-K075` | Claims stay constant while redeemable assets fall via stake | vault, staking |
| `SHAPE-K077` | Empty, dust, or first-actor rate lets the next actor's claim dominate (vault seam) | vault, stablecoin, amm |
| `SHAPE-K090` | Time or epoch boundary where a right survives into the next epoch's parameters (privilege seam) | privilege, amm, oracle |
| `SHAPE-K094` | Two representations of the same fact can diverge while every individual function returns success |  |
| `SHAPE-K095` | Two representations of the same fact can diverge while every individual function returns success (lending seam) | lending |
| `SHAPE-K096` | Two representations of the same fact can diverge while every individual function returns success (payments seam) | payments |
| `SHAPE-K097` | Two representations of the same fact can diverge while every individual function returns success (privilege seam) | privilege, staking |
| `SHAPE-K098` | Two representations of the same fact can diverge while every individual function returns success (stablecoin seam) | stablecoin, payments |
| `SHAPE-K099` | Two representations of the same fact can diverge while every individual function returns success (staking seam) | staking |
| `SHAPE-K100` | Two representations of the same fact can diverge while every individual function returns success (vault seam) | vault, privilege, payments |
| `SHAPE-K101` | Fast path updates a subset of the state the slow path updates | vault, payments, lending |
| `SHAPE-K103` | Fast path updates a subset of the state the slow path updates (payments seam) | payments, staking, vault |
| `SHAPE-K106` | Fast path updates a subset of the state the slow path updates (staking seam) | staking, vault, payments |
| `SHAPE-K112` | Flag says closed while a write path still treats the surface as open (privilege seam) | privilege, amm, nft |
| `SHAPE-K114` | Flag says closed while a write path still treats the surface as open (stablecoin seam) | stablecoin, privilege, amm |
| `SHAPE-K116` | Prepaid execution credit and actual settlement charge disagree, moving value | bridge, privilege, payments |
| `SHAPE-K119` | Yield or harvest credits a ledger that cannot be the depositor's claim | amm, vault, staking |
| `SHAPE-K121` | Yield or harvest credits a ledger that cannot be the depositor's claim (callback seam) | callback, vault, staking |
| `SHAPE-K126` | Yield or harvest credits a ledger that cannot be the depositor's claim (stablecoin seam) | stablecoin, staking, callback |
| `SHAPE-K129` | Identity that passed a check is not the identity that receives value | amm, payments, nft |
| `SHAPE-K151` | Two components each locally conservative, jointly creating unbacked claims | callback |
| `SHAPE-K152` | Two components each locally conservative, jointly creating unbacked claims (amm seam) | amm, staking, callback |
| `SHAPE-K153` | Two components each locally conservative, jointly creating unbacked claims (lending seam) | lending, callback |
| `SHAPE-K154` | Two components each locally conservative, jointly creating unbacked claims (nft seam) | nft, callback |
| `SHAPE-K155` | Two components each locally conservative, jointly creating unbacked claims (payments seam) | payments, signature, callback |
| `SHAPE-K156` | Two components each locally conservative, jointly creating unbacked claims (privilege seam) | privilege, staking, callback |
| `SHAPE-K157` | Two components each locally conservative, jointly creating unbacked claims (signature seam) | signature, callback |
| `SHAPE-K158` | Two components each locally conservative, jointly creating unbacked claims (stablecoin seam) | stablecoin, amm, callback |
| `SHAPE-K159` | Two components each locally conservative, jointly creating unbacked claims (staking seam) | staking, callback |
| `SHAPE-K160` | Two components each locally conservative, jointly creating unbacked claims (vault seam) | vault, payments, callback |
| `SHAPE-K165` | Message or receipt accepted on one side without the lock or burn on the other (vault seam) | vault, bridge |
| `SHAPE-K166` | Custody of a unique token diverges from the rental or borrow right that should control it | amm, nft, callback |
| `SHAPE-K169` | Custody of a unique token diverges from the rental or borrow right that should control it (nft seam) | nft, callback |
| `SHAPE-K172` | Custody of a unique token diverges from the rental or borrow right that should control it (stablecoin seam) | stablecoin, nft, callback |
| `SHAPE-K186` | Payment obligation exists without a remaining entitlement (bridge seam) | bridge, privilege, amm |
| `SHAPE-K187` | Payment obligation exists without a remaining entitlement (lending seam) | lending, amm, payments |
| `SHAPE-K194` | A role that looks view-only writes a parameter that reprices claims | privilege, oracle |
| `SHAPE-K201` | A role that looks view-only writes a parameter that reprices claims (staking seam) | staking, privilege, oracle |
| `SHAPE-K215` | A queued claim is transferable into a different backing or settlement state | payments, vault, stablecoin |
| `SHAPE-K216` | A queued claim is transferable into a different backing or settlement state (amm seam) | amm, payments, vault |
| `SHAPE-K223` | Recorded balance exceeds transferable balance | vault |
| `SHAPE-K224` | Recorded balance exceeds transferable balance (amm seam) | amm, vault, staking |
| `SHAPE-K226` | Recorded balance exceeds transferable balance (callback seam) | callback, vault |
| `SHAPE-K227` | Recorded balance exceeds transferable balance (lending seam) | lending, vault, staking |
| `SHAPE-K228` | Recorded balance exceeds transferable balance (payments seam) | payments, privilege, vault |
| `SHAPE-K231` | Recorded balance exceeds transferable balance (staking seam) | staking, vault |
| `SHAPE-K232` | Recorded balance exceeds transferable balance (vault seam) | vault, lending, amm |
| `SHAPE-K233` | Recorded balance exceeds transferable balance via execute | vault, payments, privilege |
| `SHAPE-K234` | Recorded balance exceeds transferable balance via initialize | vault, privilege, staking |
| `SHAPE-K235` | Recorded balance exceeds transferable balance (vault #2) | vault, stablecoin, nft |
| `SHAPE-K240` | Same intent settled twice after validator, implementation, or config change | amm, staking, bridge |
| `SHAPE-K246` | Rounding direction on a conservation-neutral action creates or destroys value | vault |
| `SHAPE-K247` | Rounding direction on a conservation-neutral action creates or destroys value (bridge seam) | bridge, vault |
| `SHAPE-K248` | Rounding direction on a conservation-neutral action creates or destroys value (lending seam) | lending, vault |
| `SHAPE-K249` | Rounding direction on a conservation-neutral action creates or destroys value (payments seam) | payments, vault |
| `SHAPE-K250` | Rounding direction on a conservation-neutral action creates or destroys value (vault seam) | vault |
| `SHAPE-K254` | Liquidation or redemption uses a mark a same-tx actor can move (privilege seam) | privilege, nft, oracle |
| `SHAPE-K266` | Supply and backing move in opposite directions on a conservation-neutral user action | amm, nft, vault |
| `SHAPE-K267` | Supply and backing move in opposite directions on a conservation-neutral user action (lending seam) | lending, vault |
| `SHAPE-K268` | Supply and backing move in opposite directions on a conservation-neutral user action (privilege seam) | privilege, vault, lending |
| `SHAPE-K269` | Supply and backing move in opposite directions on a conservation-neutral user action (stablecoin seam) | stablecoin, privilege, vault |
| `SHAPE-K270` | Supply and backing move in opposite directions on a conservation-neutral user action (vault seam) | vault, amm, privilege |
| `SHAPE-K274` | Two ledgers of the same fact disagree after every call returns success |  |
| `SHAPE-K275` | Two ledgers of the same fact disagree after every call returns success (amm seam) | amm, staking |
| `SHAPE-K276` | Two ledgers of the same fact disagree after every call returns success (bridge seam) | bridge, lending |
| `SHAPE-K277` | Two ledgers of the same fact disagree after every call returns success (lending seam) | lending, staking, callback |
| `SHAPE-K278` | Two ledgers of the same fact disagree after every call returns success (payments seam) | payments, bridge, privilege |
| `SHAPE-K279` | Two ledgers of the same fact disagree after every call returns success (privilege seam) | privilege, signature, amm |
| `SHAPE-K280` | Two ledgers of the same fact disagree after every call returns success (stablecoin seam) | stablecoin, privilege, staking |
| `SHAPE-K282` | An unsolicited transfer changes a rate used by a later mint without minting shares | amm, staking, vault |
