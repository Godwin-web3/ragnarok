# Impossible-state shape corpus

Load **after a thin map**, together with `references/phases/05-synthesis.md`.

These are abstract STATE SHAPES. They are generators. They are not bug classes, not SWC numbers, not a scanner checklist.

Wrong use: walk this list and "check for" each item.
Correct use: pick the shape that the current seam could inhabit, invent a CX card with an assertable WITNESS, try to walk into it.

Do not name a vulnerability category on the card. Name the state.

Each shape: a world that should be unreachable, a pairing hint, a witness sketch. Rewrite them onto the target. Copying the sketch as a finding is a method failure.

## SHAPE-01 — Claims stay constant while redeemable assets fall

Can total claims be unchanged while the assets those claims redeem decrease?
Pairing hint: share/ticket ledger ↔ custody token
Witness sketch: `totalSupply` unchanged AND `token.balanceOf(vault)` down

## SHAPE-02 — Right acquired in state A redeemed in state B

Can a right minted under parameters A be exercised under parameters B?
Pairing hint: mint/ticket module ↔ redeem/settle module
Witness sketch: ticket.paramsEpoch != settle.paramsEpoch AND settle succeeds

## SHAPE-03 — Authorization in A, execution in B

Can a check pass against one world and the write land in another?
Pairing hint: authenticator ↔ executor / settler
Witness sketch: auth.nonce or auth.context != execution.context AND value moved

## SHAPE-04 — Two ledgers of the same fact disagree after every call returns success

Can FACT-### have two representations that diverge while no function reverts?
Pairing hint: any two components that both record the fact
Witness sketch: `reprA != reprB` AND last call success

## SHAPE-05 — Entitlement exists without a corresponding payment obligation

Can a claim be live while nobody is recorded as owing the backing?
Pairing hint: claim token ↔ obligation / escrow ledger
Witness sketch: claim.balanceOf(user) > 0 AND escrow.owed == 0

## SHAPE-06 — Payment obligation exists without a remaining entitlement

Can the system still pay after the claim was already burned or assigned away?
Pairing hint: burn path ↔ payout path
Witness sketch: claim burned AND payout path still transferable

## SHAPE-07 — Identity that passed a check is not the identity that receives value

Can the address that satisfied the predicate differ from the address that is paid?
Pairing hint: access-control / signature module ↔ payout token
Witness sketch: `payer != recipient` relative to the check that passed

## SHAPE-08 — Price used to create a position is not the price that keeps the system solvent

Can mint/borrow use a number that liquidation/redemption will not honor?
Pairing hint: oracle-for-mint ↔ oracle-for-solvency
Witness sketch: mintPrice != solvencyPrice AND position is created

## SHAPE-09 — Recorded balance exceeds transferable balance

Can internal accounting exceed what `transfer` can actually move?
Pairing hint: internal ledger ↔ ERC-20/native custody
Witness sketch: `internalBal > token.balanceOf(this)`

## SHAPE-10 — A queued claim is transferable into a different backing or settlement state

Can a ticket change hands into a world whose backing/oracle/config is not the one that issued it?
Pairing hint: queue / ticket ↔ settlement / backing
Witness sketch: ticket.owner changed AND backingEpoch changed AND redeem succeeds

## SHAPE-11 — Fast path updates a subset of the state the slow path updates

Can the short circuit skip a write the long path uses as conservation?
Pairing hint: fast entry ↔ slow entry on the same fact
Witness sketch: after fast path, slow-path storage field unchanged AND value moved

## SHAPE-12 — Burn without matching release, or release without matching burn

Can one side of a two-sided conservation law fire alone?
Pairing hint: token burn ↔ collateral release (or lock ↔ mint)
Witness sketch: `burned > 0 AND released == 0` or the reverse, same sequence

## SHAPE-13 — Message or receipt accepted on one side without the lock or burn on the other

Can chain B honor a fact that chain A never committed?
Pairing hint: message/bridge ↔ mint/unlock
Witness sketch: mint/unlock succeeded AND lock/burn on source is absent

## SHAPE-14 — A one-shot right can be consumed twice across two adapters

Can the same entitlement settle through two doors?
Pairing hint: adapter A ↔ adapter B / legacy ↔ current
Witness sketch: two successful value-outs for one burned-in

## SHAPE-15 — Yield or harvest credits a ledger that cannot be the depositor's claim

Can harvested value land where redeem cannot follow?
Pairing hint: strategy/harvest ↔ share/claim token
Witness sketch: harvest increased leftover AND `convertToAssets(shares)` did not

