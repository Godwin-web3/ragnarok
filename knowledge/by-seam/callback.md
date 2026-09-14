# callback seam — shape index

Browse file. **Do not load this file on a hunt.** Use:

`scripts/shape_retrieve.sh callback`

52 shapes tagged `callback`.

| ID | Name | Other seams |
| :--- | :--- | :--- |
| `SHAPE-K002` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (amm seam) | amm, staking, nft |
| `SHAPE-K004` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (lending seam) | lending, amm, accounting |
| `SHAPE-K013` | Authorization in A, execution in B (amm seam) | amm, privilege, payments |
| `SHAPE-K016` | Authorization in A, execution in B via burn | bridge, privilege, payments |
| `SHAPE-K018` | Authorization in A, execution in B (callback seam) | privilege, payments |
| `SHAPE-K020` | Authorization in A, execution in B (nft seam) | nft, privilege, payments |
| `SHAPE-K025` | Authorization in A, execution in B via transfer/execute | payments, privilege, amm |
| `SHAPE-K028` | Authorization in A, execution in B (payments #4) | payments, nft, privilege |
| `SHAPE-K031` | Authorization in A, execution in B (privilege #2) | privilege, payments, amm |
| `SHAPE-K038` | Authorization in A, execution in B (stablecoin #2) | stablecoin, oracle, privilege |
| `SHAPE-K041` | Authorization in A, execution in B via approve/deposit | vault, privilege, amm |
| `SHAPE-K056` | Burn without matching release, or release without matching burn (vault seam) | vault, privilege, amm |
| `SHAPE-K058` | A check's meaning is invalidated between pass and settlement | amm, payments |
| `SHAPE-K059` | A check's meaning is invalidated between pass and settlement (callback seam) | payments |
| `SHAPE-K060` | A check's meaning is invalidated between pass and settlement (lending seam) | lending, nft, payments |
| `SHAPE-K061` | A check's meaning is invalidated between pass and settlement (payments seam) | payments, amm, privilege |
| `SHAPE-K062` | A check's meaning is invalidated between pass and settlement (privilege seam) | privilege, lending, nft |
| `SHAPE-K063` | A check's meaning is invalidated between pass and settlement (stablecoin seam) | stablecoin, staking, payments |
| `SHAPE-K108` | Flag says closed while a write path still treats the surface as open | privilege |
| `SHAPE-K111` | Flag says closed while a write path still treats the surface as open (payments seam) | payments, privilege, staking |
| `SHAPE-K121` | Yield or harvest credits a ledger that cannot be the depositor's claim (callback seam) | accounting, vault, staking |
| `SHAPE-K126` | Yield or harvest credits a ledger that cannot be the depositor's claim (stablecoin seam) | stablecoin, staking, accounting |
| `SHAPE-K151` | Two components each locally conservative, jointly creating unbacked claims | accounting |
| `SHAPE-K152` | Two components each locally conservative, jointly creating unbacked claims (amm seam) | amm, staking, accounting |
| `SHAPE-K153` | Two components each locally conservative, jointly creating unbacked claims (lending seam) | lending, accounting |
| `SHAPE-K154` | Two components each locally conservative, jointly creating unbacked claims (nft seam) | nft, accounting |
| `SHAPE-K155` | Two components each locally conservative, jointly creating unbacked claims (payments seam) | payments, signature, accounting |
| `SHAPE-K156` | Two components each locally conservative, jointly creating unbacked claims (privilege seam) | privilege, staking, accounting |
| `SHAPE-K157` | Two components each locally conservative, jointly creating unbacked claims (signature seam) | signature, accounting |
| `SHAPE-K158` | Two components each locally conservative, jointly creating unbacked claims (stablecoin seam) | stablecoin, amm, accounting |
| `SHAPE-K159` | Two components each locally conservative, jointly creating unbacked claims (staking seam) | staking, accounting |
| `SHAPE-K160` | Two components each locally conservative, jointly creating unbacked claims (vault seam) | vault, payments, accounting |
| `SHAPE-K161` | Message or receipt accepted on one side without the lock or burn on the other | bridge, privilege, nft |
| `SHAPE-K166` | Custody of a unique token diverges from the rental or borrow right that should control it | amm, nft, accounting |
| `SHAPE-K168` | Custody of a unique token diverges from the rental or borrow right that should control it (lending seam) | lending, nft |
| `SHAPE-K169` | Custody of a unique token diverges from the rental or borrow right that should control it (nft seam) | nft, accounting |
| `SHAPE-K170` | Custody of a unique token diverges from the rental or borrow right that should control it (payments seam) | payments, staking, nft |
| `SHAPE-K171` | Custody of a unique token diverges from the rental or borrow right that should control it (privilege seam) | privilege, amm, nft |
| `SHAPE-K172` | Custody of a unique token diverges from the rental or borrow right that should control it (stablecoin seam) | stablecoin, nft, accounting |
| `SHAPE-K173` | Custody of a unique token diverges from the rental or borrow right that should control it (staking seam) | staking, nft |
| `SHAPE-K174` | Custody of a unique token diverges from the rental or borrow right that should control it (vault seam) | vault, nft, privilege |
| `SHAPE-K178` | A one-shot right can be consumed twice across two adapters (stablecoin seam) | stablecoin, payments, signature |
| `SHAPE-K179` | A one-shot right can be consumed twice across two adapters (vault seam) | vault, payments, nft |
| `SHAPE-K181` | Pause or kill-switch blocks the documented path but not a value-moving sibling (payments seam) | payments, privilege, nft |
| `SHAPE-K182` | Pause or kill-switch blocks the documented path but not a value-moving sibling (privilege seam) | privilege, signature, nft |
| `SHAPE-K192` | Payment obligation exists without a remaining entitlement (vault seam) | vault, privilege, payments |
| `SHAPE-K204` | Price used to create a position is not the price that keeps the system solvent (bridge seam) | bridge, oracle, lending |
| `SHAPE-K205` | Price used to create a position is not the price that keeps the system solvent (callback seam) | oracle, lending, stablecoin |
| `SHAPE-K220` | A queued claim is transferable into a different backing or settlement state (privilege seam) | privilege, payments, vault |
| `SHAPE-K226` | Recorded balance exceeds transferable balance (callback seam) | vault, accounting |
| `SHAPE-K262` | Signed bytes authorize a different execution context than the signer saw (privilege seam) | privilege, signature, nft |
| `SHAPE-K277` | Two ledgers of the same fact disagree after every call returns success (lending seam) | lending, staking, accounting |
