<div align="center">

# ⚡ Ragnarok

### An adversarial DeFi security research methodology

Prove it on a fork. Never guess. Never touch a live system.

<br/>

`scope` · `reconstruct` · `assume` · `hypothesize` · `experiment` · `prove` · `report`

</div>

---

## What Ragnarok is

**Ragnarok** is an experiment-first methodology for hunting — and honestly reporting — exploitable vulnerabilities in DeFi and EVM smart-contract systems, built for bug-bounty targets and public protocol deployments.

One idea is the spine of the whole method: **a finding is not a finding until it is proven on a local fork.** Speculation is never evidence, and a live system is never exploited.

Ragnarok runs as a **single primary agent** that holds deep context and persistent on-disk research state — not a fan-out of shallow scans. It optimizes for one thing: a novel, exploitable, economically real vulnerability against the *actual deployed* system.

## Who it is for

- Independent security researchers and bug-bounty hunters
- Audit teams that want a defensible, repeatable process
- Protocol engineers who want to understand how their systems get attacked

## How it runs

| Environment | What's allowed |
| :--- | :--- |
| **Read-only production** | Observe, reconstruct, reason. No writes. |
| **Local fork** | Build and run exploit PoCs, isolated from production. |
| **Authorized live** | Only within explicit, bounded scope. |

The method is **authorization-aware**: read-only research and isolated fork experiments need no authorization. Only live, state-changing exploitation does.

## The lifecycle

| Stage | What happens |
| :--- | :--- |
| 0 | Validate the target and classify the environment |
| 1 | Reconstruct the real deployed system |
| 2 | Verify deployment reality on-chain |
| 3 | Model economics and invariants |
| 4 | Mine the assumptions the protocol trusts |
| 5 | Generate and test attack hypotheses |
| 6 | Prove (or kill) findings, expand the primitive |
| 7 | Report with strict, honest severity |

## What is inside

- **A scaffold script** that creates the persistent `research/` state ledger in one command
- **Reference templates** for scope, invariants, assumptions, hypotheses, kills, and survivors
- **Persistent research state** — a ledger that records every assumption, hypothesis, kill, and survivor so no effort is lost or repeated
- **A falsification discipline** — every finding is assumed wrong until it survives a deliberate attempt to kill it

## How to use it

Place this folder in your agent's skills directory and invoke it by name (`ragnarok`). The agent runs the lifecycle for you against a target:

```bash
./scripts/scaffold.sh <target-dir>
```

## Principles that never bend

1. Authorized boundaries only. A live system is never exploited.
2. Prove every finding on a fork or harness. Speculation is not evidence.
3. Honest severity, always. Never inflate.
4. Separate centralization risk from a permissionless exploit.
5. Kill your own findings when they don't hold up.
6. Private until patched.

## Repository contents

| File | Purpose |
| :--- | :--- |
| `SKILL.md` | The methodology |
| `references/templates.md` | Fill-in templates for the research ledger |
| `scripts/scaffold.sh` | Creates the `research/` state directory |
| `README.md` | This overview |
| `LICENSE` | Usage terms |

## Author

Created and maintained by **GodwinXbt** ([@Godwin-web3](https://github.com/Godwin-web3)). Built from real adversarial engagements across DeFi and EVM smart contracts. Field-tested, not theoretical.

## License

Licensed under the **MIT License**, Copyright (c) 2026 GodwinXbt. See [`LICENSE`](LICENSE).

<div align="center">
<br/>

*A finding is not real until it is proven.*

</div>
