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

## invariants.md (PHASE 3)

```md
# Economic Invariants

## INV-001 — <name>
- Definition: 
- WHERE CREATED: file:line
- WHERE ASSUMED: file:line
- WHERE CAN CHANGE: file:line
- WHO CAN INFLUENCE: 
- ACTUALLY ENFORCED?: yes / no / partial
- Enforcement point: 
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

## hypotheses.md (PHASE 5)

```md
# Hypothesis Ledger

ID | ASSUMPTION | ATTACK SURFACE | PRECONDITIONS | ATTACK SEQUENCE | EXPECTED EFFECT | EXPECTED ECONOMIC CONSEQUENCE | TEST PLAN | STATUS
---|---|---|---|---|---|---|---|---
H-001 | ... | ... | ... | ... | ... | ... | research/experiments/H-001.t.sol | UNTESTED

Statuses: UNTESTED | TESTING | KILLED | INCONCLUSIVE | SURVIVOR | CONFIRMED
```

## killed.md (PHASE 7)

```md
# Killed Hypotheses

## H-001 — KILLED
- Why it failed: 
- Mutations attempted (ordering, caller, entry, asset, amount, timing, state, deps, repetition, composition): 
- Why the primitive (if any) is NOT recoverable via this path: 
- Revisit if: <condition that would reopen it>
```

## survivors.md (PHASE 12)

```md
# Surviving Primitives

## PRIM-001 — <underlying primitive>
- Root primitive: 
- Manifestations (each its own status):
  - A: minting — SURVIVOR
  - B: redemption — CONFIRMED
  - C: liquidation — KILLED (reason: ...)
- Consumers still to hunt: 
```

## deployment.md (PHASE 2)

```md
# Deployment Reality

Capability | Contract/Address | Status
--- | --- | ---
<feature> | 0x... | ACTIVE / INACTIVE / UNKNOWN
```
