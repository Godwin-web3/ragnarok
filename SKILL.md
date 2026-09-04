---
name: ragnarok
description: Contradiction-driven adversarial DeFi research for bug-bounty targets and live deployments. Invent impossible protocol states, reach them with valid actions, prove or kill on a local fork. Not a vulnerability-category scanner. Single primary agent. Persistent disk is memory. Use when hunting Immunefi, Sherlock, Cantina, or live DeFi, stablecoin, payment, vault, bridge, or settlement bugs.
compatibility: Platform-neutral. Needs target source, read-only production access where available, and one execution adapter (EVM Foundry/Anvil first). Deployment-dependent conclusions are BLOCKED or UNKNOWN when evidence is missing. Live writes require explicit authorization.
metadata:
  author: GodwinXbt
  version: "4"
  primary-agent: single-primary-agent
  state: persistent-state
  execution: environment-adaptive
  loop: contradiction-driven
  objective: REALITY x EXPLOITABILITY x ECONOMIC_IMPACT x NOVELTY
---

# Ragnarok V4

Ragnarok is a methodology, not a scanner.
One primary agent holds the investigation.
Persistent disk state is memory. Conversation is not.

A finding is not a finding until it is proven on a local fork, economically validated, and still alive after you tried to kill it.

The unit of reasoning is a protocol state the designers probably never wrote down.

Do not fan out sub-agents.
Do not load every reference at once.
Do not shrink the system map to save tokens.
Do not start from a vulnerability category.

## 48-hour rule

After SYNTHESIS OPEN, a fork or harness probe must exist within two days of wall-clock hunt time.

If it does not, you are writing architecture novels. Stop. Invent one CX card. Run the cheapest falsifier.

## Starting questions

Ask these before "is this reentrancy / oracle / rounding":

- What can I make the protocol believe that is not true?
- What state can I create that the designers never modeled?
- What valid action becomes dangerous only after a strange sequence of other valid actions?
- Where do two components have different realities about the same fact?

For every important transition:

1. What state does this function assume is impossible?
2. Can I reach that state using only valid calls?
3. Can I make two components disagree about the same fact?
4. Can I satisfy a check, then invalidate its meaning before settlement?
5. Can I acquire a right in state A and redeem it in state B?
6. Can I separate entitlement from payment?
7. Can I separate authorization from execution?
8. Can I separate identity from ownership?
9. Can I separate price from solvency?
10. Can I separate recorded balance from actual balance?
11. Can A then B then C each succeed while A-B-C is economically impossible under the intended model?

Invent the contradiction first. The primitive is discovered from how the impossible state was reached.

## Load rules

Always-on: this file, `research/NOW.md`, `research/phase-state.md`, `research/scope.md`.

On resume: those, plus only the file the next action needs.

| Action | Load |
| :--- | :--- |
| Bounty intake | `references/bounty.md` |
| Scope / env | `references/phases/00-scope.md` |
| Thin / wide map | `references/phases/01-map.md` |
| Deployment | `references/phases/02-deployment.md` plus adapter |
| Invariants | `references/phases/03-invariants.md` |
| Assumptions | `references/phases/04-assumptions.md` |
| Protocol model | `references/phases/05-protocol-model.md` |
| Same-fact ledgers | `references/phases/05-representations.md` |
| Invent states | `references/phases/05-synthesis.md` |
| Rank constructions | `references/phases/05-hypotheses.md` |
| Payment / vault / settlement seams | `references/seams.md` |
| Experiments | `references/phases/06-experiments.md` plus adapter |
| Mutate / kill | `references/kill.md` |
| Economics | `references/phases/10-economic.md` |
| Novelty | `references/phases/13-novelty.md` |
| Report / disclose | `references/phases/15-report.md` plus `references/bounty.md` |

Calibration: `references/examples/donation-inflation.md` and `references/examples/reachable-then-killed.md`.
Templates: `references/templates.md`.
EVM commands: `references/adapters/evm.md`.

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

Never promote silently.

- SOURCE_VERIFIED — pinned source says the code could do this.
- DEPLOYMENT_VERIFIED — production read-only evidence says this is live.
- RUNTIME_VERIFIED — an executable run produced the state transition.
- ECONOMICALLY_VERIFIED — that transition is a realistic attacker or protocol delta.

CONFIRMED requires RUNTIME_VERIFIED effect plus ECONOMICALLY_VERIFIED impact.
SURVIVOR is a lead, not a finding.

## Authorization

Record in `research/scope.md`. Default if undetermined:

```
Authorization: UNKNOWN
Environment: READ_ONLY_PRODUCTION
Live exploitation: NO
```

| Activity | Authorization |
| :--- | :--- |
| Read-only research | No |
| Local / fork experimentation | No. Keep isolated. |
| Live state-changing exploitation | Yes, explicit |

