#!/usr/bin/env bash
# Ragnarok state scaffold.
# Usage: ./scaffold.sh <target-dir>
# Idempotent: safe to re-run; never overwrites existing files.
set -euo pipefail

TARGET="${1:-$PWD}"
RESEARCH="$TARGET/research"

mkdir -p "$RESEARCH/experiments"

for f in \
  final.md; do
  if [ ! -f "$RESEARCH/$f" ]; then
    : > "$RESEARCH/$f"
  fi
done

if [ ! -f "$RESEARCH/NOW.md" ]; then
  cat > "$RESEARCH/NOW.md" <<'EOF'
# NOW

- Phase: 0
- Gate: LOCKED
- Env:
- Pin:
- Adapter:
- Focus lock: live 0/2, probes 0/1, unresolved 0
- Open probe:
- Last falsifier result:

## Map (15 lines max)
- Components:
- External deps:
- Assets:
- Authorities:
- Unmapped / UNVERIFIED:

## Live invariants / assumptions

## Experiment seam (not the scope of the map)
- Current cut-set:
- Do not drop from map:

## Queue
1.

## Ranked open hypotheses

## BLOCKED
EOF
fi

if [ ! -f "$RESEARCH/architecture.md" ]; then
  cat > "$RESEARCH/architecture.md" <<'EOF'
# Architecture

## Component graph
Component | Type | Address | Role | Trusts | Trusted by
--- | --- | --- | --- | --- | ---

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

## Composition traces
Pairing | Trace | Invariant at risk
--- | --- | ---
EOF
fi

if [ ! -f "$RESEARCH/deployment.md" ]; then
  cat > "$RESEARCH/deployment.md" <<'EOF'
Capability | Contract/Address | Status
--- | --- | ---
<feature> | 0x... | ACTIVE / INACTIVE / UNKNOWN / UNVERIFIED

## Missing / unavailable evidence
EOF
fi

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

if [ ! -f "$RESEARCH/assumptions.md" ]; then
  cat > "$RESEARCH/assumptions.md" <<'EOF'
## ASM-001 — <statement of what is assumed to never happen>
- TRUSTED BY: file:line
- INFLUENCEABLE BY:
- FAILURE CONDITION:
- POSSIBLE CONSEQUENCE:
- ATTACK SURFACE:
- CROSSES BOUNDARY?:
- PROVENANCE:
- CONFIDENCE:
EOF
fi

if [ ! -f "$RESEARCH/protocol-model.md" ]; then
  cat > "$RESEARCH/protocol-model.md" <<'EOF'
## ACT-001 — <participant who holds or honors a claim>
- Critical?: yes / no

## PROM-001 — <statement the protocol makes to that actor>
- Actor: ACT-001
- Promise:
- Required conditions: ASM-### or COND-###
- Accounting: INV-### or ACC-###
- State transitions: ST-###
- Enforcement:
- Attacker influence:
- Potential value transfer:
- Falsification plan:

## ST-001 — <named state transition>
- Who can trigger:
EOF
fi

if [ ! -f "$RESEARCH/leads.md" ]; then
  cat > "$RESEARCH/leads.md" <<'EOF'
# Pending Leads

ID | LOCATION | OBSERVATION | INITIAL CONFIDENCE | INITIAL IMPACT | STATUS
---|---|---|---|---|---

Status lifecycle: OBSERVED -> QUEUED -> HYPOTHESIS -> TESTING -> CONFIRMED / FALSIFIED / SELF_RESOLVED
Never: OBSERVED -> EXPLOIT.
FALSIFIED = an empirical check ran and failed. SELF_RESOLVED = closed by
reasoning alone. Revisit before final.md. Probe as soon as SYNTHESIS is OPEN.
EOF
fi

if [ ! -f "$RESEARCH/scope.md" ]; then
  cat > "$RESEARCH/scope.md" <<'EOF'
# Scope

## Authorization & research environment (PHASE 0 — REQUIRED)
- Authorization status: UNKNOWN / NONE / CONFIRMED   # <-- set one
- Research environment: READ_ONLY_PRODUCTION / LOCAL_FORK / AUTHORIZED_LIVE   # <-- set one
- Live exploitation permitted: YES / NO             # <-- set one
- Default (if undetermined): UNKNOWN / READ_ONLY_PRODUCTION / NO

## Authorization
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
- Testing boundaries:

## Prior scrutiny
- Known audit reports (firm, date, commit/version scoped):
- Bounty program Known Issues / exclusions list:
- Prior disclosed vulnerabilities for this target:

