# bridge seam — shape index

Browse file. **Do not load this file on a hunt.** Use:

`scripts/shape_retrieve.sh bridge`

46 shapes tagged `bridge`.

| ID | Name | Other seams |
| :--- | :--- | :--- |
| `SHAPE-K003` | Pool reserves and LP claims disagree after a valid swap, mint, or hook (bridge seam) | amm, privilege |
| `SHAPE-K015` | Authorization in A, execution in B (bridge seam) | privilege, payments, accounting |
| `SHAPE-K016` | Authorization in A, execution in B via burn | privilege, payments, callback |
| `SHAPE-K017` | Authorization in A, execution in B via wrap | privilege, amm, nft |
| `SHAPE-K024` | Authorization in A, execution in B via transfer | payments, privilege, amm |
| `SHAPE-K027` | Authorization in A, execution in B (payments #3) | payments, privilege, signature |
| `SHAPE-K055` | Burn without matching release, or release without matching burn | accounting, stablecoin, vault |
| `SHAPE-K064` | A check's meaning is invalidated between pass and settlement (vault seam) | vault, stablecoin, payments |
| `SHAPE-K066` | Claims stay constant while redeemable assets fall | payments, privilege, accounting |
| `SHAPE-K078` | Entitlement exists without a corresponding payment obligation | privilege, nft, vault |
| `SHAPE-K102` | Fast path updates a subset of the state the slow path updates (bridge seam) | vault, payments, lending |
| `SHAPE-K116` | Prepaid execution credit and actual settlement charge disagree, moving value | privilege, accounting, payments |
| `SHAPE-K117` | Prepaid execution credit and actual settlement charge disagree, moving value (payments seam) | payments, privilege, amm |
| `SHAPE-K118` | Prepaid execution credit and actual settlement charge disagree, moving value (vault seam) | vault, privilege, amm |
| `SHAPE-K120` | Yield or harvest credits a ledger that cannot be the depositor's claim (bridge seam) | lending, amm, nft |
| `SHAPE-K130` | Identity that passed a check is not the identity that receives value (bridge seam) | lending, payments, nft |
| `SHAPE-K143` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (bridge seam) | privilege, payments, lending |
| `SHAPE-K148` | Keeper or permissioned settle that a permissionless actor can force-order to capture value (stablecoin seam) | stablecoin, privilege, amm |
| `SHAPE-K161` | Message or receipt accepted on one side without the lock or burn on the other | privilege, nft, callback |
| `SHAPE-K162` | Message or receipt accepted on one side without the lock or burn on the other (payments seam) | payments, privilege, amm |
| `SHAPE-K163` | Message or receipt accepted on one side without the lock or burn on the other (privilege seam) | privilege, signature, nft |
| `SHAPE-K164` | Message or receipt accepted on one side without the lock or burn on the other (stablecoin seam) | stablecoin, nft, payments |
| `SHAPE-K165` | Message or receipt accepted on one side without the lock or burn on the other (vault seam) | vault, accounting |
| `SHAPE-K167` | Custody of a unique token diverges from the rental or borrow right that should control it (bridge seam) | privilege, amm, nft |
| `SHAPE-K175` | A one-shot right can be consumed twice across two adapters | lending, amm, payments |
| `SHAPE-K176` | A one-shot right can be consumed twice across two adapters (payments seam) | payments, signature |
| `SHAPE-K177` | A one-shot right can be consumed twice across two adapters (privilege seam) | privilege, payments, signature |
| `SHAPE-K180` | Pause or kill-switch blocks the documented path but not a value-moving sibling | privilege |
| `SHAPE-K186` | Payment obligation exists without a remaining entitlement (bridge seam) | privilege, amm, accounting |
| `SHAPE-K193` | Payment obligation exists without a remaining entitlement via unwrap | vault, payments, lending |
| `SHAPE-K196` | A role that looks view-only writes a parameter that reprices claims (bridge seam) | privilege, oracle |
| `SHAPE-K202` | A role that looks view-only writes a parameter that reprices claims (vault seam) | vault, privilege, oracle |
| `SHAPE-K204` | Price used to create a position is not the price that keeps the system solvent (bridge seam) | oracle, callback, lending |
| `SHAPE-K217` | A queued claim is transferable into a different backing or settlement state (bridge seam) | privilege, nft, payments |
| `SHAPE-K225` | Recorded balance exceeds transferable balance (bridge seam) | privilege, amm, nft |
| `SHAPE-K240` | Same intent settled twice after validator, implementation, or config change | amm, staking, accounting |
| `SHAPE-K241` | Same intent settled twice after validator, implementation, or config change (bridge seam) | privilege, signature |
| `SHAPE-K242` | Same intent settled twice after validator, implementation, or config change (payments seam) | payments, nft, privilege |
| `SHAPE-K243` | Same intent settled twice after validator, implementation, or config change (privilege seam) | privilege, staking, signature |
| `SHAPE-K244` | Same intent settled twice after validator, implementation, or config change (stablecoin seam) | stablecoin, privilege, signature |
| `SHAPE-K247` | Rounding direction on a conservation-neutral action creates or destroys value (bridge seam) | accounting, vault |
| `SHAPE-K258` | Signed bytes authorize a different execution context than the signer saw (bridge seam) | privilege, signature, oracle |
| `SHAPE-K264` | Signed bytes authorize a different execution context than the signer saw (stablecoin seam) | stablecoin, payments, privilege |
| `SHAPE-K271` | A time lock, cooldown, or expiry is true in storage and false at the write | privilege, payments |
| `SHAPE-K276` | Two ledgers of the same fact disagree after every call returns success (bridge seam) | lending, accounting |
| `SHAPE-K278` | Two ledgers of the same fact disagree after every call returns success (payments seam) | payments, accounting, privilege |
