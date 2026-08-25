# PHASE 2 — Deployment reality

Never assume repository code equals production. Write facts only in `research/deployment.md`.

For each capability: `ACTIVE / INACTIVE / UNKNOWN / UNVERIFIED`.

Check, where evidence exists:

- bytecode vs pinned source (or record drift)
- proxy implementation + admin + storage layout
- roles / owners / pause / init
- oracle and token addresses actually wired
- enabled markets / features
- upgrade history
- balances / liquidity / fees

An address match is not a behavior check. For precompiles, oracles, pluggable registries: `address → code identity → expected interface → runtime behavior`. If behavior cannot be checked, the assumption is UNVERIFIED with provenance — not silently verified.

If RPC / bytecode / config is missing: mark UNVERIFIED, tag dependent conclusions BLOCKED, record what evidence is absent. Do not infer live behavior from source.

Recover missing deployed source via git archaeology if a live contract has no file in the pin. Label constructor-timeline match separately from byte-verified match.

Every address in this file must appear in `architecture.md`'s component graph. If a live address is new, grow the map. Do not drop it.

EVM command recipes: `references/adapters/evm.md`.
