# PHASE 5 — Protocol model

Mandatory for CAMPAIGN OPEN. Not a lock on Adversarial State Synthesis.

Phases 3–4 produce raw ingredients: invariants and assumptions. This phase produces a second representation of the protocol — what it *promises*, under which conditions, through which state transitions, with which accounting identities.

Do **not** create `economic-model.md`, `state-machine.md`, or `accounting-model.md`. One canonical file: `research/protocol-model.md`.

`invariants.md` and `assumptions.md` remain evidence. They do not compete with this file. Link them by ID.

Write or grow this file when a `CX-###` needs a named promise. Do not pause contradiction cards until this file is campaign-complete.

## Shape of a record

```
Actor
  → Promise / claim
  → Required condition
  → State transition
  → Accounting relationship
  → Enforcement
  → Attacker influence
  → Potential value transfer
```

IDs: `ACT-###`, `PROM-###`, `COND-###`, `ST-###`, `ACC-###`. Reuse `ASM-###` and `INV-###` instead of restating them.

## What this phase is not

- Not deeper assumption mining.
- Not a checklist of attack primitives. Those become scanners.
- Not architecture prose. The map already exists.
- Not runtime proof. A falsification *plan* here is the cheapest check that would show the promise is unhonored.

## Generator, not scanner

After a model exists, constructions still come from contradictions, not from a catalog:

> Given these promises and representations, what impossible state would make a participant's expected claim greater than the system's ability to honor it?

## Done when the campaign gate passes

The gate does not score essay length. It checks:

- every critical actor has ≥1 promise
- every promise has ≥1 required condition with provenance
- every required `ASM-###` / `COND-###` exists
- every accounting relationship names its variables (or links a real `INV-###`)
- every state transition names who can trigger it
- every critical promise has a falsification plan

If the target has no meaningful claims on value, write `## No Applicable Protocol Model` with a rationale.

Schema: `references/templates.md`. Density: `references/examples/donation-inflation.md`.
