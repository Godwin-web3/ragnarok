---
name: ragnarok
description: Adversarial DeFi security research methodology for bug-bounty targets and public protocol deployments. A single-primary-agent, experiment-first deep-dive that reconstructs the real deployed system, mines cross-boundary assumptions, generates and falsifies attack hypotheses with local forks, expands confirmed primitives, and economically validates findings. Authorization is required only for live state-changing exploitation; read-only production research and isolated local/fork experimentation proceed regardless of authorization (default env: READ_ONLY_PRODUCTION). Goal is a proven, novel, economically exploitable vulnerability — NOT a checklist of static warnings. Requires the local security toolchain (Foundry, Anvil, Slither, git, RPC access, local chain forks). Read-only against production unless explicitly authorized.
compatibility: "Created for Zo Computer. Requires a local Solidity/Foundry toolchain, an RPC endpoint for the target chain, and access to the target codebase (public source or verified ABI; a private repo may limit depth, not safety). Live state-changing exploitation requires explicit authorization."
metadata:
  author: godwinxbt.zo.computer
  primary-agent: "single-agent, deep-context, persistent-state"
  objective: "REALITY x EXPLOITABILITY x ECONOMIC_IMPACT x NOVELTY"
---

# Ragnarok — Adversarial DeFi Bug Hunting

Ragnarok is an adversarial security-research methodology, not a vulnerability scanner. Its purpose is to determine whether an **authorized** codebase (bug-bounty target, explicit audit engagement) contains a previously unidentified, practically exploitable failure — and to gather **executable, economically validated evidence** that proves it.

It is designed for a **single primary AI agent** that holds deep context, maintains persistent research state on disk, executes real experiments, revisits failed hypotheses, and recursively expands promising primitives. Do **not** solve the problem by fanning out sub-agents and aggregating shallow conclusions.

**Ragnarok distinguishes authorization from research.** A lack of authorization changes the execution environment — it does not terminate the investigation. The only activity that requires explicit authorization is **live state-changing exploitation**. Read-only production research and isolated local/fork experimentation may proceed regardless of authorization status. Never execute a write against production; reproduce exploits on local forks or authorized testnets only.

## Authorization & research environment

Ragnarok classifies every session into one of three environments and enforces its rules. Record the classification in `research/scope.md` at Phase 0.

```
env: READ_ONLY_PRODUCTION | LOCAL_FORK | AUTHORIZED_LIVE
```

**Default (undetermined): Authorization: UNKNOWN · Environment: READ_ONLY_PRODUCTION · Live exploitation: NO.**

- **READ_ONLY_PRODUCTION** — Authorization is not required. Never submit transactions, never alter production state, never attempt live exploit execution. Continue analysis and hypothesis generation with public-chain observation: repository/source/bytecode/ABI analysis, deployment mapping, public RPC queries, event/history analysis, storage inspection, proxy/implementation analysis, public docs/frontend/API analysis, economic modeling, invariant analysis, attack-hypothesis generation, historical transaction analysis.
- **LOCAL_FORK** — Authorization to production is not required, because experiments run against an isolated local environment. Fork public chain state locally, impersonate accounts locally, modify local state, deploy test contracts locally, construct exploit PoCs, fuzz, trace transactions, test attacker sequences, measure economic effects. Use anvil/forge-fork only; **keep the fork isolated from production**.
- **AUTHORIZED_LIVE** — Only reachable with explicit authorization. Follow the explicit scope and rules of the authorization; never exceed the authorized boundaries.

Three activities, three authorization demands:

| Activity | Authorization required |
|---|---|
| READ-ONLY RESEARCH | **No** |
| LOCAL/FORK EXPERIMENTATION | **No** (isolated environment) |
| LIVE STATE-CHANGING EXPLOITATION | **Yes** (explicit) |

**NO PUBLIC BOUNTY ≠ STOP RESEARCH.** Absence of authorization maps to:

```
NO AUTHORIZATION
→ READ-ONLY PRODUCTION RESEARCH ALLOWED
→ LOCAL/FORK EXPERIMENTATION ALLOWED
→ LIVE WRITE/EXPLOITATION DISALLOWED
```

The boundary between "we cannot exploit production" and "we can investigate whether an exploit exists" is a **change of environment, not an end of methodology**. Not being able to exploit production must never be read as not being able to research production.

## The objective function

Optimize every hour of research against:

```
REALITY × EXPLOITABILITY × ECONOMIC_IMPACT × NOVELTY
```

