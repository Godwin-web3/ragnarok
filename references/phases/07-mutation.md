# PHASE 8 — Mutate before you kill the primitive

A failed attack does not automatically kill the underlying primitive. Record why it failed, then mutate inside the same harness:

- ordering, caller, entry, asset, amount
- timing, state prerequisites
- external dependency, source of liquidity
- repetition
- combination with another protocol mechanism

Try materially different paths before killing the primitive. A documented kill is a result. Write `research/killed.md` with a revisit condition.
