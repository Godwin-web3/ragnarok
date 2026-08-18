---
name: ragnarok
description: Adversarial DeFi security research methodology for bug-bounty targets and public protocol deployments. A single-primary-agent, experiment-first deep-dive that reconstructs the real deployed system, mines cross-boundary assumptions, generates and falsifies attack hypotheses against a local runtime, expands confirmed primitives, economically validates findings, and tags every claim with an explicit evidence level (SOURCE / DEPLOYMENT / RUNTIME / ECONOMIC). Authorization is required only for live state-changing exploitation; read-only production research and isolated local experimentation proceed regardless of authorization (default env: READ_ONLY_PRODUCTION). Goal is a proven, novel, economically exploitable vulnerability — NOT a checklist of static warnings. The core methodology is chain/protocol agnostic; execution uses an environment-specific adapter (EVM: Foundry/Anvil; CosmWasm: cargo/cw-multi-test; Solana: Anchor/LiteSVM; etc.). Deployment verification is best-effort and never silently assumed. Read-only against production unless explicitly authorized.
compatibility: "Platform-neutral. Requires the target source code (public or provided), read-only production access (RPC endpoint, block explorer, or chain data) for deployment verification where available, and the appropriate execution adapter for the target ecosystem (e.g. EVM: Foundry/Anvil; CosmWasm: cargo/cw-multi-test; Solana: Anchor/LiteSVM; other ecosystems: native test/fork/runtime tooling). Not every ecosystem need be supported at once — select the adapter for the target. If deployment evidence is unavailable, deployment-dependent conclusions are marked BLOCKED/UNKNOWN rather than assumed. A private repo may limit depth, not safety. Live state-changing exploitation requires explicit authorization."
metadata:
  author: GodwinXbt
  primary-agent: single-primary-agent
  state: persistent-state
  execution: environment-adaptive
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
- **LOCAL_FORK** — Authorization to production is not required, because experiments run against an isolated local environment. Fork public chain state locally, impersonate accounts locally, modify local state, deploy test contracts locally, construct exploit PoCs, fuzz, trace transactions, test attacker sequences, measure economic effects. Use the target's local fork / chain tooling (EVM: `anvil`/`forge` fork; CosmWasm: local chain; Solana: LiteSVM); **keep the fork isolated from production**.
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

## Model & execution-agnosticism

Ragnarok must run on any capable AI model and any set of available local tools. The core methodology is **chain/protocol agnostic** — it must not be rewritten around a specific ecosystem. Execution happens through an **environment-specific execution adapter**, chosen for the target:

| Ecosystem | Typical execution adapter |
| :--- | :--- |
| EVM | Foundry / Anvil / Slither (triage only) |
| CosmWasm | Cargo / cw-multi-test / wasm tooling / local chain |
| Solana | Anchor / LiteSVM / Mollusk |
| Other ecosystems | appropriate native test / fork / runtime tooling |

The fixed, one-directional dependency is:

```
Ragnarok Core methodology
→ environment-specific execution adapter
```

The agent selects the execution environment based on the target and available tooling. Every ecosystem need not be supported at once; the methodology is satisfied as long as there is *an* execution adapter that can reproduce behavior on a local runtime. Foundry, Anvil, and Slither remain first-class **EVM** tooling, but they are not required by Ragnarok — they are the EVM adapter, not the methodology itself.

Generic, cross-ecosystem capabilities always apply:

- Git (revision control, diff archaeology)
- Terminal / shell (process control, tracing, scripting)
- RPC endpoints / block explorers — read-only production inspection
- A local reproduction environment (fork, fixture, or local chain) — the primary execution venue
- Repository tests — ground truth for expected behavior
- Deployment metadata — implementations, proxies, admins, roles
- Static analyzers (where available) — **triage only, never findings**

Model- and execution-agnostic mean the *method* is enforced regardless of the model and the toolchain; it does not depend on any particular model's or ecosystem's strengths or weaknesses.

## Evidence & provenance model

Every claim in Ragnarok carries an explicit **evidence level** stating *how* it was established and *against what*. This is how the methodology distinguishes source analysis, deployment analysis, models, and runtime experiments without letting any one of them be silently promoted to a stronger claim than its evidence supports.

