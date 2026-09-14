# Worked example — reopen a kill when the map grows

Synthetic target **QueuePay** after the honest kill in `reachable-then-killed.md`. Not a disclosure of a live protocol.

This file shows that `killed.md` is not a graveyard.

## After the kill

```
## H-001 — KILLED
- Why it failed: ticket.settled latches before transfer completes
- Mutations attempted: different caller, settle during pause, settle after ticket transfer
- Why the primitive is NOT recoverable via this path: second settle reverts AlreadySettled
- Revisit if: settleFrom()
```

`architecture.md` Entry Points listed only `requestRedeem()` and `settle()`.

## Expansion

A newly mapped peripheral `Helper.sol` at `0x555` exposes `settleFrom(uint id, address payer)`. Add the node and the entrypoint. Run:

```
scripts/gate_check.sh research/ --write
```

Map stamp now contains `Helper` and `settleFrom()`. Gate output:

```
Reopen queue (map grew; killed.md is not permanently dead):
  - map added: Helper,settleFrom()
  - H-001 — KILLED
  - Revisit if: settleFrom()
```

`leads.md` gains a QUEUED REOPEN row. `research/reopen.md` lists it.

## What you do next (still under focus lock)

Do not invent five new cards. Re-open H-001 as CX-001 (or a new CX slot if the old one is KILLED and therefore not live). Cheapest falsifier: `cast sig "settleFrom(uint256,address)"` exists; call it twice. If the latch is missing on this path, you are back at REACHABLE. If it reverts the same way, record the new kill and a new Revisit if.

What this example is for: expansion is not "the old kill still counts." A new node is a reason to probe the dead construction again.