Each factor is a multiplier. A novel, exploitable, high-value bug against the real deployment is worth everything. A stack of theoretical warnings is worth nothing.

Do **not** optimize for: finding count, warning count, files reviewed, or vulnerability categories checked.

Definitions that govern everything below:

- **A suspicious line of code is not a vulnerability.**
- **A theoretical state violation is not automatically exploitable.**
- **An admin capability is not automatically a permissionless exploit.**
- **A static-analysis warning is not a finding.**
- **A clean result is acceptable. A fabricated finding is not.**

## Model & model-agnosticism

Ragnarok must run on any capable AI model and any set of available local tools. It adapts to what is present:

- Git (revision control, diff archaeology)
- Terminal / shell (process control, tracing, scripting)
- Solidity compiler + Foundry (forge, cast) — deployment & experiment harness
- Anvil — local fork server
- Slither / other static analyzers — **triage only, never findings**
- RPC endpoints — read-only production inspection
- Local chain forks — the primary reproduction environment
- Repository tests — ground truth for expected behavior
- Deployment metadata — implementations, proxies, admins, roles
- Block explorers / authorized read-only chain data — state verification

Model-agnostic means the *method* is enforced regardless of model; it does not depend on any particular model's strengths or weaknesses.

## The core research loop

This loop governs every phase below. Never let a single pass through it be the end.

```
RECONSTRUCT
→ MODEL
→ IDENTIFY ASSUMPTIONS
→ IDENTIFY INVARIANTS
→ GENERATE ATTACK HYPOTHESES
→ EXECUTE EXPERIMENTS
→ OBSERVE
→ FALSIFY
→ MUTATE
→ RE-EXECUTE
→ VALIDATE ECONOMICS
→ EXPAND THE PRIMITIVE
→ SEARCH FOR SECONDARY IMPACTS
→ REASSESS
```

The agent does not stop merely because the first obvious attack classes are absent. Exhaustion of an attack surface is itself a documented result.

## Persistent research state

Before any deep investigation begins, scaffold the state directory (see `scripts/scaffold.sh`):

```
research/
├── scope.md              # PHASE 0
├── architecture.md       # PHASE 1
├── asset-flows.md        # PHASE 1
├── trust-boundaries.md   # PHASE 1
├── deployment.md         # PHASE 2
├── invariants.md         # PHASE 3
├── assumptions.md        # PHASE 4
├── hypotheses.md         # PHASE 5 ledger
├── killed.md             # PHASE 7
├── survivors.md          # PHASE 12
├── experiments/          # PHASE 6
└── final.md              # PHASE 15
```

**Rules of the state directory:**

1. **Read before you continue.** At the start of any long-running continuation, read the state files. Do not rediscover already-killed hypotheses.
2. **Write as you go.** Record every assumption, hypothesis, kill reason, and survivor as it happens. A research session without on-disk state is not Ragnarok.
3. **Never delete a record** — append `SUPERSEDED`, `REFINED`, or `KILLED` to it. The ledger is the anti-pattern guard.

Where you place `research/`: inside the target repo working directory (or the current audit workspace) so it lives alongside the code, but **never commit it to the target's repository** unless you own it. Keep it local to the investigation.

---

## PHASE 0 — TARGET VALIDATION & ENVIRONMENT CLASSIFICATION

Before any research, determine and record in `research/scope.md`:

1. **Target identity (pin it):** exact repository + commit/version, deployed chains, deployed addresses (contracts, proxies, implementations, factories, tokens, oracles, keepers), relevant contracts and their source vs. verified-ABI status, assets at risk, available RPC endpoints and test infrastructure.
2. **Classify the research environment explicitly:**
   - Authorization status: `UNKNOWN` / `NONE` / `CONFIRMED`
   - Research environment: `READ_ONLY_PRODUCTION` / `LOCAL_FORK` / `AUTHORIZED_LIVE`
   - Live exploitation permitted: `YES` / `NO`
   - Default when undetermined: `Authorization: UNKNOWN`, env `READ_ONLY_PRODUCTION`, live exploitation `NO`.
   - Intended bounty scope (in-scope / out-of-scope assets), if defined.
3. **Enforce the environment rules** from "Authorization & research environment":
   - `READ_ONLY_PRODUCTION`: never submit transactions, never alter production state, never attempt live exploit execution; continue analysis and hypothesis generation.
   - `LOCAL_FORK`: free local experimentation and impersonation inside the fork; build executable PoCs; measure economic impact.
   - `AUTHORIZED_LIVE`: follow the explicit scope and rules of the authorization; never exceed the authorized boundaries.
