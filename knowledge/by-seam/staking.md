# staking seam — shape index

Browse file. **Do not load this file on a hunt.** Use:

`scripts/shape_retrieve.sh staking`

60 shapes tagged `staking`.

| ID | Name | Other seams |
| :--- | :--- | :--- |
| `SHAPE-K002` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (amm seam) | amm, nft, callback |
| `SHAPE-K007` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (privilege seam) | privilege, amm, lending |
| `SHAPE-K009` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (staking seam) | amm |
| `SHAPE-K032` | Authorization in A, execution in B via mint | privilege, payments, nft |
| `SHAPE-K033` | Authorization in A, execution in B (privilege #3) | privilege, amm, payments |
| `SHAPE-K035` | Authorization in A, execution in B (stablecoin seam) | stablecoin, privilege, amm |
| `SHAPE-K039` | Authorization in A, execution in B (staking seam) | privilege, payments, nft |
| `SHAPE-K063` | A check's meaning is invalidated between pass and settlement (stablecoin seam) | stablecoin, callback, payments |
| `SHAPE-K067` | Claims stay constant while redeemable assets fall (privilege seam) | privilege, vault, accounting |
| `SHAPE-K069` | Claims stay constant while redeemable assets fall (staking seam) | vault, accounting |
| `SHAPE-K075` | Claims stay constant while redeemable assets fall via stake | vault, accounting |
| `SHAPE-K083` | Entitlement exists without a corresponding payment obligation (staking seam) | vault, stablecoin, payments |
| `SHAPE-K086` | Time or epoch boundary where a right survives into the next epoch's parameters | amm, oracle, payments |
| `SHAPE-K092` | Time or epoch boundary where a right survives into the next epoch's parameters (staking seam) | oracle, payments, lending |
| `SHAPE-K093` | Time or epoch boundary where a right survives into the next epoch's parameters (vault seam) | vault, oracle, payments |
| `SHAPE-K097` | Two representations of the same fact can diverge while every individual function returns success (privilege seam) | privilege, accounting |
| `SHAPE-K099` | Two representations of the same fact can diverge while every individual function returns success (staking seam) | accounting |
| `SHAPE-K103` | Fast path updates a subset of the state the slow path updates (payments seam) | payments, accounting, vault |
| `SHAPE-K106` | Fast path updates a subset of the state the slow path updates (staking seam) | accounting, vault, payments |
| `SHAPE-K107` | Fast path updates a subset of the state the slow path updates (vault seam) | vault, payments, lending |
| `SHAPE-K111` | Flag says closed while a write path still treats the surface as open (payments seam) | payments, privilege, callback |
| `SHAPE-K113` | Flag says closed while a write path still treats the surface as open (privilege #2) | privilege, amm |
| `SHAPE-K115` | Flag says closed while a write path still treats the surface as open (vault seam) | vault, privilege, lending |
| `SHAPE-K119` | Yield or harvest credits a ledger that cannot be the depositor's claim | amm, vault, accounting |
| `SHAPE-K121` | Yield or harvest credits a ledger that cannot be the depositor's claim (callback seam) | callback, accounting, vault |
| `SHAPE-K122` | Yield or harvest credits a ledger that cannot be the depositor's claim (lending seam) | lending, vault |
| `SHAPE-K123` | Yield or harvest credits a ledger that cannot be the depositor's claim (nft seam) | nft, vault |
| `SHAPE-K124` | Yield or harvest credits a ledger that cannot be the depositor's claim (payments seam) | payments, privilege, vault |
| `SHAPE-K125` | Yield or harvest credits a ledger that cannot be the depositor's claim (privilege seam) | privilege, amm, vault |
| `SHAPE-K126` | Yield or harvest credits a ledger that cannot be the depositor's claim (stablecoin seam) | stablecoin, callback, accounting |
| `SHAPE-K127` | Yield or harvest credits a ledger that cannot be the depositor's claim (staking seam) | vault |
| `SHAPE-K128` | Yield or harvest credits a ledger that cannot be the depositor's claim (vault seam) | vault, privilege, amm |
| `SHAPE-K139` | Identity that passed a check is not the identity that receives value (staking seam) | payments, nft, privilege |
| `SHAPE-K140` | Identity that passed a check is not the identity that receives value (vault seam) | vault, privilege, payments |
| `SHAPE-K142` | Keeper or permissioned settle that a permissionless actor can force-order to capture value | amm, payments, privilege |
| `SHAPE-K145` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (oracle seam) | oracle, privilege, lending |
| `SHAPE-K152` | Two components each locally conservative, jointly creating unbacked claims (amm seam) | amm, accounting, callback |
| `SHAPE-K156` | Two components each locally conservative, jointly creating unbacked claims (privilege seam) | privilege, accounting, callback |
| `SHAPE-K159` | Two components each locally conservative, jointly creating unbacked claims (staking seam) | accounting, callback |
| `SHAPE-K170` | Custody of a unique token diverges from the rental or borrow right that should control it (payments seam) | payments, nft, callback |
| `SHAPE-K173` | Custody of a unique token diverges from the rental or borrow right that should control it (staking seam) | nft, callback |
| `SHAPE-K184` | Pause or kill-switch blocks the documented path but not a value-moving sibling (vault seam) | vault, privilege, amm |
| `SHAPE-K191` | Payment obligation exists without a remaining entitlement (staking seam) | payments, vault, signature |
| `SHAPE-K201` | A role that looks view-only writes a parameter that reprices claims (staking seam) | privilege, oracle, accounting |
| `SHAPE-K206` | Price used to create a position is not the price that keeps the system solvent (lending seam) | lending, oracle, stablecoin |
| `SHAPE-K212` | Price used to create a position is not the price that keeps the system solvent (staking seam) | oracle, lending, stablecoin |
| `SHAPE-K222` | A queued claim is transferable into a different backing or settlement state (vault seam) | vault, privilege, payments |
| `SHAPE-K224` | Recorded balance exceeds transferable balance (amm seam) | amm, vault, accounting |
| `SHAPE-K227` | Recorded balance exceeds transferable balance (lending seam) | lending, vault, accounting |
| `SHAPE-K229` | Recorded balance exceeds transferable balance (privilege seam) | privilege, amm, vault |
| `SHAPE-K231` | Recorded balance exceeds transferable balance (staking seam) | vault, accounting |
| `SHAPE-K234` | Recorded balance exceeds transferable balance via initialize | vault, privilege, accounting |
| `SHAPE-K240` | Same intent settled twice after validator, implementation, or config change | amm, accounting, bridge |
| `SHAPE-K243` | Same intent settled twice after validator, implementation, or config change (privilege seam) | privilege, bridge, signature |
| `SHAPE-K272` | A time lock, cooldown, or expiry is true in storage and false at the write (privilege seam) | privilege, payments |
| `SHAPE-K273` | A time lock, cooldown, or expiry is true in storage and false at the write (staking seam) | payments, privilege |
| `SHAPE-K275` | Two ledgers of the same fact disagree after every call returns success (amm seam) | amm, accounting |
| `SHAPE-K277` | Two ledgers of the same fact disagree after every call returns success (lending seam) | lending, accounting, callback |
| `SHAPE-K280` | Two ledgers of the same fact disagree after every call returns success (stablecoin seam) | stablecoin, privilege, accounting |
| `SHAPE-K282` | An unsolicited transfer changes a rate used by a later mint without minting shares | amm, accounting, vault |
