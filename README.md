<div align="center">

#  Ragnarok

### An adversarial DeFi security research methodology

Prove it on a fork. Never guess. Never touch a live system.

<br/>

`scope` · `reconstruct` · `assume` · `hypothesize` · `experiment` · `prove` · `report`

</div>

---

## What Ragnarok is

**Ragnarok** is an experiment-first methodology for hunting — and honestly reporting — exploitable vulnerabilities in DeFi and smart-contract systems, built for bug-bounty targets and public protocol deployments. The core methodology is chain/protocol agnostic; execution runs through an environment-specific adapter (EVM: Foundry/Anvil, CosmWasm: cargo/cw-multi-test, Solana: Anchor/LiteSVM, or the native tooling of the target ecosystem).

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
- **Reference templates** for scope, invariants, assumptions, hypotheses, kills, survivors, and the final report
- **Persistent research state** — a ledger that records every assumption, hypothesis, kill, and survivor so no effort is lost or repeated
- **An evidence & provenance model** — every claim is tagged `SOURCE_VERIFIED` → `DEPLOYMENT_VERIFIED` → `RUNTIME_VERIFIED` → `ECONOMICALLY_VERIFIED`, so a source observation is never passed off as a live-deployment or runtime fact
- **A falsification discipline** — every finding is assumed wrong until it survives a deliberate attempt to kill it
- **Disclosure-ready reporting** — `research/final.md` is the complete internal record; `research/report.md` is a disclosure-ready artifact holding **confirmed findings only** (never a survivor or an unproven lead)

## How to use it

Ragnarok is an **agent skill**, not a CLI. Load it in your agent and point it at an authorized target; the agent runs the lifecycle against that target for you.

Every investigation starts from a persistent state ledger, created in one command:

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

Created and maintained by **GodwinXbt** ([@Godwin-web3](https://github.com/Godwin-web3)). Built from real adversarial engagements across DeFi and smart-contract systems. Field-tested, not theoretical.

## License

Licensed under the **MIT License**, Copyright (c) 2026 GodwinXbt. See [`LICENSE`](LICENSE).

<div align="center">
<br/>

*A finding is not real until it is proven.*

</div>
