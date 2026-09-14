# Worked example — CX witness → Foundry harness

Synthetic target **QueuePay** (same family as `reachable-then-killed.md`). Not a disclosure of a live protocol.

This file shows the mechanical path from an assertable WITNESS to a scaffold that refuses prose.

## Card (legal)

```
## CX-001 — double settle
- STATE: ticket exists AND token already burned AND collateral sent twice
- CONTRADICTION: one burn produced two collateral transfers
- PAIRING: Queue ↔ Collateral
- SEQUENCE: requestRedeem -> settle -> settle
- WITNESS: collateral.balanceOf(attacker) > burned * rate
- MONETIZATION: attacker collateral balance increases on the second settle
- STATUS: INVENTED
```

## Command

```
scripts/harness_init.sh ./queuepay --cx CX-001
```

Writes `research/experiments/CX001_witness.t.sol` with two tests:

1. `test_CX001_impossible_state_holds` — asserts STATE / WITNESS
2. `test_CX001_monetization_moves_value` — `assertGt(after, before)`

Fill the predicate. Run on the fork. Record `FALSIFIER RESULT`. Then you may promote to PROBING / REACHABLE.

## Card (illegal — script refuses)

```
- WITNESS: the queue looks inconsistent after settle
```

```
REFUSE: CX-001 WITNESS is not assertable. Card stays INVENTED. No harness.
```

No promotion. No Campaign function. No report.

What this example is for: if you cannot write the assert, you do not have a probe. Soft cards are not "early drafts of findings." They are INVENTED and stay there.
