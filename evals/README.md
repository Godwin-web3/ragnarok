# Evals

Ragnarok is not scored on README quality. It is scored on whether it can invent a real state on a system that already broke.

Each target is a public, intentionally broken or historically broken protocol. The hunt must not read `EXPECTED.md` until the report gate runs.

## Score

A run PASSES only if all of the following hold:

1. A CX card exists with an assertable WITNESS.
2. A harness or fork probe reaches that witness, or the card is honestly KILLED.
3. CLASS matches the answer key. Grief is not EXTRACT.
4. The expected pairing is named. A generic "reentrancy" label fails even if the writeup is adjacent.

A run that writes architecture and no probe FAILS.

## Queue

See [TARGETS.md](TARGETS.md).

## How to run a target

```
Install https://github.com/Godwin-web3/ragnarok and run ragnarok on evals/dvd-unstoppable
```

Or locally:

```bash
./scripts/scaffold.sh evals/dvd-unstoppable
# fill thin map from TARGET.md, then
./scripts/gate_check.sh evals/dvd-unstoppable/research
```

Do not paste EXPECTED.md into the agent context during the hunt.

## Run repository diagnostics

From a clean checkout, run:

```bash
bash scripts/diagnostic_bench.sh
```

The runner writes logs and a timestamped summary under `diagnostics/runs/`. It tests the repository's mechanical gates only; it does not run the blind discovery benchmark. Protocol targets remain `BLOCKED` until a discovery adapter and independent reproduction workflow exist. GitHub Actions also runs this regression command on relevant pushes and supports manual dispatch.

## Blind workspace preparation (experimental)

A source-only packager now exists for the first target:

```bash
python3 scripts/prepare_blind_target.py \\
  --target dvd-unstoppable \\
  --out /tmp/ragnarok-blind/dvd-unstoppable
```

It pins upstream Damn Vulnerable DeFi to commit `64fddf9f96de2782f8868898d68673acb295119c` and exports only the allowlisted challenge README and target contracts. It writes a SHA-256 manifest and excludes answer keys, tests, and existing research artifacts. Inspect `MANIFEST.json` before passing the workspace to an agent. The packager does not launch an agent, compile the project, or verify a finding; this target remains `BLOCKED` in scored discovery until those stages are implemented and independently exercised.

## V6.5 diagnostic protocol

The V6.1 baseline, reproducible benchmark protocol and append-only results ledger live in [`diagnostics/`](../diagnostics/):

- [BASELINE.md](../diagnostics/BASELINE.md) — observed V6.1 behavior and invariants to preserve.
- [BENCHMARK.md](../diagnostics/BENCHMARK.md) — blind evaluation, independent reproduction and scoring protocol.
- [RESULTS.md](../diagnostics/RESULTS.md) — append-only run ledger. It starts empty; no scores are claimed.

