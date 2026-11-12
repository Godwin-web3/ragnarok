# Ragnarok Diagnostic Benchmark

Status: **protocol defined; scores not yet collected**  
Baseline: V6.1  
Target: V6.5 diagnostic cycle

## Purpose

Measure whether a Ragnarok revision improves the discovery and verification of real, in-scope security failures. Do not use activity metrics (tokens, tool calls, files read, warning count, report length) as proxies for research quality.

A benchmark run is an experiment. It must be reproducible, isolated and scored against an answer key that is unavailable to the research agent during the hunt.

## Evaluation tracks

### Track A — Known-broken targets

Use intentionally vulnerable training targets and historical reproductions. The existing `evals/` corpus is the starting point.

A pass requires all applicable conditions:

1. The agent creates a contradiction card with a falsifiable, assertable witness.
2. It identifies the relevant component pairing and a valid construction.
3. A local test/probe reaches the witness, or the hypothesis is honestly killed with a recorded counterexample.
4. The result's class matches the hidden rubric (EXTRACT, GRIEF or PRIVILEGED).
5. The answer key is consulted only after the report gate / blind run is complete.

A generic label such as "reentrancy" does not satisfy a target-specific expected contradiction.

### Track B — Patched controls

For each known-broken target, where practical, include a patched revision or a negative control.

The harness must not report the historical issue as currently exploitable when the tested revision removes the relevant path. It should identify the patch boundary and show why the old witness no longer holds.

### Track C — Unseen / held-out targets

Use targets not included in prompt examples, shape packs or run-time answer keys. Record these separately from known-broken rediscovery. A held-out result is not a confirmed finding unless the exploit is independently reproducible and in scope.

## Reproducibility manifest

Every run must record:

- Run ID and UTC start/end time.
- Ragnarok git commit, branch and `VERSION`.
- Target repository, immutable commit and relevant deployment address.
- Chain, fork RPC provider (provider name only; never secrets), chain ID and fork block.
- Foundry / Solidity / compiler versions and relevant configuration.
- Model identifier and relevant reasoning/tool configuration when available.
- Skill, prompt and harness configuration hashes where practical.
- Authorization and execution mode.
- Benchmark track and target ID.
- Whether the answer key remained hidden until scoring.

Never store RPC credentials, private keys, seed phrases or other secrets in benchmark artifacts.

## Metrics

Report each metric with numerator, denominator and raw run references. Do not collapse everything into one opaque score.

| Metric | Definition |
|---|---|
| Target pass rate | Targets meeting the track's complete pass criteria / targets attempted |
| Witness reach rate | Assertable witnesses reached by valid sequences / witnesses attempted |
| Correct class rate | Correctly classified outcomes / scored outcomes |
| False-positive rate | Unsupported or disproven claims promoted as findings / claims promoted |
| Patched-control rejection | Patched controls correctly not reported exploitable / patched controls attempted |
| Reproduction rate | Candidate findings independently reproduced from recorded artifacts / candidates submitted for verification |
| Time to first valid witness | Wall-clock time from run start to first executable witness |
| Time to verified result | Wall-clock time from run start to verified or honestly killed result |
| Coverage completeness | Required target components/seams with evidence / required components/seams in target manifest |
| Falsification completion | Hypotheses with an explicit falsification result / hypotheses promoted to probing |
| Cost per verified result | Recorded model/tool/runtime cost / independently verified results |
| Regression count | Previously passing cases that fail on the new revision |

A target that was not reached because of missing source, unavailable RPC, broken setup or insufficient authorization is **BLOCKED**, not a pass or a clean result.

A finite fuzz run that finds no witness is **NOT FOUND UNDER RECORDED BUDGET**, not proof of unreachability. Only classify a hypothesis as KILLED when a concrete falsifier invalidates its construction or required precondition.

## Independent verification protocol

The discovery pass and verification pass must be separated.

1. Discovery produces a candidate packet: target pin, CX card, witness, sequence, harness, traces, state/balance deltas, assumptions and claimed impact.
2. Freeze the candidate packet. Do not silently edit it during verification.
3. Verification starts from a clean checkout / clean fork state and follows the packet without relying on discovery chat history.
4. The verifier attempts to reproduce the witness and then attempts to kill it by challenging assumptions, actor permissions, liquidity, timing, oracle conditions, deployment identity and monetization.
5. Record PASS, FAIL or BLOCKED with exact evidence. A different model or human reviewer is useful where available, but the protocol must not depend on a specific vendor or uncontrolled multi-agent fan-out.
6. Only promote to CONFIRMED when runtime, economic and scope requirements are met.

## Candidate packet schema

Each candidate must include:

- `candidate_id`
- `target_commit` and deployment/fork pin
- `cx_id`
- `state`, `contradiction`, `pairing`
- `valid_sequence` and actor permissions
- `witness_expression`
- `harness_path` and exact command
- `runtime_result` and trace/artifact references
- `economic_delta` with asset denomination and assumptions
- `class` and in-scope rubric citation
- `falsification_attempt` and result
- `status`: INVENTED / PROBING / REACHABLE / SURVIVOR / KILLED / CONFIRMED / BLOCKED

## Run procedure

1. Start from a clean checkout of the exact Ragnarok commit.
2. Verify toolchain and target pins.
3. Select a benchmark target and create a run directory.
4. Keep `EXPECTED.md` and other answer-key files out of the agent's readable context.
5. Run Ragnarok using the documented workflow.
6. Preserve all research artifacts, stdout/stderr, test output and traces.
7. Run `gate_check.sh` and `report_gate.sh`.
8. Run independent reproduction on every candidate finding.
9. Only then reveal the answer key and score the target.
10. Append results to `RESULTS.md`; never overwrite earlier runs.

## Comparison rules

For a fair V6.1 vs V6.5 comparison:

- Use the same target commit, deployment pin and fork block.
- Use the same time / token / tool budget, or clearly report unequal budgets.
- Keep answer keys hidden in both runs.
- Run at least three repetitions for stochastic model behavior when budget permits.
- Report per-target outcomes, not only aggregate averages.
- Separate harness changes from model changes where possible.
- Do not tune against a held-out target and then continue calling it held out.

## Acceptance criteria for the diagnostic cycle

Do not declare V6.5 better merely because the documents or code are larger.

The diagnostic cycle is complete when:

- Baseline behavior has been run and recorded.
- All existing eval targets have explicit status: PASS, FAIL or BLOCKED.
- At least one patched/negative control is evaluated.
- Candidate findings undergo clean independent reproduction.
- Regression results are recorded.
- Every claimed improvement is tied to a measured metric.
- No V6.1 hard safety or evidence gate regresses without an explicit, reviewed decision.
