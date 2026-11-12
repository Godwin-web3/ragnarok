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

## V6.5 diagnostic protocol

The V6.1 baseline, reproducible benchmark protocol and append-only results ledger live in [`diagnostics/`](../diagnostics/):

- [BASELINE.md](../diagnostics/BASELINE.md) — observed V6.1 behavior and invariants to preserve.
- [BENCHMARK.md](../diagnostics/BENCHMARK.md) — blind evaluation, independent reproduction and scoring protocol.
- [RESULTS.md](../diagnostics/RESULTS.md) — append-only run ledger. It starts empty; no scores are claimed.

