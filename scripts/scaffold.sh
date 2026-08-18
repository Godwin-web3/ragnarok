#!/usr/bin/env bash
# Ragnarok state scaffold.
# Usage: ./scaffold.sh <target-dir>
# Creates the persistent research/ directory, a seeded scope.md header, and a
# starter hypotheses ledger. Idempotent: safe to re-run; never overwrites.
set -euo pipefail

TARGET="${1:-$PWD}"
RESEARCH="$TARGET/research"

mkdir -p "$RESEARCH/experiments"

for f in \
  assumptions.md \
  killed.md \
  survivors.md \
  final.md; do
  if [ ! -f "$RESEARCH/$f" ]; then
    : > "$RESEARCH/$f"
  fi
done

# architecture.md / asset-flows.md / trust-boundaries.md — PHASE 1. Seeded
# with the required section headers (empty bodies) so scripts/gate_check.sh
# can mechanically tell "skeleton" apart from "filled in".
if [ ! -f "$RESEARCH/architecture.md" ]; then
  cat > "$RESEARCH/architecture.md" <<'EOF'
## Contracts & Components

## Entry Points

## Privileged Functions & Upgrade Paths

## External Dependencies & Callback Surfaces

## Actor → Entry → Check → State → Effect Traces
EOF
fi

if [ ! -f "$RESEARCH/asset-flows.md" ]; then
  cat > "$RESEARCH/asset-flows.md" <<'EOF'
## Assets In

## Assets Out

## Custody & Accounting Transitions

## Mint / Burn / Claim / Redemption Paths

## Attacker-Controlled Inputs Affecting Value
EOF
fi

if [ ! -f "$RESEARCH/trust-boundaries.md" ]; then
  cat > "$RESEARCH/trust-boundaries.md" <<'EOF'
## Actors & Authorities

## Actor → Entry Point → Check → Internal Call → State Write → Effect Traces

## Normal / Emergency / Recovery / Upgrade / Migration Paths
EOF
fi

# deployment.md — PHASE 2. Canonical home for deployment facts; do not bury
# them in architecture.md or elsewhere.
if [ ! -f "$RESEARCH/deployment.md" ]; then
  cat > "$RESEARCH/deployment.md" <<'EOF'
Capability | Contract/Address | Status
--- | --- | ---
<feature> | 0x... | ACTIVE / INACTIVE / UNKNOWN / UNVERIFIED

## Missing / unavailable evidence
EOF
fi

# invariants.md — PHASE 3, mandatory. Fill in INV-### entries, or replace the
# body with an explicit "## No Applicable Invariants" rationale if the target
# genuinely has no meaningful invariants — never leave it empty.
if [ ! -f "$RESEARCH/invariants.md" ]; then
  cat > "$RESEARCH/invariants.md" <<'EOF'
## INV-001 — <name>
- Definition:
- WHERE CREATED: file:line
- WHERE ASSUMED: file:line
- WHERE CAN CHANGE: file:line
- WHO CAN INFLUENCE:
- ACTUALLY ENFORCED?: yes / no / partial
- Enforcement point:
EOF
fi

# leads.md — pending lead queue. A lead observed during reconstruction is
# recorded here (OBSERVED -> QUEUED) and left for Phase 5+, never chased
# immediately. See "Discovery during reconstruction" in SKILL.md.
if [ ! -f "$RESEARCH/leads.md" ]; then
  cat > "$RESEARCH/leads.md" <<'EOF'
# Pending Leads

ID | LOCATION | OBSERVATION | INITIAL CONFIDENCE | INITIAL IMPACT | STATUS
---|---|---|---|---|---

Status lifecycle: OBSERVED -> QUEUED -> HYPOTHESIS -> TESTING -> CONFIRMED / FALSIFIED / SELF_RESOLVED
Never: OBSERVED -> EXPLOIT. A lead may only become HYPOTHESIS once
scripts/gate_check.sh reports the Hypothesis Generation Gate as OPEN, and
only after answering the anti-anchoring questions in SKILL.md.
FALSIFIED = an empirical check ran and failed. SELF_RESOLVED = closed by
reasoning alone, no empirical check -- revisit these in PHASE 13.
EOF
fi

# scope.md — seeded with the authorization & research-environment header.
# Default: Authorization UNKNOWN, env READ_ONLY_PRODUCTION, live exploitation NO.
if [ ! -f "$RESEARCH/scope.md" ]; then
  cat > "$RESEARCH/scope.md" <<'EOF'
# Scope

## Authorization & research environment (PHASE 0 — REQUIRED)
- Authorization status: UNKNOWN / NONE / CONFIRMED   # <-- set one
- Research environment: READ_ONLY_PRODUCTION / LOCAL_FORK / AUTHORIZED_LIVE   # <-- set one
- Live exploitation permitted: YES / NO             # <-- set one
- Default (if undetermined): UNKNOWN / READ_ONLY_PRODUCTION / NO
- Environment rules enforced (see SKILL.md):
  - READ_ONLY_PRODUCTION -> no transactions, no production state change, no live exploit execution; analysis continues
  - LOCAL_FORK          -> free local experimentation, impersonation only inside the fork, PoCs, isolated from production
  - AUTHORIZED_LIVE     -> only explicit scope; never exceed authorized boundaries

## Authorization
Authorization is required for **live state-changing exploitation only**. It is NOT
required for read-only analysis, public-chain observation, historical analysis, or
isolated local/fork experimentation. Absence of a public bounty or explicit
authorization changes the execution environment; it does not terminate research.
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
# A prior for novelty priority -- never a reason to skip verification.
# Known scrutiny reduces where to look first; it never makes an area safe.
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
EOF
fi

# Starter hypothesis ledger — only if not already present.
if [ ! -f "$RESEARCH/hypotheses.md" ]; then
  cat > "$RESEARCH/hypotheses.md" <<'EOF'
# Hypothesis Ledger

ID | ASSUMPTION | ATTACK SURFACE | PRECONDITIONS | ATTACK SEQUENCE | EXPECTED EFFECT | EXPECTED ECONOMIC CONSEQUENCE | TEST PLAN | EVIDENCE LEVEL | STATUS
---|---|---|---|---|---|---|---|---|---
H-001 | _e.g. oracle price is trusted as fresh_ | _mint/withdraw path_ | _state, roles, funds_ | _ordered steps_ | _state delta_ | _$ impact_ | _experiment file_ | SOURCE_VERIFIED | UNTESTED

Statuses: UNTESTED | TESTING | KILLED | INCONCLUSIVE | SURVIVOR | CONFIRMED
Evidence levels: SOURCE_VERIFIED | DEPLOYMENT_VERIFIED | RUNTIME_VERIFIED | ECONOMICALLY_VERIFIED
CONFIRMED requires RUNTIME_VERIFIED (effect) + ECONOMICALLY_VERIFIED (impact). SURVIVOR alone is a lead, not a finding.
EOF
fi

# report.md — seeded so it cannot be misread as a finding by default.
if [ ! -f "$RESEARCH/report.md" ]; then
  cat > "$RESEARCH/report.md" <<'EOF'
# Ragnarok Finding Report

> Status: CONFIRMED   <!-- SURVIVOR / INCONCLUSIVE must NOT appear here. -->

**No confirmed finding meets the Ragnarok evidence standard.**
EOF
fi

echo "Ragnarok research state initialized at $RESEARCH"
ls -R "$RESEARCH"
echo
echo "Before hypothesis generation (PHASE 5), run:"
echo "  scripts/gate_check.sh $RESEARCH"
echo "Do not advance until it reports the Hypothesis Generation Gate as OPEN."