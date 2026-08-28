<div align="center">

# Ragnarok

### Contradiction-driven adversarial DeFi research

Invent an impossible state. Reach it with valid calls. Prove it on a fork. Kill it if you cannot.

<br/>

`map` · `represent` · `contradict` · `construct` · `witness` · `monetize` · `kill` · `expand`

</div>

---

## What Ragnarok is

**Ragnarok** hunts exploitable vulnerabilities in DeFi by inventing protocol states the designers probably never wrote down, then trying to walk into those states using only valid actions.

It is not a vulnerability-category scanner. The unit of reasoning is the **impossible state**, not the named bug class.

One rule still does not bend: **a finding is not a finding until it is proven on a local fork.** Speculation is never evidence. A live system is never exploited.

Ragnarok runs as a **single primary agent** with persistent on-disk research state.

## Core loop (V3.5)

```
PROMISE → REPRESENTATIONS → CONTRADICTION → IMPOSSIBLE STATE
→ VALID ACTION SEQUENCE → WITNESS → MONETIZATION → MUTATE → KILL → EXPAND
```

Thin map first. Invent states as soon as you know the live nodes and one trace. Expand the map when a construction is blocked. Do not write the whole reconstruction as homework before you are allowed to think.

## Reconstruction doctrine

| Layer | Width | Depth | Purpose |
| :--- | :--- | :--- | :--- |
| Map | Every live component, asset, authority, external dep | Shallow, tabular | You cannot attack a node that is not on the graph |
| Traces | Every class of boundary | Schematic | Value, privilege, upgrade, callback, oracle |
| Dive | Cut-set of a live construction | Deep | Source, storage, deployment, experiment |

The map does not shrink. Complete reconstruction is not a prerequisite for imagination.

## How it runs

| Environment | What's allowed |
| :--- | :--- |
| **Read-only production** | Observe, reconstruct, reason. No writes. |
| **Local fork** | Build and run exploit PoCs, isolated from production. |
| **Authorized live** | Only within explicit, bounded scope. |

## How to use it

```text
scaffold → thin map → gate_check (SYNTHESIS OPEN) → invent states → cheapest probe
         → expand map when blocked → one harness → kill → report_gate
```

```bash
./scripts/scaffold.sh <target-dir>
# Phase 0 + thin map (component graph + one trace)
./scripts/gate_check.sh <target-dir>/research
# SYNTHESIS OPEN: write contradiction cards and probe
# CAMPAIGN OPEN: full reconstruction is on disk — widen the hunt
./scripts/report_gate.sh <target-dir>/research
```

On resume the agent reads `research/NOW.md` and `research/phase-state.md`.

## Persistent state

```
research/
├── scope.md
├── NOW.md
├── architecture.md
├── asset-flows.md
├── trust-boundaries.md
├── deployment.md
├── invariants.md
├── assumptions.md
├── protocol-model.md
├── representations.md     # same fact, many ledgers
├── contradictions.md      # invented impossible worlds
├── leads.md
├── hypotheses.md          # promoted constructions
├── experiments/
├── killed.md
├── survivors.md
├── phase-state.md
├── final.md
└── report.md
```

Never delete a record — append `SUPERSEDED`, `REFINED`, or `KILLED`.

## Principles that never bend

1. Authorized boundaries only. A live system is never exploited.
2. Prove every finding on a fork or harness. Speculation is not evidence.
3. Honest severity. Never inflate.
4. Separate centralization risk from a permissionless exploit.
5. Kill your own findings when they do not hold up.
6. Private until patched.
7. The map is the system. Experiments may be local. The map may not shrink.
8. Start from a contradiction, not from a vulnerability category.

## Author

Created and maintained by **GodwinXbt** ([@Godwin-web3](https://github.com/Godwin-web3)).

## License

Licensed under the **MIT License**, Copyright (c) 2026 GodwinXbt.
