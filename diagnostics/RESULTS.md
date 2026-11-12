# Ragnarok Diagnostic Results

This is an append-only evidence ledger. Do not invent or estimate outcomes. Add a dated run entry only after executing it and preserving its artifacts.

## Current status

- Baseline version: V6.1
- Diagnostic target: V6.5
- Benchmark protocol: defined in [BENCHMARK.md](BENCHMARK.md)
- Baseline description: [BASELINE.md](BASELINE.md)
- Executed benchmark runs: **0 recorded in this ledger**
- Aggregate score: **NOT MEASURED**

## Run index

| Run ID | Date (UTC) | Ragnarok commit | Track | Target | Status | Artifact |
|---|---|---|---|---|---|---|
| — | — | — | — | — | NOT RUN | — |

## Run entry template

Copy this section for every run. Keep the raw logs and generated research artifacts in a run-specific directory; link them here.

### RUN-YYYYMMDD-NNN

- Date/time (UTC):
- Operator:
- Ragnarok version / commit:
- Target and immutable target commit:
- Deployment / chain / fork block:
- Benchmark track: A / B / C
- Model and configuration:
- Time / token / tool budget:
- Authorization / execution mode:
- Answer key hidden until scoring: YES / NO

**Setup**

- Toolchain:
- Setup command:
- Setup result:
- Environment limitations:

**Research outcome**

- CX cards created:
- Assertable witnesses:
- Witnesses reached:
- Hypotheses killed with concrete falsifiers:
- Hypotheses not found under budget:
- Candidates submitted for verification:
- Report-gate result:

**Independent verification**

- Candidate ID:
- Clean reproduction: PASS / FAIL / BLOCKED
- Kill attempt:
- Runtime evidence:
- Economic evidence:
- Scope/class result:
- Verifier notes:

**Metrics**

- Target pass: YES / NO / BLOCKED
- Correct class: YES / NO / N/A
- False positives:
- Patched-control rejection: YES / NO / N/A
- Time to first valid witness:
- Time to verified result:
- Coverage completeness:
- Falsification completion:
- Cost:
- Regression:

**Artifacts**

- Run directory:
- stdout/stderr:
- Test output:
- Traces/state diffs:
- Candidate packet:
- Gate manifests:
- Answer-key scoring record:

**Conclusion**

State only what the artifacts support. Distinguish CONFIRMED, KILLED, NOT FOUND UNDER BUDGET and BLOCKED. Record follow-up work as a new hypothesis or benchmark change, not as a retroactive edit to this result.

---

## Change log

- Initial ledger created for the V6.5 diagnostic branch. No benchmark execution is implied by this commit.
