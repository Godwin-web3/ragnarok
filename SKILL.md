---
name: ragnarok
description: Adversarial DeFi security research methodology for bug-bounty targets and public protocol deployments. Single-primary-agent, experiment-first. Reconstructs the real deployed system as a wide shallow graph, mines cross-boundary assumptions, builds a canonical protocol model of actors and promises, ranks hypotheses, proves or kills them on a local fork, expands confirmed primitives, and tags every claim SOURCE / DEPLOYMENT / RUNTIME / ECONOMIC. Authorization required only for live state-changing exploitation. Goal is a proven, novel, economically exploitable vulnerability — not a checklist of static warnings. Chain-agnostic method; execution via an environment adapter (EVM first-class).
compatibility: "Platform-neutral. Needs target source, read-only production access where available, and one execution adapter (EVM: Foundry/Anvil; CosmWasm: cargo/cw-multi-test; Solana: Anchor/LiteSVM). Deployment-dependent conclusions are BLOCKED/UNKNOWN when evidence is missing. Live writes require explicit authorization."
metadata:
  author: GodwinXbt
  version: "3"
  primary-agent: single-primary-agent
  state: persistent-state
  execution: environment-adaptive
  objective: "REALITY x EXPLOITABILITY x ECONOMIC_IMPACT x NOVELTY"
---

# Ragnarok — Adversarial DeFi Bug Hunting

Ragnarok is a methodology, not a scanner. One primary agent holds the investigation. Persistent disk state is memory. Conversation is not.

A finding is not a finding until it is proven on a local fork, economically validated, and still alive after you tried to kill it.

Do **not** fan out sub-agents. Do **not** load every phase file at once. Do **not** shrink the system map to save tokens.

## Load rules (token discipline)

Always-on: this file, `research/NOW.md`, `research/phase-state.md`.

On resume: those two, plus **only** the files the next action needs. Never reread the whole ledger by default.

Load a phase file when that phase is the current action:

| Action | Load |
| :--- | :--- |
| Scope / env | `references/phases/00-scope.md` |
| Wide map + traces | `references/phases/01-map.md` |
| Deployment reality | `references/phases/02-deployment.md` + `references/adapters/evm.md` (if EVM) |
| Invariants | `references/phases/03-invariants.md` |
| Assumptions | `references/phases/04-assumptions.md` |
| Protocol model | `references/phases/05-protocol-model.md` + `references/schema/protocol-model.md` |
| Rank + hypothesize | `references/phases/05-hypotheses.md` |
| Experiments | `references/phases/06-experiments.md` + adapter |
| Mutate / kill | `references/phases/07-mutation.md` |
| Composition walk | `references/phases/08-composition.md` |
| Temporal / state-machine | `references/phases/09-temporal.md` |
| Economic validation | `references/phases/10-economic.md` |
| Falsification | `references/phases/11-falsification.md` |
| Primitive expansion | `references/phases/12-expansion.md` |
| Novelty + SELF_RESOLVED revisit | `references/phases/13-novelty.md` |
| Residual surface | `references/phases/14-residual.md` |
| Report | `references/phases/15-report.md` |

Calibration of density: `references/examples/donation-inflation.md`.
Templates: `references/templates.md`.

Filenames after Phase 5 stay stable. Conceptual numbers: protocol model is Phase 5; hypothesis generation is Phase 6; experiments through report are Phases 7–16.

## Objective

```
REALITY × EXPLOITABILITY × ECONOMIC_IMPACT × NOVELTY
```

Each factor is a multiplier. Do not optimize for finding count, warning count, files reviewed, or categories checked.

- A suspicious line is not a vulnerability.
- A theoretical state violation is not automatically exploitable.
- An admin capability is not a permissionless exploit.
- A static-analysis warning is not a finding.
- A clean result is acceptable. A fabricated finding is not.

## Evidence ladder

Weakest → strongest. Never promote silently.

