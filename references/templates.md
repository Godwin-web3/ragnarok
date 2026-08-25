# Ragnarok — Template Pack

Reference templates for the persistent state files. Copy the relevant block into each `research/*.md` file and fill it in. These keep the methodology machine-readable and self-auditable.

## scope.md (PHASE 0)

```md
# Scope

## Authorization & research environment (PHASE 0 — REQUIRED)
- Authorization status: UNKNOWN / NONE / CONFIRMED
- Research environment: READ_ONLY_PRODUCTION / LOCAL_FORK / AUTHORIZED_LIVE
- Live exploitation permitted: YES / NO
- Default (if undetermined): UNKNOWN / READ_ONLY_PRODUCTION / NO
- Environment rules enforced (see SKILL.md):
  - READ_ONLY_PRODUCTION → no transactions, no production state change, no live exploit execution; analysis continues
  - LOCAL_FORK → free local experimentation, impersonation only inside the fork, PoCs, isolated from production
  - AUTHORIZED_LIVE → only explicit scope; never exceed authorized boundaries

## Authorization
Authorization is required for **live state-changing exploitation only**. It is **not** required for read-only analysis, public-chain observation, historical analysis, or isolated local/fork experimentation. Absence of a public bounty or explicit authorization changes the execution environment — it does not terminate research.
- Bounty / engagement: 
- Reference / link: 
- Date confirmed: 

## Target
- Repository: 
- Commit / version (pin): 
- Branch: 
- Local checkout path: 

## Bounty scope
- In-scope assets: 
- Out-of-scope: 
- Testing boundaries (fork-only? read-only RPC? testnets?): 

## Prior scrutiny
A prior for novelty priority — never a reason to skip verification. Known scrutiny reduces where to look
first for something new; it never makes an area safe (deployment drift, composition, and changed assumptions
can all reintroduce risk in already-audited code).
- Known audit reports (firm, date, commit/version scoped): 
- Bounty program "Known Issues" / exclusions list: 
- Prior disclosed vulnerabilities for this target: 

## Deployment
- Chains: 
- Deployed addresses:
  - Proxies / implementations: 
  - Factories / clones: 
  - Tokens: 
  - Oracles: 
  - Keepers: 
  - Governance / admins: 
- Assets at risk: 

## Infrastructure
- RPC endpoints: 
- Fork URL / block: 
- Test harness: 

## Constraints
- Write ops against production: NONE (unless AUTHORIZED_LIVE with explicit scope)
- Live state-changing exploitation: NO (until AUTHORIZED_LIVE)
- Read-only production access permitted for: 
- Local-fork experimentation: YES (isolated from production) 
```

## architecture.md (PHASE 1)

```md
# Architecture

## Contracts & Components
<contracts, implementations, proxies, factories, clones, libraries>

## Entry Points
<every external/public entry point, by contract>

## Privileged Functions & Upgrade Paths
<admin/owner/operator functions; upgrade mechanisms; initialization state>

## External Dependencies & Callback Surfaces
<oracles, tokens, external protocols, bridges, callback/reentrancy surfaces>

## Actor → Entry → Check → State → Effect Traces
<one trace per important control-flow path, e.g.:>
<Actor -> entryPoint() -> modifier/check -> internal call -> state write -> downstream effect>
```

`scripts/gate_check.sh` requires all five sections above to be present with
non-placeholder content before Phase 1 can be marked COMPLETE.

## asset-flows.md (PHASE 1)

```md
# Asset Flows

## Assets In
<how value enters the system>

## Assets Out
<how value leaves the system>

## Custody & Accounting Transitions
<custody transitions; internal accounting/share transitions>

## Mint / Burn / Claim / Redemption Paths
<every path that creates, destroys, or transfers a claim on value>

## Attacker-Controlled Inputs Affecting Value
<inputs an attacker can choose that influence a value-bearing state transition>
```

## trust-boundaries.md (PHASE 1)

```md
# Trust Boundaries

## Actors & Authorities
<users, operators, admins, guardians, keepers, controllers, contracts,
external protocols, oracles, bridges, upgrade authorities>

## Actor → Entry Point → Check → Internal Call → State Write → Effect Traces
<for every security-critical permission:>
<Actor -> entry point -> modifier/check -> internal call -> state write -> downstream effect>

## Normal / Emergency / Recovery / Upgrade / Migration Paths
<map each path explicitly where applicable — do not only list authorities,
trace what each one can actually do>
```

Do not merely list authorities — trace the full path for each
security-critical permission, and cover the emergency/recovery/upgrade/
migration paths explicitly, not only the normal-operation path.

## leads.md — pending lead queue (used throughout reconstruction)

