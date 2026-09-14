# Invariant fuzz bridge (CX → Foundry handlers)

Load when a CX card becomes `REACHABLE`.

Ragnarok invents the impossible STATE. The fuzzer tries to reach it through **any valid call sequence**. You do not have to be clever about the path once the state is named.

Primary adapter: EVM Foundry invariant tests. Other chains: use the closest property fuzzer if one exists; otherwise stay on cheapest explicit sequences and record the gap in `NOW.md`.

## Required mapping

A `REACHABLE` card must name:

```
- HANDLERS: <permissionless functions the fuzzer may call>
- INVARIANT HARNESS: research/experiments/CX001_invariant.t.sol
```

`scripts/gate_check.sh` fails the hunt-discipline gate if `REACHABLE` lacks this mapping.

Scaffold:

```
scripts/harness_init.sh <target-dir> --invariant CX-001
```

## What the invariant asserts

The invariant is the **negation** of the WITNESS.

```
// invented STATE should stay unreachable
function invariant_CX001_state_unreachable() public view {
    assertFalse(witnessHolds());
}
```

If the fuzzer trips the assert, you have a sequence. Promote that sequence to the campaign harness, mutate it, then try to kill it.

If the fuzzer never trips the assert, that is not a kill by itself. It is "no sequence found in this handler set / this run budget". Tighten handlers, add a missing permissionless entry, or record UNREACHABLE only after an explicit sequence also fails.

## Handler rules

- Only valid, permissionless (or in-scope) calls.
- Do not `vm.prank` an admin unless `CLASS` is already PRIVILEGED — and then do not put it in the CONFIRMED EXTRACT queue.
- Bound amounts to realistic deploy liquidity.
- Include the pairing's both sides (vault **and** oracle-adjacent entry, queue **and** settle, message **and** mint).
- Snapshot value that MONETIZATION would move; the witness test still has to show value moved.

## Campaign vs invariant

| File | Job |
| :--- | :--- |
| `CX001_witness.t.sol` | Specific sequence. STATE holds. Value moved. |
| `CX001_invariant.t.sol` | Any sequence. Try to make WITNESS true. |
| `Campaign.t.sol` | Promoted `H-###`. Mutations. Kill attempts. |

One fork `setUp`. Never broadcast to production.

## Foundry knobs (EVM)

```toml
[invariant]
runs = 256
depth = 64
fail_on_revert = false
```

`fail_on_revert = false` so the fuzzer can explore; the invariant, not a revert, is the signal.

## Anti-patterns

- REACHABLE with no handlers ("we will fuzz later").
- Handlers that only call the happy path you already tested.
- Treating "fuzzer did not find it in 32 runs" as UNREACHABLE.
- Fuzzing named bug classes instead of the invented STATE.
