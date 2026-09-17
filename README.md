# Ragnarok

Contradiction-driven adversarial DeFi research.

Invent an impossible state. Reach it with valid calls. Prove it on a fork. Kill it if you cannot.

The unit of reasoning is a protocol state the designers probably never wrote down. A finding is not a finding until a local fork proves it, the economics are EXTRACT, and the construction survives a kill attempt.

**Supported platforms:** Claude Code · Cursor · Codex · GitHub Copilot · Windsurf · Grok

---

## Install, run, update

```
Install https://github.com/Godwin-web3/ragnarok and run ragnarok on this protocol
```

```
run ragnarok on this codebase
run ragnarok on the vault and oracle
hunt this bounty target with ragnarok
run ragnarok on evals/dvd-unstoppable
```

```
update ragnarok to the latest version
```

Point the skill at a protocol repository, a bounty page, or an eval target.

---

## How it works

One primary agent. Persistent disk is memory. Conversation is not.

```
scaffold → thin map → gate_check → invent states
         → probe → harness → kill → report_gate
```

```bash
./scripts/scaffold.sh <target-dir>
./scripts/gate_check.sh <target-dir>/research
./scripts/shape_retrieve.sh vault oracle
./scripts/probe_evm.sh
./scripts/harness_init.sh <target-dir> --cx CX-001
./scripts/report_gate.sh <target-dir>/research
```

After a thin map the agent retrieves a small seam-matched shape pack and invents contradiction cards. It does not scan for named bug classes.

---

## Rules that do not bend

- Authorized boundaries only. A live system is never exploited.
- At most two live contradiction cards. One open probe.
- A witness must compile to an assert. Prose cannot be promoted.
- CONFIRMED requires a runtime proof, extract economics, and a recorded kill attempt.
- Grief and privileged paths are tagged. They do not sit in the permissionless queue.
- The system map does not shrink.

---

## Evals

Known-broken systems live in [`evals/`](evals/). The first target is Damn Vulnerable DeFi Unstoppable. A run passes only if the witness is reached and the class matches the answer key. Grief is not EXTRACT.

---

## Repository

| Path | Role |
| :--- | :--- |
| [SKILL.md](SKILL.md) | Agent skill |
| [VERSION](VERSION) | Skill contract version |
| [scripts/](scripts/) | Scaffold, gates, retrieve, probe, harness |
| [references/](references/) | Phases, seams, bounty rules, adapters |
| [knowledge/](knowledge/) | Distilled state shapes. Load a pack, never the corpus |
| [evals/](evals/) | Broken systems used as the score |

---

## License

MIT © 2026 GodwinXbt ([@Godwin-web3](https://github.com/Godwin-web3))