```md
# Pending Leads

ID | LOCATION | OBSERVATION | INITIAL CONFIDENCE | INITIAL IMPACT | STATUS
---|---|---|---|---|---
L-001 | file:line | <what is suspicious> | LOW/MED/HIGH | <hypothesis of impact> | OBSERVED

Status lifecycle: OBSERVED -> QUEUED -> HYPOTHESIS -> TESTING -> CONFIRMED / FALSIFIED / SELF_RESOLVED
Never: OBSERVED -> EXPLOIT.

FALSIFIED means an empirical check ran and failed. SELF_RESOLVED means the lead was closed by reasoning
alone during reconstruction, no empirical check performed — not a weaker outcome, but a different one.
PHASE 14 revisits every SELF_RESOLVED entry with fresh skepticism before final.md is written.
```

Record every interesting-but-unverified observation here **immediately**,
then return to the reconstruction phase you were in. Do not investigate a
lead deeply until `scripts/gate_check.sh` reports the Hypothesis Generation
Gate as OPEN — and even then, a lead is promoted OBSERVED/QUEUED →
HYPOTHESIS only after it has answered the anti-anchoring questions (see
SKILL.md, "Anti-Anchoring — Discovery ≠ Validation").

## invariants.md (PHASE 3)

```md
# Invariants

## INV-001 — <name>
- Definition: 
- WHERE CREATED: file:line
- WHERE ASSUMED: file:line
- WHERE CAN CHANGE: file:line
- WHO CAN INFLUENCE: 
- ACTUALLY ENFORCED?: yes / no / partial
- Enforcement point: 
```

Cover, where relevant: ownership, authorization, accounting, conservation,
solvency, collateralization, monotonicity, lifecycle, expiry/epoch,
uniqueness, state-machine, cross-contract consistency, and upgrade/migration
invariants. If the target genuinely has no meaningful invariants in a
category, do not invent one — but do not skip the phase silently either.
Replace the body with an explicit rationale instead:

```md
## No Applicable Invariants
<explicit reasoning for why no meaningful invariant applies — this itself
satisfies scripts/gate_check.sh's Phase 3 completion check>
```

## assumptions.md (PHASE 4)

```md
# Assumption Registry

## ASM-001 — <statement of what is assumed to never happen>
- TRUSTED BY: file:line
- INFLUENCEABLE BY: 
- FAILURE CONDITION: 
- POSSIBLE CONSEQUENCE: 
- ATTACK SURFACE: 
- CROSSES BOUNDARY? (contract→contract, oracle→ext, accounting→token, ...): 
```

## protocol-model.md (PHASE 5)

```md
# Protocol Model

## ACT-001 — <participant who holds or honors a claim>
- Critical?: yes / no   <!-- omit the field and it defaults to yes -->

## PROM-001 — <statement the protocol makes to that actor>
- Actor: ACT-001
- Promise:
- Required conditions: ASM-### (reuse from assumptions.md) or COND-### (defined below, with Provenance)
- Accounting: INV-### (reuse from invariants.md) or ACC-### (defined below, with Variables)
- State transitions: ST-### (defined below)
- Enforcement:
- Attacker influence:
- Potential value transfer:
- Falsification plan: <cheapest check that would show the promise is unhonored — storage read, one eth_call, one unit test. Not a runtime PoC.>

## ST-001 — <named state transition>
- Who can trigger:

## ACC-001 — <accounting identity not already an INV-###>
- Variables:

## COND-001 — <required condition not already an ASM-###>
- Provenance: SOURCE_VERIFIED / DEPLOYMENT_VERIFIED / RUNTIME_VERIFIED / ECONOMICALLY_VERIFIED / UNVERIFIED
```

Reuse `ASM-###` and `INV-###` by ID — do not restate their text here. If the target has no meaningful claims on value:

```md
## No Applicable Protocol Model
<explicit reasoning for why no actor holds a claim this protocol could fail to honor —
this itself satisfies scripts/gate_check.sh's Phase 5 completion check>
```

Full schema and gate properties: `references/schema/protocol-model.md`.

## hypotheses.md (PHASE 6)

```md
# Hypothesis Ledger

ID | ASSUMPTION | ATTACK SURFACE | PRECONDITIONS | ATTACK SEQUENCE | EXPECTED EFFECT | EXPECTED ECONOMIC CONSEQUENCE | TEST PLAN | EVIDENCE LEVEL | STATUS
---|---|---|---|---|---|---|---|---|---
H-001 | ... | ... | ... | ... | ... | ... | research/experiments/H-001 | SOURCE_VERIFIED | UNTESTED

Statuses: UNTESTED | TESTING | KILLED | INCONCLUSIVE | SURVIVOR | CONFIRMED
Evidence levels: SOURCE_VERIFIED | DEPLOYMENT_VERIFIED | RUNTIME_VERIFIED | ECONOMICALLY_VERIFIED
CONFIRMED requires RUNTIME_VERIFIED (effect) + ECONOMICALLY_VERIFIED (impact). SURVIVOR alone is a lead, not a finding.
```

