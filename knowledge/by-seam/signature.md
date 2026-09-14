# signature seam — shape index

Browse file. **Do not load this file on a hunt.** Use:

`scripts/shape_retrieve.sh signature`

24 shapes tagged `signature`.

| ID | Name | Other seams |
| :--- | :--- | :--- |
| `SHAPE-K027` | Authorization in A, execution in B (payments #3) | payments, bridge, privilege |
| `SHAPE-K034` | Authorization in A, execution in B (signature seam) | privilege, payments |
| `SHAPE-K071` | Claims stay constant while redeemable assets fall via deposit | vault, stablecoin, privilege |
| `SHAPE-K137` | Identity that passed a check is not the identity that receives value via permit | privilege, payments, nft |
| `SHAPE-K141` | Identity that passed a check is not the identity that receives value (vault #2) | vault, payments, nft |
| `SHAPE-K155` | Two components each locally conservative, jointly creating unbacked claims (payments seam) | payments, accounting, callback |
| `SHAPE-K157` | Two components each locally conservative, jointly creating unbacked claims (signature seam) | accounting, callback |
| `SHAPE-K163` | Message or receipt accepted on one side without the lock or burn on the other (privilege seam) | privilege, bridge, nft |
| `SHAPE-K176` | A one-shot right can be consumed twice across two adapters (payments seam) | payments, bridge |
| `SHAPE-K177` | A one-shot right can be consumed twice across two adapters (privilege seam) | privilege, payments, bridge |
| `SHAPE-K178` | A one-shot right can be consumed twice across two adapters (stablecoin seam) | stablecoin, payments, callback |
| `SHAPE-K182` | Pause or kill-switch blocks the documented path but not a value-moving sibling (privilege seam) | privilege, nft, callback |
| `SHAPE-K191` | Payment obligation exists without a remaining entitlement (staking seam) | staking, payments, vault |
| `SHAPE-K241` | Same intent settled twice after validator, implementation, or config change (bridge seam) | bridge, privilege |
| `SHAPE-K243` | Same intent settled twice after validator, implementation, or config change (privilege seam) | privilege, staking, bridge |
| `SHAPE-K244` | Same intent settled twice after validator, implementation, or config change (stablecoin seam) | stablecoin, privilege, bridge |
| `SHAPE-K257` | Signed bytes authorize a different execution context than the signer saw | amm, nft, privilege |
| `SHAPE-K258` | Signed bytes authorize a different execution context than the signer saw (bridge seam) | bridge, privilege, oracle |
| `SHAPE-K259` | Signed bytes authorize a different execution context than the signer saw (lending seam) | lending, privilege |
| `SHAPE-K260` | Signed bytes authorize a different execution context than the signer saw (nft seam) | nft, privilege |
| `SHAPE-K261` | Signed bytes authorize a different execution context than the signer saw (payments seam) | payments, privilege, amm |
| `SHAPE-K262` | Signed bytes authorize a different execution context than the signer saw (privilege seam) | privilege, nft, callback |
| `SHAPE-K263` | Signed bytes authorize a different execution context than the signer saw (signature seam) | privilege |
| `SHAPE-K279` | Two ledgers of the same fact disagree after every call returns success (privilege seam) | privilege, accounting, amm |