## Deployment
- Chains:
- Deployed addresses:
- Assets at risk:

## Infrastructure
- RPC endpoints:
- Fork URL / block:
- Test harness:
EOF
fi

if [ ! -f "$RESEARCH/hypotheses.md" ]; then
  cat > "$RESEARCH/hypotheses.md" <<'EOF'
# Hypothesis Ledger

ID | ASSUMPTION | ATTACK SURFACE | PRECONDITIONS | ATTACK SEQUENCE | EXPECTED EFFECT | EXPECTED ECONOMIC CONSEQUENCE | TEST PLAN | EVIDENCE LEVEL | RANK | CHEAPEST FALSIFIER | STATUS
---|---|---|---|---|---|---|---|---|---|---|---
H-001 | _e.g. oracle price is trusted as fresh_ | _mint/withdraw path_ | _state, roles, funds_ | _ordered steps_ | _state delta_ | _$ impact_ | _experiment file_ | SOURCE_VERIFIED | P3 | _eth_call_ | UNTESTED

Statuses: UNTESTED | TESTING | KILLED | INCONCLUSIVE | SURVIVOR | CONFIRMED | GRIEF | PRIVILEGED
CONFIRMED requires RUNTIME_VERIFIED (effect) + ECONOMICALLY_VERIFIED (impact) + CLASS EXTRACT.
GRIEF and PRIVILEGED never occupy the permissionless CONFIRMED queue.
EOF
fi

if [ ! -f "$RESEARCH/report.md" ]; then
  cat > "$RESEARCH/report.md" <<'EOF'
# Ragnarok Finding Report

**No confirmed finding meets the Ragnarok evidence standard.**
EOF
fi

if [ ! -f "$RESEARCH/representations.md" ]; then
  cat > "$RESEARCH/representations.md" <<'EOF'
# Representations

FACT-001 | <fact>
Component | Representation
--- | ---
EOF
fi

if [ ! -f "$RESEARCH/contradictions.md" ]; then
  cat > "$RESEARCH/contradictions.md" <<'EOF'
# Contradictions

Required fields per card (do not invent until SYNTHESIS OPEN):

- STATE / CONTRADICTION / PAIRING / CONSTRUCTION / SEQUENCE
- WITNESS: assertable expression (not prose) or the card stays INVENTED
- MONETIZATION / CHEAPEST FALSIFIER / FALSIFIER RESULT
- HANDLERS / INVARIANT HARNESS (required once REACHABLE)
- CLASS: EXTRACT / GRIEF / PRIVILEGED / UNKNOWN
- STATUS: INVENTED | PROBING | REACHABLE | UNREACHABLE | MONETIZABLE | KILLED

Max 2 live cards (INVENTED/PROBING/REACHABLE). Max 1 open probe.
At least one card must name a two-component PAIRING.
EOF
fi

if [ ! -f "$RESEARCH/killed.md" ]; then
  cat > "$RESEARCH/killed.md" <<'EOF'
# Killed constructions

Every kill needs:
- Why it failed
- Mutations attempted
- Why the primitive is NOT recoverable via this path
- A revisit condition naming the entrypoint() or node that would reopen it

When architecture.md gains a node or entrypoint, gate_check queues every
killed card that has a `- Revisit if:` field. Kills are not permanently dead.
EOF
fi

if [ ! -f "$RESEARCH/survivors.md" ]; then
  cat > "$RESEARCH/survivors.md" <<'EOF'
# Surviving primitives
EOF
fi

if [ ! -f "$RESEARCH/coverage.md" ]; then
  cat > "$RESEARCH/coverage.md" <<'EOF'
# Coverage

- Files opened:
- Paths traced:
- CX cards written:
- H-### tested:
- Surfaces not covered:
- SELF_RESOLVED pending empirical check:
EOF
fi

echo "Ragnarok research state initialized at $RESEARCH"
ls -R "$RESEARCH"
echo
echo "Normal flow:"
echo "  scaffold → thin map → gate_check (SYNTHESIS OPEN) → invent pairing CX + shapes → probe → kill → report_gate"
echo "After a thin map, run:"
echo "  scripts/gate_check.sh $RESEARCH"
echo "CX → harness:"
echo "  scripts/harness_init.sh $TARGET --cx CX-001"
echo "  scripts/harness_init.sh $TARGET --invariant CX-001"
echo "Before shipping report.md, run:"
echo "  scripts/report_gate.sh $RESEARCH"
