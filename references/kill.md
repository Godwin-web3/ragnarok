# Kill the construction

Load after a CX card is REACHABLE or an H-### is SURVIVOR.

Assume the finding is wrong. Try to make it die. Record every attempt in `killed.md` or on the hypothesis row.

A finding with no kill attempt cannot pass `report_gate.sh`.

## Mutations (run in the same harness)

Change one variable per run:

- Ordering of calls
- Caller (permissionless user, holder, operator)
- Entry point (deposit vs mint vs harvest vs donate)
- Asset (standard ERC-20 vs fee-on-transfer vs rebasing)
- Amount (1 wei, dust, max, empty vault)
- Timing (same block, next block, after oracle update)
- State (paused, after upgrade, after migration)
- External dependency (stale oracle, reverting token)
- Repetition (once vs twice)
- Composition with a second protocol action

Use `vm.snapshot` / `vm.revertTo` so each mutation starts from the same fork block.

## Questions that kill most leads

- Is the capability INACTIVE on the live deployment?
- Does the path require an admin key the program treats as trusted?
- Does the profit get clawed back on the next action?
- Is liquidity too thin for the assumed exit?
- Did the attacker pay more than they extracted once gas and inventory are counted?
- Is the fork using the wrong implementation or an old block?
- Does a known issue already describe this exact effect?
- Does a second representation reconverge before anyone can redeem?

## Outcomes

- KILLED — record why, and the mutation that died.
- SURVIVOR — still a lead. Not a report.
- CONFIRMED — RUNTIME_VERIFIED effect plus ECONOMICALLY_VERIFIED impact plus at least one documented kill attempt that failed.

Revisit SELF_RESOLVED entries before `final.md`. Reasoning-only closes are allowed during mapping. They are not allowed to stay closed without one empirical check at the end.
