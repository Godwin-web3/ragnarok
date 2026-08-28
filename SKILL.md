---
name: ragnarok
description: Contradiction-driven adversarial DeFi research for bug-bounty targets and live deployments. Invents impossible protocol states, tries to reach them with valid actions, then proves or kills the construction on a local fork. Not a vulnerability-category scanner. Single primary agent. Persistent disk is memory. Chain-agnostic method with an environment adapter. Live writes need explicit authorization.
compatibility: Platform-neutral. Needs target source, read-only production access where available, and one execution adapter (EVM Foundry/Anvil; CosmWasm cargo/cw-multi-test; Solana Anchor/LiteSVM). Deployment-dependent conclusions are BLOCKED/UNKNOWN when evidence is missing. Live writes require explicit authorization.
metadata:
  author: GodwinXbt
  version: "3.5"
  primary-agent: single-primary-agent
  state: persistent-state
  execution: environment-adaptive
  loop: contradiction-driven
  objective: REALITY x EXPLOITABILITY x ECONOMIC_IMPACT x NOVELTY
---

# Ragnarok V3.5 — Contradiction-Driven Adversarial Research

Ragnarok is a methodology, not a scanner. One primary agent holds the investigation. Persistent disk state is memory. Conversation is not.

A finding is not a finding until it is proven on a local fork, economically validated, and still alive after you tried to kill it.

The unit of reasoning is **not** a hypothesis about a named bug class.

The unit of reasoning is **a protocol state the designers probably never wrote down**.

Do **not** fan out sub-agents. Do **not** load every phase file at once. Do **not** shrink the system map to save tokens.

## Starting questions (always)

Ask these before you ask "is this reentrancy / oracle / rounding":

- What can I make the protocol believe that is not true?
- What state can I create that the designers probably never modeled?
- What valid action becomes dangerous only after a strange sequence of other valid actions?
- Where do two components have different realities about the same fact?

For every important transition, force:

1. What state does this function assume is impossible?
2. Can I reach that state using only valid calls?
3. Can I make two components disagree about the same fact?
4. Can I satisfy a check, then invalidate its underlying meaning before settlement?
5. Can I acquire a right in state A and redeem it in state B?
6. Can I separate entitlement from payment?
7. Can I separate authorization from execution?
8. Can I separate identity from ownership?
9. Can I separate price from solvency?
10. Can I separate recorded balance from actual balance?
11. Can I make A → B → C individually valid but A → B → C economically impossible under the intended model?

Do not pick a primitive from a catalog and then search for it. Invent the contradiction first. The primitive is discovered from how the impossible state was reached.

## Load rules (token discipline)

Always-on: this file, `research/NOW.md`, `research/phase-state.md`.

On resume: those two, plus **only** the files the next action needs.

| Action | Load |
| :--- | :--- |
| Scope / env | `references/phases/00-scope.md` |
| Thin / wide map | `references/phases/01-map.md` |
| Deployment reality | `references/phases/02-deployment.md` + adapter |
| Invariants | `references/phases/03-invariants.md` |
| Assumptions | `references/phases/04-assumptions.md` |
| Protocol model | `references/phases/05-protocol-model.md` + `references/schema/protocol-model.md` |
| Representations | `references/phases/05-representations.md` |
| Adversarial state synthesis | `references/phases/05-synthesis.md` |
| Rank constructions | `references/phases/05-hypotheses.md` |
| Experiments | `references/phases/06-experiments.md` + adapter |
| Mutate / kill | `references/phases/07-mutation.md` |
| Composition walk | `references/phases/08-composition.md` |
| Temporal / state-machine | `references/phases/09-temporal.md` |
| Economic validation | `references/phases/10-economic.md` |
| Falsification | `references/phases/11-falsification.md` |
| Primitive expansion | `references/phases/12-expansion.md` |
| Novelty + SELF_RESOLVED | `references/phases/13-novelty.md` |
| Residual surface | `references/phases/14-residual.md` |
| Report | `references/phases/15-report.md` |

Calibration: `references/examples/donation-inflation.md`.
Templates: `references/templates.md`.

## Objective

```
REALITY × EXPLOITABILITY × ECONOMIC_IMPACT × NOVELTY
```

Each factor is a multiplier. Do not optimize for finding count, warning count, files reviewed, or categories checked.

- A suspicious line is not a vulnerability.
- An invented state is not a finding until a valid sequence reaches it.
- A theoretical state violation is not automatically exploitable.
- An admin capability is not a permissionless exploit.
- A static-analysis warning is not a finding.
- A clean result is acceptable. A fabricated finding is not.

