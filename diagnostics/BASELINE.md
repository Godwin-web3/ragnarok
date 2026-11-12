# Ragnarok V6.1 Diagnostic Baseline

Status: **baseline captured from `master`**  
Baseline version: `6.1`  
Baseline branch: `master`  
Diagnostic branch: `v6.5-diagnostic`

This document records observable repository behavior before V6.5 changes. It is not a claim that every feature has been independently executed.

## Source of truth inspected

- `VERSION`: `6.1`
- `SKILL.md`: V6.1 skill contract
- `README.md`: public workflow and supported platforms
- `scripts/gate_check.sh`: synthesis/campaign gates and hunt-discipline checks
- `scripts/report_gate.sh`: report eligibility gate
- `scripts/harness_init.sh`: Foundry campaign, CX witness and invariant scaffolds
- `references/invariant-fuzz.md`: CX-to-handler invariant-fuzz process
- `evals/README.md`: current evaluation rules

## Current operating model

Ragnarok is a **single-primary-agent**, persistent-disk-state, contradiction-driven DeFi research harness. It is not currently a multi-agent orchestration framework.

The documented core loop is:

```
PROMISE → REPRESENTATIONS → CONTRADICTION → IMPOSSIBLE STATE
→ VALID ACTION SEQUENCE → WITNESS → HARNESS → MONETIZATION
→ INVARIANT FUZZ → MUTATE → KILL → EXPAND → REOPEN
```

The objective is:

```
REALITY × EXPLOITABILITY × ECONOMIC_IMPACT × NOVELTY
```

The current skill enforces:

- Maximum two live contradiction cards.
- Maximum one open probe.
- An assertable witness before a card can become PROBING.
- A local/fork runtime proof and economic proof before CONFIRMED.
- A recorded kill/falsification attempt.
- EXTRACT as the default CONFIRMED-eligible class.
- GRIEF and PRIVILEGED eligibility only when the target's own severity rubric explicitly pays for that impact.
- Production remains read-only unless explicit live authorization is recorded.
- Persistent research artifacts, not conversation history, are the source of truth.

## Existing mechanical controls

| Control | Existing implementation | Observable behavior |
|---|---|---|
| Research phase gate | `scripts/gate_check.sh` | Checks Phase 0–5, thin map, synthesis/campaign state |
| Focus lock | `scripts/gate_check.sh` + `scripts/lib/cx_cards.inc.sh` | Enforces 2 live cards / 1 open probe |
| Witness gate | `scripts/harness_init.sh` | Refuses non-assertable CX witnesses |
| CX witness harness | `scripts/harness_init.sh --cx` | Scaffolds a specific witness test |
| CX invariant harness | `scripts/harness_init.sh --invariant` | Scaffolds a handler-based invariant test |
| Report gate | `scripts/report_gate.sh` | Requires evidence, economics, falsification and harness artifacts |
| Knowledge retrieval | `scripts/shape_retrieve.sh` | Retrieves a seam-matched shape pack |
| Probe adapter | `scripts/probe_evm.sh` | EVM-oriented probe helper |
| Evaluation corpus | `evals/` | Intentionally broken targets with hidden answer keys |

## Known limitations to measure, not assume

These are diagnostic questions, not asserted defects:

1. Can a clean checkout run every documented gate and scaffold successfully?
2. Can the evaluation corpus distinguish a correct contradiction from a generic bug-class label?
3. Are evaluation runs reproducible from pinned source, block, toolchain and configuration?
4. Are false positives and unsupported severity claims measured explicitly?
5. Does invariant-handler quality materially affect reachability outcomes?
6. Can the harness tell the difference between a hypothesis killed by a counterexample and one merely not reached within a finite fuzz budget?
7. Can results be compared across model, prompt, skill and harness revisions without changing target conditions?
8. Are incomplete investigations represented as UNKNOWN / BLOCKED rather than being described as clean?

## Baseline invariants for V6.5

V6.5 diagnostic work must preserve these unless a measured experiment justifies a change:

- The V6.1 contradiction-first research method.
- The two-live-card / one-open-probe focus lock.
- Assertable witnesses.
- Local/fork-only execution by default.
- Explicit authorization boundaries.
- Evidence ladder and economic verification.
- Honest empty reports.
- Reopenable killed hypotheses when the system map expands.
- Single-primary-agent default. Independent verification may be a separate pass/process; do not silently introduce uncontrolled agent fan-out.

## Baseline execution record

No benchmark scores are claimed in this file. Populate `RESULTS.md` from actual clean-checkout runs. Record failures as well as passes.
