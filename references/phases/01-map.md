# PHASE 1 — Map (thin first, wide when blocked)

Do not start with vulnerability scanning. Do not write a novel.

## Thin map (unlocks imagination)

Enough to invent states:

- `architecture.md` component graph with real rows (live contracts you already know)
- at least one actor→entry→effect trace **or** one composition pairing
- `NOW.md` lists what is still unmapped / UNVERIFIED

When that exists and Phase 0 is complete, SYNTHESIS OPEN. Invent impossible states. Do not wait for a finished model.

## Wide map (complete eventually, not first)

```
Component | Type | Address | Role | Trusts | Trusted by
```

Include every live contract, proxy, impl, factory, clone, library, token, oracle, keeper, governance, admin, external protocol, bridge, hook, strategy.

Grow the map when:

- a `CX-###` names a component that is not a node
- a probe is blocked by an unknown dependency
- you are about to claim the surface is exhausted

## Traces

- `asset-flows.md` — value in / out / custody / mint-burn-claim / attacker-controlled inputs.
- `trust-boundaries.md` — actors, permission traces, emergency/upgrade/migration paths, and composition pairings: "assume A, B, C are each correct; does A+B+C still hold?"

## Leads

Interesting thing mid-map → `research/leads.md` as `OBSERVED`. A construction that needs a missing node adds the node, then continues. Do not drop the node to keep the dive small.

## Done-enough vs done

- Done-enough for SYNTHESIS: thin map.
- Done for CAMPAIGN: graph has every known live node, traces cover the boundary classes, one composition pairing is written, deployment/invariants/assumptions/model exist.