- **SOURCE_VERIFIED** — pinned source says the code *could* do this.
- **DEPLOYMENT_VERIFIED** — production read-only evidence says this is what is live.
- **RUNTIME_VERIFIED** — an executable run against the relevant runtime produced the state transition. A hand-written model is not this.
- **ECONOMICALLY_VERIFIED** — that transition is a realistic attacker/protocol delta with real preconditions and attacker control.

CONFIRMED requires RUNTIME_VERIFIED effect + ECONOMICALLY_VERIFIED impact. SURVIVOR is a lead, not a finding.

Every security-critical assumption carries **provenance** (how it was established) and **confidence**. "Looks safe" and "proven safe" are different claims.

## Authorization & environment

Record in `research/scope.md`. Default if undetermined:

```
Authorization: UNKNOWN
Environment: READ_ONLY_PRODUCTION
Live exploitation: NO
```

| Activity | Authorization |
| :--- | :--- |
| Read-only research | No |
| Local / fork experimentation | No (keep isolated) |
| Live state-changing exploitation | Yes, explicit |

No public bounty does not stop research. It forbids live writes.

## Reconstruction doctrine (does not bend)

Novel DeFi bugs live in boundaries nobody put in the original picture. **The map is the whole live system. Experiments may be local. The map may not shrink.**

Three layers:

```
MAP     — every live component, asset, authority, external dep. Shallow. Tabular. Complete.
TRACES  — every class of boundary, schematic. Value, privilege, upgrade, callback, oracle.
DIVE    — the cut-set of a live lead or invariant (node + every node it trusts or is trusted by). Deep.
```

- Missing a deployed contract or an external dependency from the map is incomplete reconstruction.
- Missing a novel about `deposit()` internals is not.
- A lead that crosses the current experiment seam is the point, not a distraction. Grow the dive. Do not drop the node from the map.
- Derive what a compiler/ABI/storage layout can tell you. Spend tokens on the traces tools cannot see.

## Two representations

Reconstruction produces ingredients. The protocol model is a second representation that must intersect them:

```
code → components → assumptions → invariants → hypotheses → experiments
actors → promises → required conditions → state transitions → accounting → attack opportunities → hypotheses
```

One file: `research/protocol-model.md`. Invariants and assumptions stay linked evidence. Do not create four disconnected model documents.

## Persistent state

See README for the `research/` tree. Disk is canonical. Conversation is not. Append SUPERSEDED / REFINED / KILLED. Never delete a record. Resume from artifacts + gate output. `NOW.md` is the only reconstruction allowed in working memory.

## Two mechanical gates

**Hypothesis gate** — before Phase 6, exploit construction, fuzzing, or deep falsification of a lead:

```
scripts/gate_check.sh research/
```

OPEN only when Phases 0–5 are complete on disk: scope, wide map, asset flows, trust boundaries (including at least one real composition trace), deployment, invariants, assumptions-with-provenance, protocol model. Exit `0` OPEN, `1` LOCKED, `3` violation (hypothesis/experiment work while LOCKED).

**Report gate** — before `report.md` may contain a finding:

```
scripts/report_gate.sh research/
```

PASS only if every finding in `report.md` is CONFIRMED in the ledger, RUNTIME_VERIFIED, ECONOMICALLY_VERIFIED, and has a recorded falsification attempt — or if `report.md` is the honest empty report. SURVIVOR / INCONCLUSIVE never enter `report.md`.

Neither gate trusts chat, tool-call history, or "done."

## Rank before you fork

Promote `QUEUED → HYPOTHESIS` only after the anti-anchoring questions in `references/phases/05-hypotheses.md` and a rank line:

```
permissionless? | ACTIVE on deployment? | capital plausible? | cheapest falsifier
```

Cheapest falsifier first: storage read, one `eth_call`, one unit test. Fork last.

## One fixture, many mutations

Phase 7 opens **one** campaign harness against a pinned fork. Each hypothesis is a function in that harness. Phase 8 adds cases, not new setups.

