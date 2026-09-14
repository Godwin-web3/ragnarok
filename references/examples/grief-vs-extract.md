# Worked example — grief vs extract kill

Synthetic target **LockBox**: users deposit, anyone may `poke()` a strategy harvest. Harvest can fail mid-way and leave the vault's share price depressed until an admin repair. Not a disclosure of a live protocol.

This file shows a reachable impossible state that is **not** a paid permissionless bug.

## CX-001

```
STATE: poke() succeeds AND convertToAssets(userShares) down AND attacker token balance unchanged
CONTRADICTION: conservation of user claims vs harvest that can donate loss
PAIRING: Vault ↔ Strategy
CONSTRUCTION: attacker calls poke() when strategy.harvest() realizes a loss the vault books immediately
SEQUENCE: victim deposit → attacker poke → victim convertToAssets lower
WITNESS: convertToAssets(victimShares) < prePoke AND token.balanceOf(attacker) == preAttacker
MONETIZATION: none — attacker does not receive the missing assets
CHEAPEST FALSIFIER: eth_call convertToAssets after poke on fork
FALSIFIER RESULT: victim assets down 3%; attacker profit 0
HANDLERS: deposit, poke, withdraw
INVARIANT HARNESS: research/experiments/CX001_invariant.t.sol
CLASS: GRIEF
STATUS: REACHABLE
```

## Economics (this is the kill)

```
FLASHLOANABLE / CAPITAL: 0 (poke is free)
SAME-TX ATOMICITY: grief is atomic; there is no profit to bundle
EXIT LIQUIDITY: N/A — attacker has nothing to exit
MEV / KEEPER RACE: keepers also poke; attacker is not uniquely paid
CLASS: GRIEF
```

```
H-001 GRIEF
Why CONFIRMED is refused: victim loss without attacker profit.
Bucket: DESIGN RISK / GRIEF in final.md
report.md stays the honest empty sentence.
```

A later mutation checked whether poke() could be combined with a mint to capture the depressed rate (SHAPE-21). That would have been EXTRACT. On this target, mint is paused while harvest loss is marked, so the EXTRACT mutation died. The grief card stayed grief.

What this example is for: a broken invariant is not a bounty. Tag GRIEF so it cannot clog the permissionless CONFIRMED queue.
