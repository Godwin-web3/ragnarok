<div align="center">

# Ragnarok

### An adversarial DeFi security research methodology

Prove it on a fork. Never guess. Never touch a live system. Never shrink the map.

<br/>

`map` · `assume` · `rank` · `experiment` · `kill` · `expand` · `report`

</div>

---

## What Ragnarok is

**Ragnarok** is an experiment-first methodology for hunting — and honestly reporting — exploitable vulnerabilities in DeFi and smart-contract systems.

One idea is the spine: **a finding is not a finding until it is proven on a local fork.** Speculation is never evidence. A live system is never exploited.

Ragnarok runs as a **single primary agent** with persistent on-disk research state. It does not fan out shallow scans. It optimizes for one thing: a novel, exploitable, economically real vulnerability against the *actual deployed* system.

The method is chain-agnostic. Execution goes through an environment adapter (EVM: Foundry/Anvil is first-class).

## Reconstruction doctrine

Novel DeFi bugs live in boundaries nobody put in the original picture. Ragnarok therefore **maps the whole live system** and only then dives.

| Layer | Width | Depth | Purpose |
| :--- | :--- | :--- | :--- |
| Map | Every live component, asset, authority, external dep | Shallow, tabular | You cannot attack a node that is not on the graph |
| Traces | Every class of boundary | Schematic | Value, privilege, upgrade, callback, oracle |
| Dive | Cut-set of a live lead | Deep | Source, storage, deployment, experiment |

The map does not shrink. Experiments may be local to a seam. A lead that crosses the current seam grows the dive — it is not discarded.

## How it runs

| Environment | What's allowed |
| :--- | :--- |
| **Read-only production** | Observe, reconstruct, reason. No writes. |
| **Local fork** | Build and run exploit PoCs, isolated from production. |
| **Authorized live** | Only within explicit, bounded scope. |

## How to use it

```bash
./scripts/scaffold.sh <target-dir>
./scripts/gate_check.sh <target-dir>/research
./scripts/report_gate.sh <target-dir>/research
```

`LOCKED` means reconstruction is not done. `OPEN` means Phases 0–4 are complete.

On resume the agent reads `research/NOW.md` and `research/phase-state.md`, not the whole ledger and not the last chat.

## Principles that never bend

1. Authorized boundaries only. A live system is never exploited.
2. Prove every finding on a fork or harness. Speculation is not evidence.
3. Honest severity. Never inflate.
4. Separate centralization risk from a permissionless exploit.
5. Kill your own findings when they do not hold up.
6. Private until patched.
7. The map is the system. Experiments may be local. The map may not shrink.

## Author

Created and maintained by **GodwinXbt** ([@Godwin-web3](https://github.com/Godwin-web3)).

## License

Licensed under the **MIT License**, Copyright (c) 2026 GodwinXbt.
