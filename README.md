# Ragnarok

> Contradiction-driven adversarial DeFi research skill.
> Invent an impossible state. Reach it with valid calls. Prove it on a fork. Kill it if you cannot.

Not a vulnerability-category scanner.
Not a 12-agent sweep.
One primary agent. Persistent disk is memory. A finding is not a finding until a local fork proves it.

**Supported AI platforms:** Claude Code, Cursor, Codex, Copilot, Windsurf, Grok.

---

## Install, run, update

```
Install https://github.com/Godwin-web3/ragnarok and run ragnarok on this protocol
```

```
run ragnarok on this codebase
run ragnarok on the vault and oracle
hunt this Immunefi target with ragnarok
```

```
update ragnarok to the latest version
```

Point it at a protocol repo, a bounty page, or 2–5 hot contracts. Do not point it at `lib/` and hope.

---

## What it is

| Skill | What it does |
| :--- | :--- |
| ragnarok | Invent protocol states the designers never wrote down, try to reach them with valid actions, prove or kill on a local fork |

Pashov skills scan source with parallel specialty agents.
Ragnarok holds one investigation and refuses to promote prose to a finding.

Use Pashov when you want breadth on a commit.
Use Ragnarok when you want one reachable impossible state on a live system or bounty target.

---

## How a run works

```
scaffold → thin map → gate_check (SYNTHESIS OPEN) → invent states
         → cheapest probe → harness → kill → report_gate
```

```bash
./scripts/scaffold.sh <target-dir>
./scripts/gate_check.sh <target-dir>/research
./scripts/shape_retrieve.sh vault oracle
./scripts/probe_evm.sh
./scripts/harness_init.sh <target-dir> --cx CX-001
./scripts/report_gate.sh <target-dir>/research
```

Hard rules the skill enforces:

- At most 2 live contradiction cards. One open probe.
- Witness must be an assert, not a sentence.
- CONFIRMED requires a fork run plus extract economics plus a kill attempt.
- Live writes need explicit authorization. Default is read-only production plus local fork.

---

## Layout

```
SKILL.md              # agent skill (install this)
VERSION               # bump when the skill contract changes
scripts/              # scaffold, gates, retrieve, probe, harness
references/           # phases, seams, bounty, adapters (load on demand)
knowledge/            # seam-matched state shapes (never load wholesale)
```

---

## What this is not

- Not a substitute for a formal audit.
- Not a Slither wrapper.
- Not finished as a one-command black box. The product is the skill plus the gates. You still sit in the loop until a harness exists.

If the agent writes architecture notes for two days and never runs a fork, the skill failed. Stop it.

---

## Author

GodwinXbt ([@Godwin-web3](https://github.com/Godwin-web3))

MIT. Copyright (c) 2026 GodwinXbt.
