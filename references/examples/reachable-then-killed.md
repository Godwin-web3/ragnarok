# Worked example — reachable, then killed

Synthetic target **QueuePay**: a two-step redeem. User burns stablecoin into a queue. A keeper later pays collateral.

This file shows an honest kill. Copy the shape.

## Thin map

```
Component | Type | Address | Role | Trusts | Trusted by
Queue     | proxy | 0x111 | burn + ticket | Token, Collateral, Keeper | Users
Token     | ERC20 | 0x222 | stablecoin | — | Queue
Collateral| ERC20 | 0x333 | backing | — | Queue
Keeper    | eoa   | 0x444 | settle() | — | Queue
```

Trace: User -> requestRedeem(amount) -> burn token, mint ticket -> Keeper -> settle(id) -> transfer collateral.

## CX-001

```
STATE: ticket exists AND token already burned AND collateral already sent
CONTRADICTION: one burn produced two collateral transfers
CONSTRUCTION: call settle(id) twice
SEQUENCE: requestRedeem -> settle -> settle
WITNESS: collateral.balanceOf(attacker) > burned * rate
MONETIZATION: attacker receives second transfer
STATUS: PROBING
```

## Cheapest falsifier

```
cast call $QUEUE "tickets(uint256)(address,uint256,bool)" 1 --rpc-url $RPC
```

Ticket has a `settled` bool. Second settle reverts.

## Kill

Harness: `settle` twice. Second call reverts `AlreadySettled`.
No economic delta on the second call.

```
H-001 KILLED
Why: ticket.settled latches before transfer completes
Mutations: different caller, settle during pause, settle after ticket transfer
Not recoverable on this path
Revisit if: a new settleFrom() path skips the latch
```

What this example is for: REACHABLE on paper is not CONFIRMED. A revert on the monetization step is a successful hunt. Write it down. Do not keep the card alive to look busy.