4. **Never perform write operations against production systems.** Production interaction is limited to read-only investigation (state queries, logs, bytecode) unless `AUTHORIZED_LIVE` explicitly permits more.
5. Prefer **local forks** for any exploit reproduction.

Create `research/scope.md`. Record the environment classification and revisit it if authorization status changes.

## PHASE 1 — RECONSTRUCT THE REAL SYSTEM

Do **not** start with vulnerability scanning. Understand the system first.

Build a complete model of the deployed topology:

- contracts, implementations, proxies, factories, clones, libraries
- tokens, oracles, keepers, governance, admins, operators
- external protocols, custody, bridges, callbacks
- upgrade mechanisms, configuration, deployment topology

Trace actual asset flows — for users **and** privileged actors:

```
USER
→ ENTRY
→ STATE TRANSITION
→ ACCOUNTING
→ EXTERNAL INTERACTION
→ ASSET MOVEMENT
→ EXIT
```

Throughout, the model must distinguish three levels of capability:

- **SOURCE CODE CAPABILITY** — what the code *could* do
- **DEPLOYED CAPABILITY** — what the live deployment *actually* enables
- **ECONOMICALLY RELEVANT CAPABILITY** — what an attacker can turn into profit or loss

Create `research/architecture.md`, `research/asset-flows.md`, `research/trust-boundaries.md`.

## PHASE 2 — DEPLOYMENT REALITY

Never assume repository code equals production. Where possible, verify against the chain:

- deployed bytecode matches source (or note the drift)
- implementation addresses behind proxies
- proxy storage layout
- admin / roles / ownership / configuration
- oracle + token addresses actually wired
- active markets and enabled/disabled features
- historical events and upgrade history
- initialization state (is it already initialized?)
- liquidity and balances
- fee / reward configuration

Classify every capability **ACTIVE / INACTIVE / UNKNOWN**. A theoretically dangerous feature that is inactive in the deployment is marked INACTIVE and **deprioritized** — do not spend hours exploiting dead code. Record the UNKNOWN set so it can be revisited.

Create `research/deployment.md`.

## PHASE 3 — ECONOMIC MODEL

Identify:

- protocol assets and liabilities
- user balances, shares, debt, collateral, fees, rewards, exchange rates
- solvency relationships, liquidation thresholds, redemption mechanisms

Construct **explicit economic invariants**, e.g.:

- assets backing liabilities
- conservation of value across conversions
- share/asset conversion relationships
- debt/collateral relationships
- reward accounting
- fee accounting
- oracle-dependent valuation

For **every** invariant, determine:

- WHERE IT IS CREATED
- WHERE IT IS ASSUMED
- WHERE IT CAN CHANGE
- WHO CAN INFLUENCE IT
- WHETHER IT IS ACTUALLY ENFORCED

Create `research/invariants.md`.

## PHASE 4 — ASSUMPTION MINING

**One of the most important phases.** Do not ask only "what vulnerability exists?" Ask: **"What does the protocol assume will never happen?"**

Mine assumptions from every source: require statements, comments, formulas, state transitions, oracle interfaces, token interfaces, external calls, configuration, governance, upgrade mechanisms, accounting relationships, deployment scripts, tests, documentation.

For each assumption, record:

```
ASSUMPTION
→ TRUSTED BY
→ INFLUENCEABLE BY
→ FAILURE CONDITION
→ POSSIBLE CONSEQUENCE
→ ATTACK SURFACE
```

**Prioritize assumptions that cross boundaries.** Especially investigate:

- contract A trusting contract B
- oracle trusting an external source
- accounting trusting token behavior
- liquidation trusting oracle freshness
- redemption trusting exchange rate
- governance trusting configuration
- one market trusting another market
- protocol trusting external liquidity

Create `research/assumptions.md`.

## PHASE 5 — ATTACK HYPOTHESIS GENERATION

Do **not** enumerate SWC / OWASP / Slither categories. Generate architecture-derived hypotheses around:

- broken invariants and state-machine violations
- cross-contract inconsistencies
- oracle/accounting interactions
- temporal assumptions and transaction ordering
- callbacks, configuration/initialization/upgrade transitions
- repeated operations and rounding accumulation
- asset equivalence and liquidity assumptions
- external protocol behavior and composability
- privilege boundaries and unexpected state combinations

The central recurring question: **"What can an attacker influence that causes an important protocol assumption to become false?"**

Maintain a **hypothesis ledger**. Each entry:

