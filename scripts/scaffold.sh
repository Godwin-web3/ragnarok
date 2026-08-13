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
  architecture.md \
  asset-flows.md \
  trust-boundaries.md \
  deployment.md \
  invariants.md \
  assumptions.md \
  killed.md \
  survivors.md \
  final.md; do
  if [ ! -f "$RESEARCH/$f" ]; then
    : > "$RESEARCH/$f"
  fi
done

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