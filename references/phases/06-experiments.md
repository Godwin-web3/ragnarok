# PHASE 7 — Experiment-first, one harness

Do not write long speculative explanations before testing.

Open **one** campaign harness under `research/experiments/` against a pinned fork or local runtime. Name it `Campaign.t.sol` (EVM) or the ecosystem equivalent.

Each hypothesis is a function in that harness, named after the ID (`testH001_staleOracleMint`). Snapshot / revert between cases. Do not open a new setup per hypothesis.

For every high-value hypothesis:

1. Smallest experiment that can kill it.
2. Realistic deployed state.
3. Exact preconditions.
4. Execute.
5. Inspect traces and storage.
6. Compare balances before/after.
7. Did the invariant actually break?

RUNTIME_VERIFIED only if the relevant implementation ran. A Python model is SOURCE_VERIFIED at best.

EVM recipe: `references/adapters/evm.md`.