```
ID
ASSUMPTION
ATTACK SURFACE
PRECONDITIONS
ATTACK SEQUENCE
EXPECTED EFFECT
EXPECTED ECONOMIC CONSEQUENCE
TEST PLAN
STATUS
```

Statuses (only one at a time): `UNTESTED`, `TESTING`, `KILLED`, `INCONCLUSIVE`, `SURVIVOR`, `CONFIRMED`.

Create `research/hypotheses.md`.

## PHASE 6 — EXPERIMENT-FIRST RESEARCH

Do **not** write long speculative explanations before testing. For every high-value hypothesis:

1. Construct the **smallest** possible experiment.
2. Use a local deployment or fork.
3. Use realistic deployed state where possible.
4. Reproduce the exact preconditions.
5. Execute the sequence.
6. Inspect traces and storage/state changes.
7. Compare balances before/after.
8. Determine whether the invariant actually breaks.

Prefer **executable evidence** over prose. Put experiments under `research/experiments/`, using Foundry tests where appropriate (`forge test`, `forge script` with an Anvil fork, `cast` for state inspection). Name each experiment by hypothesis ID, e.g. `research/experiments/H-003-mint-reentrancy.t.sol`.

## PHASE 7 — ATTACK MUTATION

A failed attack does **not** automatically kill the underlying primitive. When an attack fails, determine **why**, then mutate:

- transaction ordering
- caller / entry point / asset / amount
- timing and state prerequisites
- interaction sequence
- external dependency and source of liquidity
- repeated execution
- combination with another protocol mechanism

Try materially different attack paths before killing the underlying primitive. **Record the reason for every kill** — a documented kill is a result, not a dead end.

Create `research/killed.md`.

## PHASE 8 — CROSS-CONTRACT COMPOSITION

This phase gets dedicated attention. Assume A is correct, B is correct, C is correct. Ask: **"Can A + B + C still violate a protocol invariant?"**

Investigate pairings:

- accounting → oracle
- oracle → liquidation
- liquidation → redemption
- rewards → share accounting
- token behavior → vault accounting
- governance → active positions
- upgrade → storage/accounting
- callbacks → authorization
- external protocol → internal solvency
- configuration → existing state

Prioritize **emergent behavior** over isolated code smells.

## PHASE 9 — TEMPORAL & STATE-MACHINE RESEARCH

Explicitly model state transitions. For important state machines `S0 → S1 → S2 → S3`, ask:

- Can `S2` be entered without `S1`?
- Can `S1` be repeated?
- Can two users interact between transitions?
- Can external state change between steps?
- Can governance/configuration change between steps?
- Can an oracle update between steps?
- Can callbacks re-enter another transition?
- Can a failed transition partially alter state?
- Can an attacker force an unusual ordering?

Search for **transient states developers assume are unreachable**.

## PHASE 10 — ECONOMIC VALIDATION

Every surviving technical issue must undergo economic analysis. Compute:

```
ATTACKER BEFORE / AFTER
PROTOCOL BEFORE / AFTER
capital required
liquidity required
gas
repeatability
extractable value
victim/protocol loss
attacker profit
```

Distinguish **TECHNICAL VIOLATION** from **ECONOMIC EXPLOIT**. **Do not assign severity until this analysis exists.**

## PHASE 11 — FALSIFICATION (mandatory)

After a promising vulnerability is found: **ASSUME IT IS WRONG. Try to kill it.** Search for:

- hidden authorization
- impossible prerequisites
- deployment differences
- existing mitigations
- economic offsets
- insufficient liquidity
- attacker losses
- incorrect assumptions
- token behavior differences
- incorrect fork setup
- incorrect oracle state

Attempt to produce a **counterexample to your own exploit**. A finding that survives serious falsification receives substantially higher confidence. Record the falsification attempts and their outcomes in the ledger.

## PHASE 12 — PRIMITIVE EXPANSION

When a vulnerability survives, stop treating it as a single bug. Identify the **underlying primitive** and search the complete system for additional manifestations.

Examples:

- STALE ORACLE → minting, redemption, liquidation, collateral valuation, reward calculation, secondary markets
- SHARE ACCOUNTING ERROR → deposit, withdrawal, donation, rewards, liquidation, cross-market accounting

This is **mandatory**, not optional. Every consumer of the primitive must be hunted. Create `research/survivors.md` capturing the primitive and each manifestation with its own status.

## PHASE 13 — SECOND-PASS NOVEL RESEARCH

