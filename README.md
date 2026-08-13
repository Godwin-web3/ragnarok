# Ragnarok

Adversarial DeFi security research methodology for bug-bounty targets and public protocol deployments.

Ragnarok is an **experiment-first** deep-dive methodology: it reconstructs the real deployed system, mines cross-boundary assumptions, generates and falsifies attack hypotheses against isolated local chain forks, and economically validates any finding before it is reported. It is built for a single primary agent that holds deep context and persistent on-disk research state — not a fan-out of shallow sub-agent scans.

It is a *methodology and skill*, not a vulnerability scanner. Its output is a proven, novel, economically exploitable finding — or an honest record of the exhausted attack surface.

## Highlights

- **Authorization-aware.** Read-only production research and isolated local/fork experimentation require no authorization; only live state-changing exploitation does. Never write against production — reproduce exploits on local forks only.
- **Experiment-first.** Executable evidence (local forks, Foundry/Anvil, casts, trace inspection) over speculation. Every hypothesis is tested and falsified before it counts.
- **Reality over source.** Reconstructs and verifies the *deployed* topology — bytecode, proxies, roles, oracles, active features — not just the repo.
- **Economically validated.** No severity is assigned without a full before/after, capital/liquidity, and attacker-profit analysis.
- **Persistent state.** A `research/` ledger tracks every assumption, hypothesis, kill, and survivor so no effort is wasted or forgotten.

## Requirements

- Solidity/Foundry toolchain (`forge`, `cast`), `anvil` for local forks
- A read-only RPC endpoint for the target chain
- Access to the target codebase (public source or verified ABI)
- `git` and a standard shell

## Usage

Scaffold a research workspace against a target directory:

```bash
./scripts/scaffold.sh <target-dir>
```

This creates the `research/` state directory used to track scope, architecture, invariants, hypotheses, experiments, and final findings.

## Scope of this repository

This repository publishes the skill's scaffolding, reference templates, and usage surface. The full methodology (detailed phases, internal playbooks, and research heuristics) is intentionally kept out of this public repository.