## Core loop

```
RECONSTRUCT (wide map)
→ DEPLOYMENT
→ INVARIANTS + ASSUMPTIONS
→ PROTOCOL MODEL
→ GATE 0–5
→ RANK HYPOTHESES from promises
→ SMALLEST EXPERIMENT
→ OBSERVE / FALSIFY / MUTATE
→ ECONOMICS
→ EXPAND PRIMITIVE (grow the dive, never shrink the map)
→ REVISIT SELF_RESOLVED
→ REPORT GATE
```

## Anti-patterns (forbidden)

1. Read repo → Slither → "no bugs."
2. Search vulnerability names → report them.
3. Theoretical vulns with no execution.
4. Stop after the first plausible issue.
5. Assume source equals deployment.
6. Assume audited equals secure.
7. Treat admin powers as permissionless exploits.
8. Treat every invariant break as economically exploitable.
9. Generate dozens of shallow hypotheses and abandon them.
10. Spawn sub-agents to inflate apparent analysis.
11. Claim "no vulns" without documenting exhausted surfaces.
12. Repeat conclusively killed hypotheses.
13. Report a SURVIVOR / INCONCLUSIVE, or treat a model as runtime proof.
14. Advance past the hypothesis gate while LOCKED.
15. Chase `OBSERVED → EXPLOIT` instead of queueing the lead.
16. Trust conversation over `gate_check.sh`.
17. File evidence in the wrong artifact and count it.
18. Treat an address match as a behavior check.
19. Defer all composition thinking past the first composition trace.
20. Close `SELF_RESOLVED` and never revisit it.
21. Treat prior audits / Known Issues as proof of safety.
22. State a security-critical assumption without provenance.
23. Shrink the system map to "the contract we are looking at."
24. Load every phase file into context at once.
25. Write architecture novels to please the gate.
26. Open a new fork setup per hypothesis.
27. Split the protocol model into disconnected sibling documents.
28. Turn attack primitives into a checkbox scanner.

## Quality bar

- ONE deep hypothesis over TWENTY warnings.
- EXECUTABLE EVIDENCE over speculation.
- ECONOMIC PROOF over severity guessing.
- DEPLOYMENT REALITY over source-only analysis.
- WIDE MAP, SHALLOW DEPTH over a deep island.
- EXPLICIT EVIDENCE LEVELS over implied confidence.
- PROMISES AND CONDITIONS over raw ingredients alone.

## Execution checklist

1. `scripts/scaffold.sh <target-dir>`
2. Phase 0 → `scope.md`. Load `00-scope.md`.
3. Phase 1 → map + flows + boundaries. Load `01-map.md`. Queue leads. Do not dive yet.
4. Phase 2 → `deployment.md`. Load `02-deployment.md` + adapter. Classify ACTIVE / INACTIVE / UNKNOWN / UNVERIFIED.
5. Phase 3 → `invariants.md`. Load `03-invariants.md`.
6. Phase 4 → `assumptions.md` with provenance. Load `04-assumptions.md`.
7. Phase 5 → `protocol-model.md`. Load `05-protocol-model.md` + schema. Link INV / ASM / deployment. Do not start experiments.
8. Rewrite `NOW.md`. Run `scripts/gate_check.sh research/`. LOCKED → return to the named phase.
9. Phase 6 → ranked `hypotheses.md` generated from promises. Load `05-hypotheses.md`.
10. Phase 7 → one harness under `research/experiments/`. Load `06-experiments.md` + adapter.
11. Phase 8 → mutate, `killed.md`.
12. Phases 9–10 → graph walk + state machines. Expand the dive when a lead crosses.
13. Phases 11–12 → economics, then try to kill it.
14. Phase 13 → `survivors.md`, hunt every consumer of the primitive.
15. Phase 14 → novelty + every `SELF_RESOLVED` lead.
16. Phases 15–16 → residual surface, `final.md`, then `scripts/report_gate.sh research/` before shipping `report.md`.
