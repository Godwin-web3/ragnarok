# PHASE 4 — Assumption mining

The question is not only "what vulnerability exists?" It is **"what does the protocol assume will never happen?"**

Mine from requires, comments, formulas, transitions, oracle/token interfaces, external calls, config, governance, upgrades, accounting, scripts, tests, docs.

Each `ASM-###`:

```
ASSUMPTION → TRUSTED BY → INFLUENCEABLE BY → FAILURE CONDITION → POSSIBLE CONSEQUENCE → ATTACK SURFACE
```

Plus **PROVENANCE** and **CONFIDENCE**. Missing provenance fails the gate.

Prioritize assumptions that cross boundaries: contract→contract, oracle→source, accounting→token, liquidation→freshness, redemption→rate, market→market, protocol→external liquidity.

Leads discovered here go to `leads.md` as `OBSERVED`. Reasoning-only closures are `SELF_RESOLVED`, not `FALSIFIED`.

This phase is part of the hypothesis gate. Do not skip it because the map felt finished.

Phase 5 will link these `ASM-###` ids from `protocol-model.md`. Do not copy the assumption text into the model.