## Evidence ladder

Weakest → strongest. Never promote silently.

- **SOURCE_VERIFIED** — pinned source says the code *could* do this.
- **DEPLOYMENT_VERIFIED** — production read-only evidence says this is what is live.
- **RUNTIME_VERIFIED** — an executable run against the relevant runtime produced the state transition.
- **ECONOMICALLY_VERIFIED** — that transition is a realistic attacker/protocol delta with real preconditions and attacker control.

CONFIRMED requires RUNTIME_VERIFIED effect + ECONOMICALLY_VERIFIED impact. SURVIVOR is a lead, not a finding.

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

## Reconstruction doctrine (does not bend)

The map is the whole live system. Experiments may be local. The map may not shrink.

Complete reconstruction is **not** a psychological prerequisite for imagination.

```
thin map → invent an impossible state → try to reach it → expand the map only when blocked
```

Not:

```
map everything → document everything → derive assumptions → rank known-looking hypotheses
```

Grow the map when a construction names a missing node, when a probe is blocked, or before you call the surface exhausted. Do not write architecture novels to unlock thinking.

## Two representations of the same fact

For every important fact, track how multiple components represent it.

```
FACT: User owns 100 units
Token says:          100
Vault says:          100 shares
Market says:         claim = 100
Settlement says:     owed = 100
Actual balance says: 73
```

Offensive question: can an attacker cause any two representations to diverge while every individual function still behaves "correctly"?

Write that table in `research/representations.md`. A divergence is a contradiction candidate, not a bug class.

## Adversarial State Synthesis (the heart)

Canonical artifact: `research/contradictions.md`.

```
STATE:          What must be simultaneously true?
CONTRADICTION:  Which two protocol facts normally should not coexist?
CONSTRUCTION:   Can valid user actions make them coexist?
SEQUENCE:       Shortest action sequence?
WITNESS:        Exact storage / balance / claim that proves the contradiction?
MONETIZATION:   Who can redeem, withdraw, settle, or force someone else to absorb it?
```

Correct generator: *Can total claims remain unchanged while redeemable assets decrease?*

Wrong generator: *Check for rounding bugs.*

## Two mechanical gates

**Imagination gate** after a thin map:

```
scripts/gate_check.sh research/
```

SYNTHESIS OPEN when Phase 0 is complete and Phase 1 has a real component graph plus at least one trace. Then invent states, write cards, run the cheapest probe.

CAMPAIGN OPEN when Phases 0–5 are complete. That marks full reconstruction. It is **not** the lock on imagination.

Exit `0` SYNTHESIS OPEN, `1` SYNTHESIS LOCKED, `3` violation (constructions / experiments while SYNTHESIS LOCKED).

**Report gate** unchanged: CONFIRMED + RUNTIME_VERIFIED + ECONOMICALLY_VERIFIED + recorded kill attempt, or the honest empty report.

```
scripts/report_gate.sh research/
```

## Core loop

```
PROMISE → REPRESENTATIONS → CONTRADICTION → IMPOSSIBLE STATE
→ VALID ACTION SEQUENCE → WITNESS → MONETIZATION → MUTATE → KILL → EXPAND
```

## Anti-patterns (forbidden)

Keep V3 items 1–28. Add:

29. Start the loop from a vulnerability category.
30. Treat complete reconstruction as a prerequisite for imagination.
31. Confuse "each function returned success" with "the system is consistent."
32. Invent contradiction cards before a thin map exists.

## Quality bar

- ONE reachable impossible state over TWENTY warnings.
- EXECUTABLE WITNESS over speculation.
- ECONOMIC PROOF over severity guessing.
- CONTRADICTIONS AND DIVERGENT REPRESENTATIONS over named bug classes.

## Execution checklist

1. `scripts/scaffold.sh <target-dir>`
2. Phase 0 → `scope.md`.
3. Thin map → component graph + one trace.
4. `scripts/gate_check.sh research/` — SYNTHESIS OPEN → invent states.
5. Representations table for the current seam.
6. Contradiction cards. Cheapest probe first.
7. Expand the map only when blocked.
8. Grow model/invariants/assumptions as the hunt needs them.
9. Promote surviving constructions to `H-###`. One harness.
10. Mutate, kill, compose, check time, check money, expand primitives.
11. Revisit `SELF_RESOLVED`. Then `scripts/report_gate.sh research/`.