## killed.md (PHASE 8)

```md
# Killed Hypotheses

## H-001 — KILLED
- Why it failed: 
- Mutations attempted (ordering, caller, entry, asset, amount, timing, state, deps, repetition, composition): 
- Why the primitive (if any) is NOT recoverable via this path: 
- Revisit if: <condition that would reopen it>
```

## survivors.md (PHASE 13)

```md
# Surviving Primitives

## PRIM-001 — <underlying primitive>
- Root primitive: 
- Manifestations (each with its own status AND evidence level):
  - A: minting — SURVIVOR — RUNTIME_VERIFIED
  - B: redemption — CONFIRMED — ECONOMICALLY_VERIFIED
  - C: liquidation — KILLED (reason: ...) — SOURCE_VERIFIED
- Consumers still to hunt: 

Evidence level is carried forward from hypotheses.md — it must not be lost when a primitive moves here.
```

## deployment.md (PHASE 2)

```md
# Deployment Reality

Capability | Contract/Address | Status
--- | --- | ---
<feature> | 0x... | ACTIVE / INACTIVE / UNKNOWN / UNVERIFIED

Status values:
- ACTIVE / INACTIVE — confirmed against production read-only evidence (DEPLOYMENT_VERIFIED)
- UNKNOWN — not yet established
- UNVERIFIED — evidence is missing/unavailable; do NOT infer live behavior from source alone

## Missing / unavailable evidence
- Which RPC, bytecode, config, or block is missing: 
- Deployment-dependent conclusions: BLOCKED / UNKNOWN (see hypotheses.md)
- Revisit when: <tooling/access condition>
- Source↔deployment drift notes: <pinned source revision vs deployed version/config — divergence is a deployment-verification blocker>
```

## report.md (PHASE 16) — disclosure-ready, CONFIRMED findings only

```md
# Ragnarok Finding Report

> Status: CONFIRMED   <!-- SURVIVOR / INCONCLUSIVE must NOT appear here. If no CONFIRMED finding exists, write only the "No confirmed finding" line at the bottom and delete the rest. -->

## Title
<concise, e.g. "Stale-oracle mint allows free collateral extraction">

## Severity
<High / Medium / Low — assigned only after ECONOMICALLY_VERIFIED analysis; never before>

## Summary
<2–4 sentences: what, where, why it is exploitable, who is affected>

## Root Cause
<underlying defect, referencing the invariant/assumption that fails>

## Affected Code
<file:line for each relevant location — must be pinned to the source revision actually analyzed>

## Preconditions
<state, roles, funds, configuration, deployment facts required — each DEPLOYMENT_VERIFIED or explicitly flagged>

## Attacker Sequence
<ordered steps, one actor per line, ending in a measurable delta>

## Proof of Concept
<pointer to the executable reproduction under research/experiments/ — RUNTIME_VERIFIED evidence>

## Before / After State
<attacker balances & protocol balances before → after; where the value went>

## Economic Impact
<attacker profit, protocol/victim loss, capital/liquidity/gas required, repeatability — ECONOMICALLY_VERIFIED delta>

## Attacker Requirements
<capital, liquidity, gas, tokens, access, time; whether permissionless>

## Deployment Relevance
<is this reachable on the actual deployment? evidence level; note any deployment-verification blockers>

## Falsification Attempts
<each attempt to kill the finding and why it survived — mandatory; see PHASE 12>

## Mitigation
<concrete remediation options>

---

**No confirmed finding meets the Ragnarok evidence standard.**
<This single line is the entire report when nothing is CONFIRMED. It is a valid, honest deliverable — never fabricate a finding, and never promote a SURVIVOR or INCONCLUSIVE lead into this file.>
```

## final.md (PHASE 15) — complete internal record

```md
# Final Investigation Record

## CONFIRMED
- F-001 — <title>
  - Status: CONFIRMED
  - Evidence level: ECONOMICALLY_VERIFIED (effect RUNTIME_VERIFIED)
  - Source hypothesis / primitive: H-### / PRIM-###   <!-- carry the evidence level forward -->
  - Pointers: experiments/, survivors.md, report.md

## INCONCLUSIVE / DESIGN RISK / PRIVILEGED RISK / FALSE POSITIVE / COVERAGE LIMITATION
- <entry>
  - Status: <bucket>
  - Evidence level: <highest level actually reached, or N/A if none>

> Every bucket entry carries its evidence level, carried forward from hypotheses.md → survivors.md → final.md so no evidence is lost. Only CONFIRMED entries appear in report.md.
```