Read bounty scope, known issues, KYC, PoC rules, and primacy (impact vs rules) before writing a disclosure. Load `references/bounty.md`.

## Reconstruction doctrine

The map is the whole live system. Experiments may be local. The map may not shrink.

Complete reconstruction is not a prerequisite for imagination.

```
thin map → invent an impossible state → try to reach it → expand the map only when blocked
```

Grow the map when a construction names a missing node, when a probe is blocked, or before you call the surface exhausted.

## Two representations of the same fact

Track how multiple components represent one fact. Write the table in `research/representations.md`.

```
FACT: User owns 100 units
Token:          100
Vault shares:   100
Market claim:   100
Settlement owed:100
Actual balance: 73
```

Offensive question: can an attacker cause any two representations to diverge while every individual function still returns success?

A divergence is a contradiction candidate, not a bug class.

## Adversarial state synthesis

Canonical artifact: `research/contradictions.md`.

```
STATE:          What must be simultaneously true?
CONTRADICTION:  Which two protocol facts should not coexist?
CONSTRUCTION:   Can valid user actions make them coexist?
SEQUENCE:       Shortest action sequence?
WITNESS:        Exact storage, balance, or claim that proves it?
MONETIZATION:   Who redeems, withdraws, settles, or is forced to absorb it?
```

Correct generator: Can total claims stay unchanged while redeemable assets decrease?
Wrong generator: Check for rounding bugs.

Prefer seams in `references/seams.md` when the target is a vault, stablecoin, payment rail, bridge, or yield wrapper.

## Two mechanical gates

Imagination gate after a thin map:

```
scripts/gate_check.sh research/
```

SYNTHESIS OPEN when Phase 0 is complete and Phase 1 has a real component graph plus at least one trace. Then invent states, write cards, run the cheapest probe.

CAMPAIGN OPEN when Phases 0–5 are complete. Full reconstruction. Not a lock on imagination.

Exit 0 SYNTHESIS OPEN, 1 SYNTHESIS LOCKED, 3 violation (constructions or experiments while SYNTHESIS LOCKED).

Report gate: CONFIRMED plus RUNTIME_VERIFIED plus ECONOMICALLY_VERIFIED plus recorded kill attempt, or the honest empty report.

```
scripts/report_gate.sh research/
```

## Core loop

```
PROMISE → REPRESENTATIONS → CONTRADICTION → IMPOSSIBLE STATE
→ VALID ACTION SEQUENCE → WITNESS → MONETIZATION → MUTATE → KILL → EXPAND
```

## Anti-patterns

1. Read repository, run Slither, report no bugs.
2. Search for known vulnerability names, then report findings.
3. Produce theoretical vulnerabilities without execution.
4. Stop after the first plausible issue.
5. Assume source code equals deployment.
6. Assume audited code equals secure code.
7. Treat admin powers as permissionless exploits.
8. Treat every invariant violation as economically exploitable.
9. Generate dozens of shallow hypotheses and abandon them.
10. Shrink the map to keep the dive small.
11. Fan out sub-agents.
12. Use conversation as memory.
13. Invent contradiction cards before a thin map exists.
14. Treat complete reconstruction as a prerequisite for imagination.
15. Confuse "each function returned success" with "the system is consistent."
16. Start the loop from a vulnerability category.
17. Submit without reading in-scope, out-of-scope, and known issues.
18. Inflate severity to fill a template.
19. Touch a live system.
20. Skip the kill attempt.

## Quality bar

- ONE reachable impossible state over TWENTY warnings.
- EXECUTABLE WITNESS over speculation.
- ECONOMIC PROOF over severity guessing.
- CONTRADICTIONS AND DIVERGENT REPRESENTATIONS over named bug classes.
- A probe on a fork within two days of a thin map.

## Execution checklist

1. `scripts/scaffold.sh <target-dir>`
2. Phase 0. Fill `scope.md`. Read `references/bounty.md` if this is a bounty.
3. Thin map. Component graph plus one trace.
4. `scripts/gate_check.sh research/` — SYNTHESIS OPEN, then invent states.
5. Representations table for the current seam.
6. Contradiction cards. Cheapest probe first. EVM: `scripts/probe_evm.sh` and `references/adapters/evm.md`.
7. Expand the map only when blocked.
8. Grow model, invariants, and assumptions as the hunt needs them.
9. Promote surviving constructions to `H-###`. One harness: `scripts/harness_init.sh`.
10. Mutate, kill, compose, check time, check money. Load `references/kill.md`.
11. Revisit `SELF_RESOLVED`. Then `scripts/report_gate.sh research/`.
12. Disclose only CONFIRMED findings, privately, per `references/bounty.md`.