The levels are ordered weakest → strongest:

- **SOURCE_VERIFIED** — The behavior is established from the pinned source code. It tells you what the code *could* do under its own logic. It says nothing about whether that logic is what is actually live.
- **DEPLOYMENT_VERIFIED** — The relevant deployed contract / version / configuration / state has been independently established against production read-only evidence (deployed bytecode, addresses, configuration, storage, events, upgrade history).
- **RUNTIME_VERIFIED** — The behavior has been reproduced through executable code against the relevant implementation / runtime: a local fork, an exact WASM / cw-multi-test fixture, an Anvil fork, or an equivalent environment. The state transition actually happens when the code runs.
- **ECONOMICALLY_VERIFIED** — The runtime result has been converted into an actual attacker / protocol economic delta with realistic preconditions and attacker control: real capital, liquidity, gas, and repeatability, measured before/after.

Three promotions are forbidden:

- A Python arithmetic model (or any hand-written model) is **not** RUNTIME_VERIFIED. A standalone model can reach at most SOURCE_VERIFIED; reproducing the behavior in the actual runtime is the only path to RUNTIME_VERIFIED.
- A source-level observation is **not** DEPLOYMENT_VERIFIED. Source capability does not establish what is deployed.
- A runtime state transition without attacker reachability is **not** an economically exploitable vulnerability. ECONOMICALLY_VERIFIED additionally requires realistic preconditions and attacker control over the state being changed.

Where a claim is asserted, state its level explicitly, e.g. `[DEPLOYMENT_VERIFIED]` or `[RUNTIME_VERIFIED]`. If a claim is not yet established at a given level, do not imply the higher level; when in doubt, use the lower level.

