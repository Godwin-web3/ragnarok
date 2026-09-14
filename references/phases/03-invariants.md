# PHASE 3 — Invariant reconstruction

Mandatory. Gates hypothesis generation.

For each important invariant:

```
INVARIANT → PROTECTING MECHANISM → STATE VARIABLES → ENFORCEMENT POINT → POSSIBLE BYPASS BOUNDARY
```

Cover where relevant: ownership, authorization, accounting, conservation, solvency / collateral, monotonicity, lifecycle, expiry/epoch, uniqueness, state-machine, cross-contract consistency, upgrade/migration.

Do not invent economic invariants a protocol does not have. If none apply, write `## No Applicable Invariants` with a rationale. An empty file fails the gate.

Each `INV-###` uses the seven fields in `references/templates.md`. No essays.

Phase 5 will link these `INV-###` ids from `protocol-model.md` as accounting evidence. Do not restate the invariant there.

When a CX becomes REACHABLE, map it to a Foundry invariant / handler set (`references/invariant-fuzz.md`). Reconstruction invariants (this file) are not the same object as the fuzz invariant, but the fuzz invariant should be the negation of the CX WITNESS.
