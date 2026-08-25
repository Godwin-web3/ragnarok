# PHASE 1 — Wide map + schematic traces

Do not start with vulnerability scanning. Do not write a novel.

## Map (must be complete, must be shallow)

Build `research/architecture.md` as a **graph**:

```
Component | Type | Address | Role | Trusts | Trusted by
```

Include every live contract, proxy, impl, factory, clone, library, token, oracle, keeper, governance, admin, external protocol, bridge, hook, strategy.

Derive what you can from ABI, storage layout, compiler artifacts, deployment JSON. Annotate what tools cannot see.

Every address that later appears in `deployment.md` must already be a node, or you add it now.

## Traces (schematic, system-wide)

- `asset-flows.md` — value in / out / custody / mint-burn-claim / attacker-controlled inputs.
- `trust-boundaries.md` — actors, permission traces, emergency/upgrade/migration paths, **and at least one real composition trace**: "assume A, B, C are each correct; does A+B+C still hold the invariant?"

Capability levels stay distinct: source-could / deployed-does / attacker-can-profit.

## Leads

Interesting thing mid-map → `research/leads.md` as `OBSERVED`. Do not dive. Do not run experiments. Continue the map.

A lead that names a component not yet on the graph means the map is incomplete — add the node first.

## Done when

Graph has every known live node, traces cover the boundary classes, one composition pairing is written down, `NOW.md` lists unmapped/UNVERIFIED explicitly.
