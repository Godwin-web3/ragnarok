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
- Does the path require an admin key the program treats as trusted? → `CLASS: PRIVILEGED`, not CONFIRMED.
- Does the victim lose while the attacker does not profit? → `CLASS: GRIEF`, not CONFIRMED.
- Does the profit get clawed back on the next action?
- Is liquidity too thin for the assumed exit?
- Did the attacker pay more than they extracted once gas and inventory are counted?
- Is the fork using the wrong implementation or an old block?
- Does a known issue already describe this exact effect?
- Does a second representation reconverge before anyone can redeem?
- Does the profit require winning a keeper/MEV race the attacker cannot win atomically?

## Outcomes

- KILLED — record why, the mutation that died, and **Revisit if**.
- SURVIVOR — still a lead. Not a report.
- CONFIRMED — RUNTIME_VERIFIED effect plus ECONOMICALLY_VERIFIED EXTRACT impact plus at least one documented kill attempt that failed.

Revisit SELF_RESOLVED entries before `final.md`. Reasoning-only closes are allowed during mapping. They are not allowed to stay closed without one empirical check at the end.

## Revisit if (kills are not permanently dead)

Every kill records:

```
- Revisit if: <entrypoint() or node that would reopen this>
```

When expansion adds a node or entrypoint to `architecture.md`, `scripts/gate_check.sh` compares the map stamp and queues every `- Revisit if:` line into `leads.md` / `research/reopen.md`.

Do not treat `killed.md` as a graveyard. A new settle path, a newly mapped wrapper, or a newly discovered entry is a reason to reopen the construction, not a reason to write a fresh novel.

`--write` refreshes `research/map-stamp.txt`. Run gate_check after every map growth.
