# PHASE 15 — Report

A CONFIRMED finding needs, where technically possible: root cause, file:line on the pinned revision, preconditions, attacker sequence, authorization analysis, executable reproduction, before/after state, economic impact, realistic attacker requirements, deployment relevance, mitigation, falsification attempts.

Buckets in `final.md`: CONFIRMED, INCONCLUSIVE, DESIGN RISK, PRIVILEGED RISK, FALSE POSITIVE, COVERAGE LIMITATION. Carry evidence levels forward.

`report.md` contains CONFIRMED findings only. Run:

```
scripts/report_gate.sh research/
```

If nothing is CONFIRMED, `report.md` is exactly:

```
# Ragnarok Finding Report

**No confirmed finding meets the Ragnarok evidence standard.**
```

That is a valid deliverable. Do not promote a SURVIVOR to fill the template.

If this is a bounty, also load `references/bounty.md` before submitting.

## Finding template (CONFIRMED only)

```md
# Ragnarok Finding Report

## Title
## Severity          (only after ECONOMICALLY_VERIFIED)
## Summary
## Root Cause
## Affected Code
## Preconditions
## Attacker Sequence
## Proof of Concept  (research/experiments/… — RUNTIME_VERIFIED)
## Before / After State
## Economic Impact
## Attacker Requirements
## Deployment Relevance
## Falsification Attempts
## Mitigation
```
