# Seams worth inventing states on

Not a vulnerability catalog. Seams where two representations of the same fact often diverge.

Use after a thin map. Pick the seam that matches the live product. Write CX cards against that seam.

## Vault / ERC-4626 / share accounting

Fact: user claim on underlying.

Representations: `balanceOf(shares)`, `convertToAssets`, `totalAssets`, token `balanceOf(vault)`, strategy NAV.

Invent:

- Total shares unchanged while redeemable assets fall
- Donation or direct transfer that changes rate before a mint
- Empty or near-empty vault rate
- Two deposit paths that update different subsets of state
- Harvest that credits yield to the wrong ledger

## Stablecoin mint / redeem / backing

Fact: one token is fully backed.

Representations: token supply, collateral ledger, oracle value, pending redeem queue, off-chain RWA attestation.

Invent:

- Mint against a price that settlement will not honor
- Redeem that burns the token but does not release collateral
- Redeem that releases collateral but does not burn
- Queue position that is transferable into a different backing state
- Fast path that skips three updates the slow path performs

## Payments and settlement

Fact: a payment instruction equals a settled transfer.

Representations: intent, authorization, escrow, destination balance, receipt, refund.

Invent:

- Authorized in state A, executed in state B
- Receipt accepted without the source burn
- Partial fill that deletes the full entitlement
- Refund that does not restore the original claim
- Same intent settled twice across two adapters

## Cross-chain / bridge / wrapper

Fact: locked asset on chain A equals minted claim on chain B.

Representations: lock event, message, validator set, minted supply, unwrap burn.

Invent:

- Message valid on B without a lock on A
- Unlock on A without a burn on B
- Replay of an old receipt after a validator or implementation change
- Legacy wrapper still callable after migration

## Oracle / pricing / solvency

Fact: the number used for mint, borrow, or liquidate is the number that keeps the system solvent.

Representations: spot, TWAP, push feed, fallback, internal mark, collateral factor.

Invent:

- Price accepted for mint, rejected conceptually for solvency
- Stale round used because updatedAt is not checked on one path
- Thin-market spot that a flash loan can move inside one settlement
- Two oracles on two paths of the same action

## Privilege / upgrade / initialization

Fact: only this role can change this capability, and the capability is in the state the docs claim.

Representations: owner, roles, proxy admin, initializer flag, pause, guardian.

Invent:

- Implementation initializer still callable
- Role that looks view-only but writes a rate or whitelist
- Paused flag that blocks deposit but not a harvest or donate path
- Legacy v1 still ACTIVE on the deployment map

## How to use a seam

One seam per dive.
Write the FACT table.
Write two CX cards.
Run the cheapest falsifier on the first card before writing a third.