The model feeds the hypothesis ledger (PHASE 5) and the final buckets (PHASE 15): a hypothesis is only **CONFIRMED** when its effect is RUNTIME_VERIFIED and its impact is ECONOMICALLY_VERIFIED, with the relevant deployment facts either DEPLOYMENT_VERIFIED or explicitly flagged.

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
├── leads.md              # pending-lead queue — written throughout Phases 1-4
├── hypotheses.md         # PHASE 5 ledger
├── killed.md             # PHASE 7
├── survivors.md          # PHASE 12
├── experiments/          # PHASE 6
├── phase-state.md        # auto-generated by scripts/gate_check.sh — do not hand-edit
├── final.md              # PHASE 15 — complete internal investigation record
└── report.md             # PHASE 15 — disclosure-ready, CONFIRMED findings only
```

`final.md` is the complete internal investigation record (every bucket, kill, and coverage limitation). `report.md` is a disclosure-ready artifact containing **CONFIRMED findings only** — never a SURVIVOR or INCONCLUSIVE lead. If nothing meets the evidence standard, `report.md` states that explicitly instead of fabricating a finding.

**Rules of the state directory:**

1. **Read before you continue.** At the start of any long-running continuation, read the state files. Do not rediscover already-killed hypotheses.
2. **Write as you go.** Record every assumption, hypothesis, kill reason, and survivor as it happens. A research session without on-disk state is not Ragnarok.
3. **Never delete a record** — append `SUPERSEDED`, `REFINED`, or `KILLED` to it. The ledger is the anti-pattern guard.

**Resume integrity.** Ragnarok must be safely resumable, and resumption is derived from artifacts, never from memory. On every new session, or whenever picking the investigation back up:

1. Run `scripts/gate_check.sh research/` (or read the `research/phase-state.md` it last wrote) as the manifest of record.
2. Inspect every required artifact yourself — do not take the script's summary as a substitute for reading `research/*.md`.
3. Determine the highest **verified-complete** phase from that inspection, not from what the previous session's conversation claimed.
4. Reconstruct the current phase and next action from the artifacts — pending leads, open hypotheses, unkilled survivors.
5. **Never trust previous conversational claims about completion.** If `deployment.md` is empty, Phase 2 is incomplete — even if a previous agent spent an hour verifying deployments and said so. If `architecture.md` is empty, Phase 1 is incomplete — even if the architecture was discussed at length. Persistent artifacts are canonical memory; the conversation is not.

Where you place `research/`: inside the target repo working directory (or the current audit workspace) so it lives alongside the code, but **never commit it to the target's repository** unless you own it. Keep it local to the investigation.

---

## Mandatory Phase Gate (mechanical enforcement)

**Reconstruction before exploitation thinking.** Ragnarok must first understand the system it is attacking before deciding how it might be broken. A potentially critical lead does **not** grant permission to skip phases — it is evidence to preserve, not an excuse to abandon methodology.

This is enforced **mechanically**, not by instruction alone:

```
scripts/gate_check.sh research/
```

Run this before every phase transition, and always before PHASE 5 (attack hypothesis generation), exploit construction, fuzzing, or deep falsification of a specific lead. It inspects the actual `research/*.md` files on disk and reports which phases are `COMPLETE`, `INCOMPLETE`, or `BLOCKED`, and whether the **Hypothesis Generation Gate** is `OPEN` or `LOCKED`. It also detects and flags **gate violations** — hypothesis-ledger entries or `research/experiments/` content that appeared while the gate was still `LOCKED`.

**The gate does not trust:**

- conversation history
- the agent (or a previous agent) saying "done"
- tool-call history
- files merely being mentioned
- partial notes
- inferred completion

**Artifact state is the source of truth.** If an artifact is missing, empty, skeletal, stale, or explicitly incomplete, that phase is `INCOMPLETE` — full stop, regardless of what was discussed or how much time was spent on it. A phase is `COMPLETE` only when its required deliverables exist, substantively, in the correct canonical artifact — not scattered across the wrong file, not merely a file that exists.

**Ragnarok MUST NOT** advance to hypothesis generation, exploit construction, fuzzing, or deep falsification of a specific lead unless `scripts/gate_check.sh` reports the Hypothesis Generation Gate as `OPEN` (Phases 0-3 all `COMPLETE`). If the gate is `LOCKED`, the agent may continue reconstruction and may record leads in `leads.md` — it may not deepen exploit analysis on any of them.

The exit code doubles as a hard stop: `0` = gate `OPEN`, `1` = gate `LOCKED`, `3` = a gate violation was detected. Treat exit `1` and `3` the same way — as "return to reconstruction," never as something to reason past.

This gate exists because of a real failure mode, not a hypothetical one: a prior investigation left Phase 1 partially complete, recorded deployment evidence in the wrong artifact, skipped Phase 3 entirely, and let an interesting lead trigger premature hypothesis and falsification work. `scripts/tests/gate_check_test.sh` encodes each of those exact failure modes as a regression test against `scripts/gate_check.sh`, so the sequence is mechanically blocked, not just discouraged in prose.

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

`research/trust-boundaries.md` must not merely list authorities (users, operators, admins, guardians, keepers, controllers, contracts, external protocols, oracles, bridges, upgrade authorities). For every security-critical permission, trace it explicitly:

```
ACTOR → ENTRY POINT → MODIFIER/CHECK → INTERNAL CALL → STATE WRITE → DOWNSTREAM EFFECT
```

and explicitly map the **normal**, **emergency**, **recovery**, **upgrade**, and **migration** paths where applicable — not only the happy path.

Create `research/architecture.md`, `research/asset-flows.md`, `research/trust-boundaries.md`.

**Discovery during reconstruction.** You *will* encounter interesting things before reconstruction is complete — suspicious authorization asymmetry, unusual controller wiring, a missing validation, an odd external call, a stale deployment, unusual storage layout, suspicious assembly, a potential invariant violation. **Do not investigate it deeply.** Instead: record it in `research/leads.md` (`OBSERVED`), preserve the evidence and its exact location, assign an initial confidence/impact hypothesis, and continue the reconstruction phase you were in. Return to the lead only after `scripts/gate_check.sh` reports the Hypothesis Generation Gate `OPEN` — see "Anti-Anchoring" below. Never let `OBSERVED` become `EXPLOIT` directly; see "Mandatory Phase Gate" above.

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

**Explicit deployment-verification failure handling.** When RPC access, deployment metadata, bytecode, configuration, or other production evidence is unavailable or incomplete:

1. Mark the affected deployment information **UNVERIFIED** in `research/deployment.md`. A capability you could not confirm is `UNVERIFIED`, never silently `ACTIVE` / `INACTIVE`.
2. **Do not infer live behavior from source alone.** Source capability is SOURCE_VERIFIED, not DEPLOYMENT_VERIFIED.
3. Continue source-level research where it is still useful, but tag any deployment-dependent conclusion **BLOCKED** or **UNKNOWN** in the ledger.
4. Explicitly record what evidence is missing (which RPC, which bytecode, which configuration, which block).
5. Revisit deployment verification when tooling becomes available. A BLOCKED conclusion is a reason to return, not a license to assume.

**Source/deployment drift rules.** The agent must never silently convert "source says X" into "deployed protocol does X" unless deployment evidence supports it. Whenever the pinned source revision differs from the deployed code / version / configuration — or the deployment cannot be confirmed at all — that is a **deployment-verification blocker**, not an assumption to paper over.

Rujira FIN-style example (conceptually): a source revision that is not known to equal the deployed contract / version / configuration must produce a deployment-verification blocker. Any hypothesis that depends on the deployed code behaving like the pinned source is marked **BLOCKED** until the deployment is confirmed — no matter how convincing the source-level logic looks. This applies equally to bytecode drift, proxy/implementation mismatch, configuration differences, and missing evidence.

Deployment facts **must be stored in `research/deployment.md`** — never buried inside `architecture.md` or another artifact. `scripts/gate_check.sh` checks `deployment.md` itself; evidence recorded in the wrong file does not count as Phase 2 completion, no matter how thorough it is.

Create `research/deployment.md`.

## PHASE 3 — INVARIANT RECONSTRUCTION (mandatory)

This phase is **mandatory** and gates hypothesis generation — it does not run only when the target looks economically interesting. Before generating any exploit hypothesis, derive the properties that must remain true. Identify, where relevant:

- ownership invariants
- authorization invariants
- accounting invariants
- conservation invariants (assets backing liabilities, conservation of value across conversions)
- solvency / collateralization invariants (debt/collateral relationships, liquidation thresholds, redemption mechanisms)
- monotonicity invariants
- lifecycle invariants
- expiry/epoch invariants
- uniqueness invariants
- state-machine invariants
- cross-contract consistency invariants
- upgrade/migration invariants

This also covers what the prior "economic model" pass captured: protocol assets and liabilities, user balances, shares, debt, collateral, fees, rewards, exchange rates, reward accounting, fee accounting, oracle-dependent valuation. That content is a subset of invariant reconstruction, not a separate step.

For **every** important invariant, trace:

```
INVARIANT → PROTECTING MECHANISM → STATE VARIABLES → ENFORCEMENT POINT → POSSIBLE BYPASS BOUNDARY
```

which subsumes the earlier WHERE CREATED / WHERE ASSUMED / WHERE CAN CHANGE / WHO CAN INFLUENCE / ACTUALLY ENFORCED breakdown.

**Do not invent economic invariants when the protocol has no meaningful economic component.** But do not skip the phase without explicitly establishing why — replace the invariant list with an explicit "No Applicable Invariants" rationale (see `references/templates.md`) instead of leaving the file empty. `scripts/gate_check.sh` accepts either a substantively filled `INV-###` ledger or an explicit rationale as Phase 3 completion; it does not accept an empty file.

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

Create `research/assumptions.md`. Any lead surfaced during assumption mining follows the same rule as PHASE 1: record it in `research/leads.md` as `OBSERVED`, do not chase it, and continue mining.

## Anti-Anchoring — Discovery ≠ Validation

Finding suspicious code is not finding a vulnerability. Ragnarok must distinguish **discovery** from **validation**, and this distinction is what stops a shiny lead from overriding the reconstruction gate.

For **every** lead in `research/leads.md` before it may be promoted `QUEUED → HYPOTHESIS`, force explicit answers to:

1. What exactly is suspicious?
2. What security property could be violated?
3. What attacker capability is required?
4. What state transition is affected?
5. What prevents the attack today?
6. What exact assumption would need to fail?
7. Can that assumption actually fail?
8. What is the smallest falsifiable experiment?
9. What evidence would kill the hypothesis?

Do **not** permit vague reasoning such as "could potentially lead to...". A hypothesis is expressed as a **concrete state transition**, not a feeling of suspicion.

## Hypothesis Generation Gate (mandatory checkpoint)

`research/hypotheses.md` cannot become an active investigation artifact until `scripts/gate_check.sh research/` reports the Hypothesis Generation Gate as `OPEN` — i.e. scope, architecture, asset flows, trust boundaries, deployment reality, and invariants are all `COMPLETE`.

```
PHASE GATE CHECK

Phase 0: COMPLETE
Phase 1: INCOMPLETE
  architecture.md: EMPTY
  asset-flows.md: EMPTY
  trust-boundaries.md: COMPLETE

Phase 2: BLOCKED
Phase 3: BLOCKED

Hypothesis Generation Gate (Phase 5+): LOCKED

Action:
DO NOT ADVANCE.
Return to Phase 1 reconstruction.
Pending leads preserved: 3
```

If the gate reports `LOCKED`: **STOP HYPOTHESIS GENERATION.** Continue reconstruction. Continue recording leads. Do **not** deepen exploit analysis on any of them — no matter how compelling a specific lead looks. A slower, complete reconstruction is preferable to a fast investigation anchored on the first suspicious function.

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
EVIDENCE LEVEL
STATUS
```

Statuses (only one at a time): `UNTESTED`, `TESTING`, `KILLED`, `INCONCLUSIVE`, `SURVIVOR`, `CONFIRMED`.

**EVIDENCE LEVEL** records the strongest level actually reached (see "Evidence & provenance model"): `SOURCE_VERIFIED` → `DEPLOYMENT_VERIFIED` → `RUNTIME_VERIFIED` → `ECONOMICALLY_VERIFIED`. A hypothesis may only be **CONFIRMED** when its effect is RUNTIME_VERIFIED and its impact is ECONOMICALLY_VERIFIED. **SURVIVOR** means it survived falsification but has not met that bar — it is a lead, not a finding.

Create `research/hypotheses.md`. When a hypothesis originates from a queued lead, update its status in `research/leads.md` too (`QUEUED → HYPOTHESIS`, and later `→ CONFIRMED` / `→ FALSIFIED`) — do not let the same discovery live in two ledgers with two different, unsynchronized statuses.

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

Prefer **executable evidence** over prose. Put experiments under `research/experiments/`, executed through the target's execution adapter (EVM: `forge test` / Anvil fork / `cast`; CosmWasm: `cw-multi-test` fixtures or a local chain; Solana: Anchor / LiteSVM; or the equivalent native runtime). Name each experiment by hypothesis ID, e.g. `research/experiments/H-003-mint-reentrancy`. Evidence is RUNTIME_VERIFIED only when the behavior was reproduced against the relevant implementation / runtime — a separate arithmetic model is not a runtime reproduction.

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

Distinguish **TECHNICAL VIOLATION** from **ECONOMIC EXPLOIT**. **Do not assign severity until this analysis exists.** An issue reaches **ECONOMICALLY_VERIFIED** only when its impact is computed as a realistic attacker / protocol delta with real preconditions and attacker control — not a bare state transition.

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

This is **mandatory**, not optional. Every consumer of the primitive must be hunted. Create `research/survivors.md` capturing the primitive and each manifestation with its own status **and its evidence level carried forward from `hypotheses.md`** — the level is never dropped when a hypothesis becomes a manifestation.

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

- **CONFIRMED** — executable proof (RUNTIME_VERIFIED) + economic validation (ECONOMICALLY_VERIFIED) + survived falsification
- **INCONCLUSIVE** — plausible but unproven or blocked
- **DESIGN RISK** — dangerous design but not shown exploitable
- **PRIVILEGED RISK** — requires admin/operator/key compromise, not permissionless
- **FALSE POSITIVE** — was shown not exploitable
- **COVERAGE LIMITATION** — a surface not fully investigated; say why

**Never inflate severity.** A clean result is acceptable and should be reported honestly alongside the exhausted attack surfaces.

Create `research/final.md` — the **complete internal investigation record**: all buckets, all kills, all survivors, all coverage limitations, the full falsification history. Every bucket entry records its evidence level, carried forward from `hypotheses.md` and `survivors.md`, so the evidence supporting a status is never lost in the final record.

**Disclosure-ready report.** Create `research/report.md` — a disclosure-ready artifact containing **CONFIRMED findings only**.

- A hypothesis that is only **SURVIVOR** or **INCONCLUSIVE** is never a report finding. Survivors and incomplete leads stay in `final.md`, `survivors.md`, and `hypotheses.md`; they do not enter `report.md`.
- **Do not generate a vulnerability report merely because a hypothesis is SURVIVOR or INCONCLUSIVE.** Reporting requires a CONFIRMED finding.
- If no confirmed vulnerability exists, `report.md` must explicitly state that **no confirmed finding meets the Ragnarok evidence standard**, rather than fabricating or downgrading one. A clean report is a valid, honest deliverable.
- Follow the report template in `references/templates.md`. Never include unproven hypotheses, and never inflate a finding's evidence level or severity to fill the template.

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
13. Report a SURVIVOR or INCONCLUSIVE lead as a confirmed finding, or treat a hand-written model as a runtime reproduction.
14. Advance to hypothesis generation, exploit construction, fuzzing, or deep falsification of a specific lead before `scripts/gate_check.sh` reports the Hypothesis Generation Gate `OPEN` — a compelling lead is not an exception.
15. Investigate a lead deeply (`OBSERVED → EXPLOIT`) instead of recording it in `leads.md` and returning to reconstruction (`OBSERVED → QUEUED`).
16. Trust conversation history, tool-call history, or an agent's self-report of "phase complete" instead of what `scripts/gate_check.sh` reports from the artifacts on disk.
17. Store deployment, architecture, or invariant evidence in the wrong artifact and count it toward that phase's completion.

## Quality bar

Behave like a patient adversarial researcher, not a vulnerability scanner.

- ONE deeply investigated hypothesis **over** TWENTY shallow warnings.
- EXECUTABLE EVIDENCE **over** SPECULATION.
- ECONOMIC PROOF **over** SEVERITY GUESSING.
- DEPLOYMENT REALITY **over** SOURCE-ONLY ANALYSIS.
- EXPLICIT EVIDENCE LEVELS **over** IMPLIED CONFIDENCE.
- NOVEL ATTACK PATHS **over** CHECKLIST COMPLETION.

Be prepared to spend substantial time on one promising primitive before moving on. The objective is **not** to prove the protocol is vulnerable. The objective is to discover **whether** it contains a previously unidentified, practically exploitable failure — and to gather enough evidence to prove it either way.

## Execution checklist (quick reference)

1. `scripts/scaffold.sh <target-dir>` — create `research/` state.
2. PHASE 0 → write `scope.md`; record authorization status + classify environment (default UNKNOWN / READ_ONLY_PRODUCTION / live=NO).
3. PHASE 1 → `architecture.md`, `asset-flows.md`, `trust-boundaries.md`. Queue anything suspicious in `leads.md` (`OBSERVED`) instead of chasing it.
4. PHASE 2 → `deployment.md` (verify vs chain, classify ACTIVE/INACTIVE/UNKNOWN). Keep deployment facts in this file, not scattered elsewhere.
5. PHASE 3 → `invariants.md` (or an explicit "No Applicable Invariants" rationale — never leave it empty).
6. PHASE 4 → `assumptions.md` (cross-boundary first). Keep queueing leads.
7. **Gate check** → `scripts/gate_check.sh research/`. If `LOCKED`, return to the phase it names — do not proceed to step 8 regardless of how compelling a queued lead looks.
8. PHASE 5 → `hypotheses.md` ledger, only once the gate is `OPEN`. Promote a lead `QUEUED → HYPOTHESIS` only after answering the anti-anchoring questions.
9. PHASE 6 → run experiments under `research/experiments/`.
10. PHASE 7 → mutate failed attacks, record kills in `killed.md`.
11. PHASE 8–9 → composition + state-machine passes.
12. PHASE 10 → economic validation before any severity.
13. PHASE 11 → falsify survivors.
14. PHASE 12 → expand primitives into `survivors.md`.
15. PHASE 13 → second-pass novelty.
16. PHASE 14–15 → residual surface; `final.md` (complete internal record) + `report.md` (disclosure-ready, CONFIRMED findings only).

Always run `scripts/gate_check.sh` and re-read `hypotheses.md`, `leads.md`, and `killed.md` before continuing any resumed investigation. Persistent state is the skill — the gate script is how that rule stops being optional.
