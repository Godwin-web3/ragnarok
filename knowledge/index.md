# Knowledge shape index

Abstract STATE generators distilled from Zaevlad/audit-findings-dataset.
Not a vulnerability catalog. After SYNTHESIS OPEN, load only a seam-matched pack:

```
scripts/shape_retrieve.sh vault oracle
```

Corpus size: 282 distinct shapes.
Filter stats: {"abstracted": 1864, "clusters": 282, "dedup_dropped": 18, "drop_medium_weight": 1794, "drop_placeholder_poc": 10882, "drop_severity": 9036, "drop_short_desc": 31, "input": 23625, "kept": 1864}

| ID | Name | Seams | Severity | Cluster |
| :--- | :--- | :--- | :--- | ---: |
| `SHAPE-K001` | Pool reserves and LP claims disagree after a valid swap, mint, or hook | accounting, amm | Medium | 1 |
| `SHAPE-K002` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (amm seam) | amm, staking, nft, callback | High | 41 |
| `SHAPE-K003` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (bridge seam) | bridge, amm, privilege | High | 2 |
| `SHAPE-K004` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (lending seam) | lending, amm, callback, accounting | High | 10 |
| `SHAPE-K005` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (oracle seam) | oracle, privilege, amm, accounting | High | 5 |
| `SHAPE-K006` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (payments seam) | payments, oracle, privilege, lending | High | 12 |
| `SHAPE-K007` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (privilege seam) | privilege, staking, amm, lending | High | 18 |
| `SHAPE-K008` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (stablecoin seam) | stablecoin, amm, lending, privilege | Critical | 28 |
| `SHAPE-K009` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (staking seam) | staking, amm | High | 2 |
| `SHAPE-K010` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (vault seam) | vault, stablecoin, privilege, amm | Critical | 34 |
| `SHAPE-K011` | Pool reserves and LP claims disagree after a valid swap, mint, or hook via borrow | vault, lending, amm, accounting | Critical | 18 |
| `SHAPE-K012` | Authorization in A, execution in B | accounting, privilege, payments | Medium | 3 |
| `SHAPE-K013` | Authorization in A, execution in B (amm seam) | amm, callback, privilege, payments | High | 10 |
| `SHAPE-K014` | Authorization in A, execution in B (amm #2) | amm, privilege, payments, nft | High | 2 |
| `SHAPE-K015` | Authorization in A, execution in B (bridge seam) | bridge, privilege, payments, accounting | High | 9 |
| `SHAPE-K016` | Authorization in A, execution in B via burn | bridge, privilege, payments, callback | High | 6 |
| `SHAPE-K017` | Authorization in A, execution in B via wrap | bridge, privilege, amm, nft | Medium | 1 |
| `SHAPE-K018` | Authorization in A, execution in B (callback seam) | callback, privilege, payments | High | 2 |
| `SHAPE-K019` | Authorization in A, execution in B (lending seam) | lending, privilege, payments, amm | High | 5 |
| `SHAPE-K020` | Authorization in A, execution in B (nft seam) | nft, privilege, payments, callback | High | 11 |
| `SHAPE-K021` | Authorization in A, execution in B (oracle seam) | oracle, privilege, payments, lending | High | 7 |
| `SHAPE-K022` | Authorization in A, execution in B (oracle #2) | oracle, privilege, payments | High | 1 |
| `SHAPE-K023` | Authorization in A, execution in B (payments seam) | payments, lending, nft, accounting | High | 21 |
| `SHAPE-K024` | Authorization in A, execution in B via transfer | payments, privilege, amm, bridge | High | 11 |
| `SHAPE-K025` | Authorization in A, execution in B via transfer/execute | payments, privilege, amm, callback | Critical | 10 |
| `SHAPE-K026` | Authorization in A, execution in B (payments #2) | payments, privilege, accounting, lending | High | 9 |
| `SHAPE-K027` | Authorization in A, execution in B (payments #3) | payments, bridge, privilege, signature | High | 7 |
| `SHAPE-K028` | Authorization in A, execution in B (payments #4) | payments, nft, callback, privilege | High | 6 |
| `SHAPE-K029` | Authorization in A, execution in B (privilege seam) | privilege, payments, nft, amm | Critical | 39 |
| `SHAPE-K030` | Authorization in A, execution in B via initialize | privilege, amm, payments, nft | Critical | 20 |
| `SHAPE-K031` | Authorization in A, execution in B (privilege #2) | privilege, payments, callback, amm | High | 19 |
| `SHAPE-K032` | Authorization in A, execution in B via mint | privilege, payments, nft, staking | High | 14 |
| `SHAPE-K033` | Authorization in A, execution in B (privilege #3) | privilege, amm, payments, staking | Critical | 8 |
| `SHAPE-K034` | Authorization in A, execution in B (signature seam) | signature, privilege, payments | High | 3 |
| `SHAPE-K035` | Authorization in A, execution in B (stablecoin seam) | stablecoin, privilege, amm, staking | High | 15 |
| `SHAPE-K036` | Authorization in A, execution in B via approve | stablecoin, payments, lending, amm | High | 12 |
| `SHAPE-K037` | Authorization in A, execution in B via mint/cancel | stablecoin, accounting, privilege, payments | High | 7 |
| `SHAPE-K038` | Authorization in A, execution in B (stablecoin #2) | stablecoin, oracle, privilege, callback | High | 1 |
| `SHAPE-K039` | Authorization in A, execution in B (staking seam) | staking, privilege, payments, nft | High | 5 |
| `SHAPE-K040` | Authorization in A, execution in B (vault seam) | vault, oracle, privilege, amm | High | 25 |
| `SHAPE-K041` | Authorization in A, execution in B via approve/deposit | vault, privilege, amm, callback | High | 18 |
| `SHAPE-K042` | Authorization in A, execution in B via mint/approve | vault, privilege, payments, stablecoin | Critical | 16 |
| `SHAPE-K043` | Authorization in A, execution in B via deposit | vault, privilege, amm, payments | Critical | 16 |
| `SHAPE-K044` | Authorization in A, execution in B (vault #2) | vault, privilege, payments, lending | Critical | 13 |
| `SHAPE-K045` | Authorization in A, execution in B (vault #3) | vault, payments, privilege, amm | High | 12 |
| `SHAPE-K046` | Authorization in A, execution in B (vault #4) | vault, privilege, payments, amm | Critical | 9 |
| `SHAPE-K047` | Authorization in A, execution in B (vault #5) | vault, payments, privilege, oracle | High | 6 |
| `SHAPE-K048` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing | accounting, lending, oracle | High | 1 |
| `SHAPE-K049` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (lending seam) | lending, amm, oracle, accounting | High | 12 |
| `SHAPE-K050` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (oracle seam) | oracle, lending | High | 1 |
| `SHAPE-K051` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (payments seam) | payments, oracle, privilege, lending | High | 5 |
| `SHAPE-K052` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (privilege seam) | privilege, accounting, lending, oracle | High | 2 |
| `SHAPE-K053` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (stablecoin seam) | stablecoin, payments, privilege, lending | High | 5 |
| `SHAPE-K054` | Debt exists without the collateral the solvency check used, or collateral is seized without debt closing (vault seam) | vault, stablecoin, payments, oracle | Critical | 28 |
| `SHAPE-K055` | Burn without matching release, or release without matching burn | accounting, stablecoin, bridge, vault | High | 1 |
| `SHAPE-K056` | Burn without matching release, or release without matching burn (vault seam) | vault, privilege, amm, callback | High | 1 |
| `SHAPE-K057` | A documented cap, floor, or uniqueness bound is not the bound the write path honors | privilege, accounting | High | 2 |
| `SHAPE-K058` | A check's meaning is invalidated between pass and settlement | amm, callback, payments | High | 5 |
| `SHAPE-K059` | A check's meaning is invalidated between pass and settlement (callback seam) | callback, payments | Critical | 5 |
| `SHAPE-K060` | A check's meaning is invalidated between pass and settlement (lending seam) | lending, nft, callback, payments | High | 2 |
| `SHAPE-K061` | A check's meaning is invalidated between pass and settlement (payments seam) | payments, amm, callback, privilege | High | 4 |
| `SHAPE-K062` | A check's meaning is invalidated between pass and settlement (privilege seam) | privilege, lending, nft, callback | High | 2 |
| `SHAPE-K063` | A check's meaning is invalidated between pass and settlement (stablecoin seam) | stablecoin, staking, callback, payments | Critical | 6 |
| `SHAPE-K064` | A check's meaning is invalidated between pass and settlement (vault seam) | vault, stablecoin, payments, bridge | High | 8 |
| `SHAPE-K065` | A check's meaning is invalidated between pass and settlement (vault #2) | vault, privilege, amm, nft | High | 2 |
| `SHAPE-K066` | Claims stay constant while redeemable assets fall | payments, bridge, privilege, accounting | Medium | 1 |
| `SHAPE-K067` | Claims stay constant while redeemable assets fall (privilege seam) | privilege, staking, vault, accounting | High | 3 |
| `SHAPE-K068` | Claims stay constant while redeemable assets fall (stablecoin seam) | stablecoin, lending, nft, vault | Critical | 5 |
| `SHAPE-K069` | Claims stay constant while redeemable assets fall (staking seam) | staking, vault, accounting | High | 2 |
| `SHAPE-K070` | Claims stay constant while redeemable assets fall (vault seam) | vault, oracle, lending, accounting | Critical | 48 |
| `SHAPE-K071` | Claims stay constant while redeemable assets fall via deposit | vault, stablecoin, privilege, signature | Critical | 39 |
| `SHAPE-K072` | Claims stay constant while redeemable assets fall via mint | vault, privilege, accounting, amm | High | 37 |
| `SHAPE-K073` | Claims stay constant while redeemable assets fall via queue | vault, amm, accounting, privilege | Critical | 18 |
| `SHAPE-K074` | Claims stay constant while redeemable assets fall via settle | vault, payments, oracle, lending | High | 16 |
| `SHAPE-K075` | Claims stay constant while redeemable assets fall via stake | vault, staking, accounting | Critical | 4 |
| `SHAPE-K076` | Empty, dust, or first-actor rate lets the next actor's claim dominate | stablecoin, oracle, lending, amm | High | 1 |
| `SHAPE-K077` | Empty, dust, or first-actor rate lets the next actor's claim dominate (vault seam) | vault, stablecoin, amm, accounting | High | 8 |
| `SHAPE-K078` | Entitlement exists without a corresponding payment obligation | bridge, privilege, nft, vault | High | 1 |
| `SHAPE-K079` | Entitlement exists without a corresponding payment obligation (lending seam) | lending, vault, stablecoin, payments | Medium | 2 |
| `SHAPE-K080` | Entitlement exists without a corresponding payment obligation (payments seam) | payments, vault, stablecoin, privilege | High | 4 |
| `SHAPE-K081` | Entitlement exists without a corresponding payment obligation (privilege seam) | privilege, vault, stablecoin, payments | High | 1 |
| `SHAPE-K082` | Entitlement exists without a corresponding payment obligation (stablecoin seam) | stablecoin, privilege, vault, payments | High | 1 |
| `SHAPE-K083` | Entitlement exists without a corresponding payment obligation (staking seam) | staking, vault, stablecoin, payments | Medium | 1 |
| `SHAPE-K084` | Entitlement exists without a corresponding payment obligation (vault seam) | vault, nft, stablecoin, payments | Critical | 8 |
| `SHAPE-K085` | Entitlement exists without a corresponding payment obligation via transfer | vault, stablecoin, oracle, amm | High | 1 |
| `SHAPE-K086` | Time or epoch boundary where a right survives into the next epoch's parameters | amm, staking, oracle, payments | High | 6 |
| `SHAPE-K087` | Time or epoch boundary where a right survives into the next epoch's parameters (nft seam) | nft, oracle, payments, lending | Medium | 1 |
| `SHAPE-K088` | Time or epoch boundary where a right survives into the next epoch's parameters (oracle seam) | oracle, payments, lending | High | 8 |
| `SHAPE-K089` | Time or epoch boundary where a right survives into the next epoch's parameters (payments seam) | payments, privilege, oracle, lending | High | 2 |
| `SHAPE-K090` | Time or epoch boundary where a right survives into the next epoch's parameters (privilege seam) | privilege, amm, accounting, oracle | Medium | 2 |
| `SHAPE-K091` | Time or epoch boundary where a right survives into the next epoch's parameters (stablecoin seam) | stablecoin, payments, oracle, lending | High | 2 |
| `SHAPE-K092` | Time or epoch boundary where a right survives into the next epoch's parameters (staking seam) | staking, oracle, payments, lending | High | 1 |
| `SHAPE-K093` | Time or epoch boundary where a right survives into the next epoch's parameters (vault seam) | vault, staking, oracle, payments | High | 8 |
| `SHAPE-K094` | Two representations of the same fact can diverge while every individual function returns success | accounting | Critical | 41 |
| `SHAPE-K095` | Two representations of the same fact can diverge while every individual function returns success (lending seam) | lending, accounting | High | 1 |
| `SHAPE-K096` | Two representations of the same fact can diverge while every individual function returns success (payments seam) | payments, accounting | High | 6 |
| `SHAPE-K097` | Two representations of the same fact can diverge while every individual function returns success (privilege seam) | privilege, staking, accounting | Critical | 13 |
| `SHAPE-K098` | Two representations of the same fact can diverge while every individual function returns success (stablecoin seam) | stablecoin, accounting, payments | High | 4 |
| `SHAPE-K099` | Two representations of the same fact can diverge while every individual function returns success (staking seam) | staking, accounting | High | 5 |
| `SHAPE-K100` | Two representations of the same fact can diverge while every individual function returns success (vault seam) | vault, accounting, privilege, payments | Critical | 14 |
| `SHAPE-K101` | Fast path updates a subset of the state the slow path updates | accounting, vault, payments, lending | High | 1 |
| `SHAPE-K102` | Fast path updates a subset of the state the slow path updates (bridge seam) | bridge, vault, payments, lending | High | 2 |
| `SHAPE-K103` | Fast path updates a subset of the state the slow path updates (payments seam) | payments, staking, accounting, vault | High | 3 |
| `SHAPE-K104` | Fast path updates a subset of the state the slow path updates (privilege seam) | privilege, vault, payments, lending | High | 1 |
| `SHAPE-K105` | Fast path updates a subset of the state the slow path updates (stablecoin seam) | stablecoin, privilege, vault, payments | High | 3 |
| `SHAPE-K106` | Fast path updates a subset of the state the slow path updates (staking seam) | staking, accounting, vault, payments | Medium | 1 |
| `SHAPE-K107` | Fast path updates a subset of the state the slow path updates (vault seam) | vault, staking, payments, lending | High | 4 |
| `SHAPE-K108` | Flag says closed while a write path still treats the surface as open | callback, privilege | High | 2 |
| `SHAPE-K109` | Flag says closed while a write path still treats the surface as open (lending seam) | lending, amm, privilege | High | 2 |
| `SHAPE-K110` | Flag says closed while a write path still treats the surface as open (oracle seam) | oracle, privilege, amm | High | 1 |
| `SHAPE-K111` | Flag says closed while a write path still treats the surface as open (payments seam) | payments, privilege, staking, callback | High | 5 |
| `SHAPE-K112` | Flag says closed while a write path still treats the surface as open (privilege seam) | privilege, amm, nft, accounting | Critical | 33 |
| `SHAPE-K113` | Flag says closed while a write path still treats the surface as open (privilege #2) | privilege, staking, amm | High | 9 |
| `SHAPE-K114` | Flag says closed while a write path still treats the surface as open (stablecoin seam) | stablecoin, privilege, amm, accounting | Critical | 10 |
| `SHAPE-K115` | Flag says closed while a write path still treats the surface as open (vault seam) | vault, privilege, staking, lending | Critical | 19 |
| `SHAPE-K116` | Prepaid execution credit and actual settlement charge disagree, moving value | bridge, privilege, accounting, payments | High | 2 |
| `SHAPE-K117` | Prepaid execution credit and actual settlement charge disagree, moving value (payments seam) | payments, bridge, privilege, amm | High | 3 |
| `SHAPE-K118` | Prepaid execution credit and actual settlement charge disagree, moving value (vault seam) | vault, privilege, amm, bridge | High | 1 |
| `SHAPE-K119` | Yield or harvest credits a ledger that cannot be the depositor's claim | amm, vault, staking, accounting | Critical | 12 |
| `SHAPE-K120` | Yield or harvest credits a ledger that cannot be the depositor's claim (bridge seam) | bridge, lending, amm, nft | High | 1 |
| `SHAPE-K121` | Yield or harvest credits a ledger that cannot be the depositor's claim (callback seam) | callback, accounting, vault, staking | High | 1 |
| `SHAPE-K122` | Yield or harvest credits a ledger that cannot be the depositor's claim (lending seam) | lending, vault, staking | Medium | 1 |
| `SHAPE-K123` | Yield or harvest credits a ledger that cannot be the depositor's claim (nft seam) | nft, vault, staking | High | 1 |
| `SHAPE-K124` | Yield or harvest credits a ledger that cannot be the depositor's claim (payments seam) | payments, privilege, staking, vault | High | 3 |
| `SHAPE-K125` | Yield or harvest credits a ledger that cannot be the depositor's claim (privilege seam) | privilege, amm, vault, staking | Critical | 5 |
| `SHAPE-K126` | Yield or harvest credits a ledger that cannot be the depositor's claim (stablecoin seam) | stablecoin, staking, callback, accounting | High | 6 |
| `SHAPE-K127` | Yield or harvest credits a ledger that cannot be the depositor's claim (staking seam) | staking, vault | Medium | 1 |
| `SHAPE-K128` | Yield or harvest credits a ledger that cannot be the depositor's claim (vault seam) | vault, privilege, staking, amm | High | 10 |
| `SHAPE-K129` | Identity that passed a check is not the identity that receives value | amm, accounting, payments, nft | High | 4 |
| `SHAPE-K130` | Identity that passed a check is not the identity that receives value (bridge seam) | bridge, lending, payments, nft | Critical | 5 |
| `SHAPE-K131` | Identity that passed a check is not the identity that receives value (lending seam) | lending, amm, payments, nft | High | 2 |
| `SHAPE-K132` | Identity that passed a check is not the identity that receives value (nft seam) | nft, payments, privilege | High | 8 |
| `SHAPE-K133` | Identity that passed a check is not the identity that receives value (oracle seam) | oracle, privilege, lending, payments | High | 1 |
| `SHAPE-K134` | Identity that passed a check is not the identity that receives value (payments seam) | payments, nft, privilege, amm | High | 20 |
| `SHAPE-K135` | Identity that passed a check is not the identity that receives value (payments #2) | payments, nft, privilege, amm | High | 13 |
| `SHAPE-K136` | Identity that passed a check is not the identity that receives value (privilege seam) | privilege, payments, nft, amm | Critical | 21 |
| `SHAPE-K137` | Identity that passed a check is not the identity that receives value via permit | privilege, signature, payments, nft | High | 2 |
| `SHAPE-K138` | Identity that passed a check is not the identity that receives value (stablecoin seam) | stablecoin, payments, privilege, nft | Critical | 13 |
| `SHAPE-K139` | Identity that passed a check is not the identity that receives value (staking seam) | staking, payments, nft, privilege | High | 4 |
| `SHAPE-K140` | Identity that passed a check is not the identity that receives value (vault seam) | vault, privilege, staking, payments | High | 20 |
| `SHAPE-K141` | Identity that passed a check is not the identity that receives value (vault #2) | vault, payments, signature, nft | High | 4 |
| `SHAPE-K142` | Keeper or permissioned settle that a permissionless actor can force-order to capture value | amm, staking, payments, privilege | High | 5 |
| `SHAPE-K143` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (bridge seam) | bridge, privilege, payments, lending | Medium | 1 |
| `SHAPE-K144` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (nft seam) | nft, payments, privilege, lending | High | 2 |
| `SHAPE-K145` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (oracle seam) | oracle, privilege, lending, staking | High | 1 |
| `SHAPE-K146` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (payments seam) | payments, amm, privilege, lending | Critical | 9 |
| `SHAPE-K147` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (privilege seam) | privilege, payments, lending, amm | Critical | 5 |
| `SHAPE-K148` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (stablecoin seam) | stablecoin, bridge, privilege, amm | High | 4 |
| `SHAPE-K149` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (vault seam) | vault, stablecoin, payments, privilege | High | 8 |
| `SHAPE-K150` | Legacy path still ACTIVE after new accounting took over | amm, privilege, vault | Medium | 1 |
| `SHAPE-K151` | Two components each locally conservative, jointly creating unbacked claims | accounting, callback | Critical | 8 |
| `SHAPE-K152` | Two components each locally conservative, jointly creating unbacked claims (amm seam) | amm, staking, accounting, callback | High | 1 |
| `SHAPE-K153` | Two components each locally conservative, jointly creating unbacked claims (lending seam) | lending, accounting, callback | High | 1 |
| `SHAPE-K154` | Two components each locally conservative, jointly creating unbacked claims (nft seam) | nft, accounting, callback | High | 2 |
| `SHAPE-K155` | Two components each locally conservative, jointly creating unbacked claims (payments seam) | payments, signature, accounting, callback | Critical | 4 |
| `SHAPE-K156` | Two components each locally conservative, jointly creating unbacked claims (privilege seam) | privilege, staking, accounting, callback | High | 4 |
| `SHAPE-K157` | Two components each locally conservative, jointly creating unbacked claims (signature seam) | signature, accounting, callback | High | 1 |
| `SHAPE-K158` | Two components each locally conservative, jointly creating unbacked claims (stablecoin seam) | stablecoin, amm, accounting, callback | High | 1 |
| `SHAPE-K159` | Two components each locally conservative, jointly creating unbacked claims (staking seam) | staking, accounting, callback | High | 1 |
| `SHAPE-K160` | Two components each locally conservative, jointly creating unbacked claims (vault seam) | vault, payments, accounting, callback | Critical | 6 |
| `SHAPE-K161` | Message or receipt accepted on one side without the lock or burn on the other | bridge, privilege, nft, callback | Critical | 27 |
| `SHAPE-K162` | Message or receipt accepted on one side without the lock or burn on the other (payments seam) | payments, bridge, privilege, amm | High | 12 |
| `SHAPE-K163` | Message or receipt accepted on one side without the lock or burn on the other (privilege seam) | privilege, signature, bridge, nft | Critical | 7 |
| `SHAPE-K164` | Message or receipt accepted on one side without the lock or burn on the other (stablecoin seam) | stablecoin, bridge, nft, payments | High | 3 |
| `SHAPE-K165` | Message or receipt accepted on one side without the lock or burn on the other (vault seam) | vault, bridge, accounting | High | 1 |
| `SHAPE-K166` | Custody of a unique token diverges from the rental or borrow right that should control it | amm, nft, accounting, callback | Medium | 2 |
| `SHAPE-K167` | Custody of a unique token diverges from the rental or borrow right that should control it (bridge seam) | bridge, privilege, amm, nft | Medium | 1 |
| `SHAPE-K168` | Custody of a unique token diverges from the rental or borrow right that should control it (lending seam) | lending, nft, callback | High | 1 |
| `SHAPE-K169` | Custody of a unique token diverges from the rental or borrow right that should control it (nft seam) | nft, accounting, callback | High | 9 |
| `SHAPE-K170` | Custody of a unique token diverges from the rental or borrow right that should control it (payments seam) | payments, staking, nft, callback | Critical | 12 |
| `SHAPE-K171` | Custody of a unique token diverges from the rental or borrow right that should control it (privilege seam) | privilege, amm, nft, callback | Critical | 9 |
| `SHAPE-K172` | Custody of a unique token diverges from the rental or borrow right that should control it (stablecoin seam) | stablecoin, nft, accounting, callback | High | 2 |
| `SHAPE-K173` | Custody of a unique token diverges from the rental or borrow right that should control it (staking seam) | staking, nft, callback | High | 3 |
| `SHAPE-K174` | Custody of a unique token diverges from the rental or borrow right that should control it (vault seam) | vault, nft, callback, privilege | Critical | 17 |
| `SHAPE-K175` | A one-shot right can be consumed twice across two adapters | lending, amm, payments, bridge | High | 1 |
| `SHAPE-K176` | A one-shot right can be consumed twice across two adapters (payments seam) | payments, bridge, signature | Medium | 1 |
| `SHAPE-K177` | A one-shot right can be consumed twice across two adapters (privilege seam) | privilege, payments, bridge, signature | High | 3 |
| `SHAPE-K178` | A one-shot right can be consumed twice across two adapters (stablecoin seam) | stablecoin, payments, signature, callback | Critical | 1 |
| `SHAPE-K179` | A one-shot right can be consumed twice across two adapters (vault seam) | vault, payments, nft, callback | High | 3 |
| `SHAPE-K180` | Pause or kill-switch blocks the documented path but not a value-moving sibling | bridge, privilege | Medium | 1 |
| `SHAPE-K181` | Pause or kill-switch blocks the documented path but not a value-moving sibling (payments seam) | payments, privilege, nft, callback | High | 3 |
| `SHAPE-K182` | Pause or kill-switch blocks the documented path but not a value-moving sibling (privilege seam) | privilege, signature, nft, callback | High | 6 |
| `SHAPE-K183` | Pause or kill-switch blocks the documented path but not a value-moving sibling (stablecoin seam) | stablecoin, privilege | High | 2 |
| `SHAPE-K184` | Pause or kill-switch blocks the documented path but not a value-moving sibling (vault seam) | vault, privilege, amm, staking | High | 4 |
| `SHAPE-K185` | Payment obligation exists without a remaining entitlement | amm, payments, vault | High | 1 |
| `SHAPE-K186` | Payment obligation exists without a remaining entitlement (bridge seam) | bridge, privilege, amm, accounting | High | 1 |
| `SHAPE-K187` | Payment obligation exists without a remaining entitlement (lending seam) | lending, amm, accounting, payments | High | 2 |
| `SHAPE-K188` | Payment obligation exists without a remaining entitlement (payments seam) | payments, privilege, nft, vault | High | 7 |
| `SHAPE-K189` | Payment obligation exists without a remaining entitlement (privilege seam) | privilege, amm, payments, vault | High | 7 |
| `SHAPE-K190` | Payment obligation exists without a remaining entitlement (stablecoin seam) | stablecoin, privilege, payments, vault | High | 1 |
| `SHAPE-K191` | Payment obligation exists without a remaining entitlement (staking seam) | staking, payments, vault, signature | High | 2 |
| `SHAPE-K192` | Payment obligation exists without a remaining entitlement (vault seam) | vault, privilege, callback, payments | High | 15 |
| `SHAPE-K193` | Payment obligation exists without a remaining entitlement via unwrap | vault, payments, bridge, lending | High | 4 |
| `SHAPE-K194` | A role that looks view-only writes a parameter that reprices claims | accounting, privilege, oracle | High | 1 |
| `SHAPE-K195` | A role that looks view-only writes a parameter that reprices claims (amm seam) | amm, privilege, oracle | High | 1 |
| `SHAPE-K196` | A role that looks view-only writes a parameter that reprices claims (bridge seam) | bridge, privilege, oracle | High | 1 |
| `SHAPE-K197` | A role that looks view-only writes a parameter that reprices claims (lending seam) | lending, privilege, oracle | High | 1 |
| `SHAPE-K198` | A role that looks view-only writes a parameter that reprices claims (payments seam) | payments, nft, privilege, oracle | High | 3 |
| `SHAPE-K199` | A role that looks view-only writes a parameter that reprices claims (privilege seam) | privilege, oracle, lending, amm | Critical | 14 |
| `SHAPE-K200` | A role that looks view-only writes a parameter that reprices claims (stablecoin seam) | stablecoin, privilege, amm, oracle | High | 5 |
| `SHAPE-K201` | A role that looks view-only writes a parameter that reprices claims (staking seam) | staking, privilege, oracle, accounting | Medium | 2 |
| `SHAPE-K202` | A role that looks view-only writes a parameter that reprices claims (vault seam) | vault, bridge, privilege, oracle | High | 5 |
| `SHAPE-K203` | Price used to create a position is not the price that keeps the system solvent | amm, oracle, lending, stablecoin | High | 3 |
| `SHAPE-K204` | Price used to create a position is not the price that keeps the system solvent (bridge seam) | bridge, oracle, callback, lending | Medium | 1 |
| `SHAPE-K205` | Price used to create a position is not the price that keeps the system solvent (callback seam) | callback, oracle, lending, stablecoin | High | 1 |
| `SHAPE-K206` | Price used to create a position is not the price that keeps the system solvent (lending seam) | lending, staking, oracle, stablecoin | High | 4 |
| `SHAPE-K207` | Price used to create a position is not the price that keeps the system solvent (nft seam) | nft, oracle, lending, stablecoin | Medium | 1 |
| `SHAPE-K208` | Price used to create a position is not the price that keeps the system solvent (oracle seam) | oracle, lending, stablecoin, amm | Critical | 38 |
| `SHAPE-K209` | Price used to create a position is not the price that keeps the system solvent (payments seam) | payments, lending, amm, nft | High | 17 |
| `SHAPE-K210` | Price used to create a position is not the price that keeps the system solvent (privilege seam) | privilege, amm, oracle, lending | Critical | 19 |
| `SHAPE-K211` | Price used to create a position is not the price that keeps the system solvent (stablecoin seam) | stablecoin, oracle, lending, amm | Critical | 19 |
| `SHAPE-K212` | Price used to create a position is not the price that keeps the system solvent (staking seam) | staking, oracle, lending, stablecoin | High | 1 |
| `SHAPE-K213` | Price used to create a position is not the price that keeps the system solvent (vault seam) | vault, stablecoin, oracle, amm | Critical | 29 |
| `SHAPE-K214` | Price used to create a position is not the price that keeps the system solvent (vault #2) | vault, payments, privilege, lending | High | 24 |
| `SHAPE-K215` | A queued claim is transferable into a different backing or settlement state | accounting, payments, vault, stablecoin | Medium | 1 |
| `SHAPE-K216` | A queued claim is transferable into a different backing or settlement state (amm seam) | amm, accounting, payments, vault | High | 4 |
| `SHAPE-K217` | A queued claim is transferable into a different backing or settlement state (bridge seam) | bridge, privilege, nft, payments | Critical | 1 |
| `SHAPE-K218` | A queued claim is transferable into a different backing or settlement state (lending seam) | lending, payments, vault, stablecoin | High | 1 |
| `SHAPE-K219` | A queued claim is transferable into a different backing or settlement state (payments seam) | payments, privilege, nft, vault | High | 7 |
| `SHAPE-K220` | A queued claim is transferable into a different backing or settlement state (privilege seam) | privilege, callback, payments, vault | High | 1 |
| `SHAPE-K221` | A queued claim is transferable into a different backing or settlement state (stablecoin seam) | stablecoin, payments, privilege, lending | High | 2 |
| `SHAPE-K222` | A queued claim is transferable into a different backing or settlement state (vault seam) | vault, privilege, staking, payments | High | 8 |
| `SHAPE-K223` | Recorded balance exceeds transferable balance | accounting, vault | Medium | 1 |
| `SHAPE-K224` | Recorded balance exceeds transferable balance (amm seam) | amm, vault, accounting, staking | High | 3 |
| `SHAPE-K225` | Recorded balance exceeds transferable balance (bridge seam) | bridge, privilege, amm, nft | Medium | 1 |
| `SHAPE-K226` | Recorded balance exceeds transferable balance (callback seam) | callback, vault, accounting | High | 1 |
| `SHAPE-K227` | Recorded balance exceeds transferable balance (lending seam) | lending, vault, accounting, staking | High | 2 |
| `SHAPE-K228` | Recorded balance exceeds transferable balance (payments seam) | payments, privilege, accounting, vault | High | 2 |
| `SHAPE-K229` | Recorded balance exceeds transferable balance (privilege seam) | privilege, amm, staking, vault | High | 5 |
| `SHAPE-K230` | Recorded balance exceeds transferable balance (stablecoin seam) | stablecoin, privilege, lending, vault | High | 4 |
| `SHAPE-K231` | Recorded balance exceeds transferable balance (staking seam) | staking, vault, accounting | High | 1 |
| `SHAPE-K232` | Recorded balance exceeds transferable balance (vault seam) | vault, lending, amm, accounting | Critical | 14 |
| `SHAPE-K233` | Recorded balance exceeds transferable balance via execute | vault, payments, privilege, accounting | High | 9 |
| `SHAPE-K234` | Recorded balance exceeds transferable balance via initialize | vault, privilege, staking, accounting | High | 3 |
| `SHAPE-K235` | Recorded balance exceeds transferable balance (vault #2) | vault, stablecoin, nft, accounting | High | 2 |
| `SHAPE-K236` | Refund or cancel does not restore the original claim, or restores it twice | nft, payments | High | 1 |
| `SHAPE-K237` | Refund or cancel does not restore the original claim, or restores it twice (payments seam) | payments, amm, privilege, nft | High | 7 |
| `SHAPE-K238` | Refund or cancel does not restore the original claim, or restores it twice (privilege seam) | privilege, payments | High | 1 |
| `SHAPE-K239` | Refund or cancel does not restore the original claim, or restores it twice (stablecoin seam) | stablecoin, payments, amm | Critical | 4 |
| `SHAPE-K240` | Same intent settled twice after validator, implementation, or config change | amm, staking, accounting, bridge | High | 1 |
| `SHAPE-K241` | Same intent settled twice after validator, implementation, or config change (bridge seam) | bridge, privilege, signature | High | 2 |
| `SHAPE-K242` | Same intent settled twice after validator, implementation, or config change (payments seam) | payments, nft, bridge, privilege | High | 1 |
| `SHAPE-K243` | Same intent settled twice after validator, implementation, or config change (privilege seam) | privilege, staking, bridge, signature | High | 1 |
| `SHAPE-K244` | Same intent settled twice after validator, implementation, or config change (stablecoin seam) | stablecoin, privilege, signature, bridge | Critical | 1 |
| `SHAPE-K245` | Same intent settled twice after validator, implementation, or config change (vault seam) | vault, payments, privilege, nft | High | 4 |
| `SHAPE-K246` | Rounding direction on a conservation-neutral action creates or destroys value | accounting, vault | High | 3 |
| `SHAPE-K247` | Rounding direction on a conservation-neutral action creates or destroys value (bridge seam) | bridge, accounting, vault | High | 1 |
| `SHAPE-K248` | Rounding direction on a conservation-neutral action creates or destroys value (lending seam) | lending, accounting, vault | High | 1 |
| `SHAPE-K249` | Rounding direction on a conservation-neutral action creates or destroys value (payments seam) | payments, accounting, vault | Critical | 1 |
| `SHAPE-K250` | Rounding direction on a conservation-neutral action creates or destroys value (vault seam) | vault, accounting | High | 3 |
| `SHAPE-K251` | Liquidation or redemption uses a mark a same-tx actor can move | amm, oracle, lending | High | 4 |
| `SHAPE-K252` | Liquidation or redemption uses a mark a same-tx actor can move (oracle seam) | oracle, amm, lending | High | 2 |
| `SHAPE-K253` | Liquidation or redemption uses a mark a same-tx actor can move (payments seam) | payments, amm, oracle, lending | High | 3 |
| `SHAPE-K254` | Liquidation or redemption uses a mark a same-tx actor can move (privilege seam) | privilege, nft, accounting, oracle | High | 2 |
| `SHAPE-K255` | Liquidation or redemption uses a mark a same-tx actor can move (stablecoin seam) | stablecoin, payments, amm, oracle | High | 1 |
| `SHAPE-K256` | Liquidation or redemption uses a mark a same-tx actor can move (vault seam) | vault, oracle, amm, lending | High | 3 |
| `SHAPE-K257` | Signed bytes authorize a different execution context than the signer saw | amm, nft, signature, privilege | Medium | 2 |
| `SHAPE-K258` | Signed bytes authorize a different execution context than the signer saw (bridge seam) | bridge, privilege, signature, oracle | Critical | 4 |
| `SHAPE-K259` | Signed bytes authorize a different execution context than the signer saw (lending seam) | lending, signature, privilege | High | 1 |
| `SHAPE-K260` | Signed bytes authorize a different execution context than the signer saw (nft seam) | nft, signature, privilege | High | 2 |
| `SHAPE-K261` | Signed bytes authorize a different execution context than the signer saw (payments seam) | payments, privilege, amm, signature | Critical | 11 |
| `SHAPE-K262` | Signed bytes authorize a different execution context than the signer saw (privilege seam) | privilege, signature, nft, callback | Critical | 7 |
| `SHAPE-K263` | Signed bytes authorize a different execution context than the signer saw (signature seam) | signature, privilege | High | 7 |
| `SHAPE-K264` | Signed bytes authorize a different execution context than the signer saw (stablecoin seam) | stablecoin, payments, bridge, privilege | Critical | 3 |
| `SHAPE-K265` | Signed bytes authorize a different execution context than the signer saw (vault seam) | vault, stablecoin, privilege, lending | High | 5 |
| `SHAPE-K266` | Supply and backing move in opposite directions on a conservation-neutral user action | amm, nft, vault, accounting | High | 2 |
| `SHAPE-K267` | Supply and backing move in opposite directions on a conservation-neutral user action (lending seam) | lending, vault, accounting | High | 1 |
| `SHAPE-K268` | Supply and backing move in opposite directions on a conservation-neutral user action (privilege seam) | privilege, accounting, vault, lending | High | 4 |
| `SHAPE-K269` | Supply and backing move in opposite directions on a conservation-neutral user action (stablecoin seam) | stablecoin, privilege, vault, accounting | High | 2 |
| `SHAPE-K270` | Supply and backing move in opposite directions on a conservation-neutral user action (vault seam) | vault, amm, accounting, privilege | Critical | 8 |
| `SHAPE-K271` | A time lock, cooldown, or expiry is true in storage and false at the write | bridge, privilege, payments | Medium | 1 |
| `SHAPE-K272` | A time lock, cooldown, or expiry is true in storage and false at the write (privilege seam) | privilege, staking, payments | High | 2 |
| `SHAPE-K273` | A time lock, cooldown, or expiry is true in storage and false at the write (staking seam) | staking, payments, privilege | High | 2 |
| `SHAPE-K274` | Two ledgers of the same fact disagree after every call returns success | accounting | High | 3 |
| `SHAPE-K275` | Two ledgers of the same fact disagree after every call returns success (amm seam) | amm, accounting, staking | High | 3 |
| `SHAPE-K276` | Two ledgers of the same fact disagree after every call returns success (bridge seam) | bridge, lending, accounting | High | 1 |
| `SHAPE-K277` | Two ledgers of the same fact disagree after every call returns success (lending seam) | lending, staking, accounting, callback | High | 2 |
| `SHAPE-K278` | Two ledgers of the same fact disagree after every call returns success (payments seam) | payments, bridge, accounting, privilege | High | 4 |
| `SHAPE-K279` | Two ledgers of the same fact disagree after every call returns success (privilege seam) | privilege, signature, accounting, amm | Critical | 6 |
| `SHAPE-K280` | Two ledgers of the same fact disagree after every call returns success (stablecoin seam) | stablecoin, privilege, staking, accounting | High | 4 |
| `SHAPE-K281` | Two ledgers of the same fact disagree after every call returns success (vault seam) | vault, oracle, privilege, amm | Critical | 13 |
| `SHAPE-K282` | An unsolicited transfer changes a rate used by a later mint without minting shares | amm, staking, accounting, vault | High | 1 |