## SHAPE-16 — Pause or kill-switch blocks the documented path but not a value-moving sibling

Can the emergency flag be true while a sibling still moves claims or assets?
Pairing hint: pause guardian ↔ harvest/donate/settle sibling
Witness sketch: `paused() == true` AND sibling call moved value

## SHAPE-17 — Flag says closed while a write path still treats the surface as open

Can initializer, migration, or sunset storage claim "done" while a write still succeeds?
Pairing hint: init/migration flag ↔ write entry
Witness sketch: `initialized == true` (or `migrated == true`) AND the forbidden write succeeded

## SHAPE-18 — Supply and backing move in opposite directions on a conservation-neutral user action

Can a user action that should be value-neutral mint claims or leak backing?
Pairing hint: shares ↔ assets on deposit/withdraw
Witness sketch: user action AND `totalSupply` up AND `totalAssets` down (or inverse)

## SHAPE-19 — A check's meaning is invalidated between pass and settlement

Can the predicate that passed be false by the time value moves?
Pairing hint: check site ↔ settlement site (same tx or next)
Witness sketch: check-time snapshot != settle-time snapshot AND settle succeeded

## SHAPE-20 — Empty, dust, or first-actor rate lets the next actor's claim dominate

Can a near-zero denominator make the next minter own almost all redeemable assets?
Pairing hint: share math ↔ first deposit / donation
Witness sketch: `convertToShares(1)` extreme AND attacker shares / totalShares high

## SHAPE-21 — An unsolicited transfer changes a rate used by a later mint without minting shares

Can a direct token movement reprice claims before a permissionless mint?
Pairing hint: raw token transfer ↔ share minter
Witness sketch: `totalAssets` up with `totalSupply` unchanged, then mint cheaper than before

## SHAPE-22 — Liquidation or redemption uses a mark a same-tx actor can move

Can the number used to seize or redeem be the number the actor just pushed?
Pairing hint: spot/pool ↔ liquidation/redeem
Witness sketch: attacker-moved reserve AND liquidation using that reserve in the same tx

## SHAPE-23 — A role that looks view-only writes a parameter that reprices claims

Can a "reader" or peripheral setter change the number a later redeem honors?
Pairing hint: peripheral setter ↔ core accounting
Witness sketch: non-admin call changed rate/whitelist AND redeem uses the new number

## SHAPE-24 — Legacy path still ACTIVE after new accounting took over

Can v1 still move value under v2's assumptions?
Pairing hint: v1 entry ↔ v2 ledger
Witness sketch: v1 call succeeded AND v2 conservation broken

## SHAPE-25 — Same intent settled twice after validator, implementation, or config change

Can a consumed receipt become live again after an upgrade or signer set change?
Pairing hint: message/receipt store ↔ new impl/config
Witness sketch: second settle/mint succeeded for the same intent id

## SHAPE-26 — Partial fill or settle deletes the full remaining entitlement

Can paying some of a claim zero the rest?
Pairing hint: partial settlement ↔ remaining ticket
Witness sketch: paid < owed AND remaining claim == 0

## SHAPE-27 — Refund or cancel does not restore the original claim, or restores it twice

Can unwind mint a duplicate or drop the user to zero?
Pairing hint: refund/cancel ↔ original claim
Witness sketch: after unwind, `claim != original` by more than fees

## SHAPE-28 — Two components each locally conservative, jointly creating unbacked claims

Can A and B each preserve their own invariant while A+B mints value from nowhere?
Pairing hint: any two that share a FACT-### (mandatory early CX)
Witness sketch: A.ok AND B.ok AND `systemClaims > systemAssets`

## SHAPE-29 — Time or epoch boundary where a right survives into the next epoch's parameters

Can an epoch-N right execute under epoch-N+1 rates, oracles, or caps?
Pairing hint: epoch/timekeeper ↔ redeem/mint
Witness sketch: right.epoch < exec.epoch AND exec uses exec.epoch parameters

## SHAPE-30 — Keeper or permissioned settle that a permissionless actor can force-order to capture value

Can the profit depend on winning a race against a keeper, and is that race atomic for the attacker?
Pairing hint: keeper settle ↔ permissionless entry
Witness sketch: same-tx ordering captures value that a delayed keeper would have denied

## Anti-pattern

Do **not** turn this file into a vulnerability-category scanner.

- "SHAPE-21 → hunt donation attacks" is the wrong move.
- "Can claims stay constant while redeemable assets fall on *this* seam?" is the right move.

If you notice yourself naming reentrancy, oracle manipulation, or rounding as the generator, stop. Re-read the shape as a state. Write the CX. Assert the witness.