After conventional surfaces are exhausted, run a dedicated novelty pass. Do not repeat the first-pass checklist. Ask: **"What would an experienced protocol designer least expect an attacker to do?"**

Investigate:

- unusual transaction sequences and boundary values
- temporary states
- cross-market and cross-contract interactions
- economically irrational-looking actions that become profitable through composition
- state changes between oracle updates
- configuration changes around existing positions
- repeated tiny operations
- interactions between independent accounting systems
- unexpected token semantics
- assumptions inherited from external protocols

Goal: search **outside** the obvious vulnerability taxonomy.

## PHASE 14 — RESIDUAL ATTACK SURFACE

Before concluding, generate the full accounting:

```
INVESTIGATED
KILLED
SURVIVORS
INCONCLUSIVE
UNTESTED
```

For every high-value untested surface, explain **why it remains untested**. Do not claim "full coverage." Use precise language: **"Investigated attack surfaces under the current evidence and tooling."**

## PHASE 15 — FINAL FINDING STANDARD

A confirmed finding requires, where technically possible:

- root cause
- exact affected code (file:line)
- preconditions
- attacker sequence
- authorization analysis
- executable reproduction
- before/after state
- economic impact
- realistic attacker requirements
- deployment relevance
- mitigation

Separate clearly into buckets:

- **CONFIRMED** — executable proof + economic validation + survived falsification
- **INCONCLUSIVE** — plausible but unproven or blocked
- **DESIGN RISK** — dangerous design but not shown exploitable
- **PRIVILEGED RISK** — requires admin/operator/key compromise, not permissionless
- **FALSE POSITIVE** — was shown not exploitable
- **COVERAGE LIMITATION** — a surface not fully investigated; say why

**Never inflate severity.** A clean result is acceptable and should be reported honestly alongside the exhausted attack surfaces.

Create `research/final.md`.

---

## Anti-patterns — these are forbidden

Ragnarok must explicitly prevent:

1. Read repository → run Slither → report no bugs.
2. Search for known vulnerability names → report findings.
3. Produce theoretical vulnerabilities without execution.
4. Stop after the first plausible issue.
5. Assume source code equals deployment.
6. Assume audited code equals secure code.
7. Treat admin powers as permissionless exploits.
8. Treat every invariant violation as economically exploitable.
9. Generate dozens of shallow hypotheses and abandon them.
10. Spawn sub-agents merely to inflate the apparent amount of analysis.
11. Conclude "no vulnerabilities" without documenting exhausted attack surfaces.
12. Repeat hypotheses already conclusively killed.

## Quality bar

Behave like a patient adversarial researcher, not a vulnerability scanner.

- ONE deeply investigated hypothesis **over** TWENTY shallow warnings.
- EXECUTABLE EVIDENCE **over** SPECULATION.
- ECONOMIC PROOF **over** SEVERITY GUESSING.
- DEPLOYMENT REALITY **over** SOURCE-ONLY ANALYSIS.
- NOVEL ATTACK PATHS **over** CHECKLIST COMPLETION.

Be prepared to spend substantial time on one promising primitive before moving on. The objective is **not** to prove the protocol is vulnerable. The objective is to discover **whether** it contains a previously unidentified, practically exploitable failure — and to gather enough evidence to prove it either way.

## Execution checklist (quick reference)

1. `scripts/scaffold.sh <target-dir>` — create `research/` state.
2. PHASE 0 → write `scope.md`; record authorization status + classify environment (default UNKNOWN / READ_ONLY_PRODUCTION / live=NO).
3. PHASE 1 → `architecture.md`, `asset-flows.md`, `trust-boundaries.md`.
4. PHASE 2 → `deployment.md` (verify vs chain, classify ACTIVE/INACTIVE/UNKNOWN).
5. PHASE 3 → `invariants.md`.
6. PHASE 4 → `assumptions.md` (cross-boundary first).
7. PHASE 5 → `hypotheses.md` ledger.
8. PHASE 6 → run experiments under `research/experiments/`.
9. PHASE 7 → mutate failed attacks, record kills in `killed.md`.
10. PHASE 8–9 → composition + state-machine passes.
11. PHASE 10 → economic validation before any severity.
12. PHASE 11 → falsify survivors.
13. PHASE 12 → expand primitives into `survivors.md`.
14. PHASE 13 → second-pass novelty.
15. PHASE 14–15 → residual surface + `final.md` with strict buckets.

Always re-read `hypotheses.md` and `killed.md` before continuing any resumed investigation. Persistent state is the skill.
