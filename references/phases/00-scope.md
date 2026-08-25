# PHASE 0 — Target validation & environment

Write `research/scope.md` from the template. Resolve every enum to a single value.

1. Pin identity: repo + commit, chains, addresses (proxies, impls, factories, tokens, oracles, keepers, admins), RPC, harness.
2. Classify: Authorization `UNKNOWN / NONE / CONFIRMED`. Env `READ_ONLY_PRODUCTION / LOCAL_FORK / AUTHORIZED_LIVE`. Live writes `YES / NO`. Default: UNKNOWN / READ_ONLY_PRODUCTION / NO.
3. Catalog prior scrutiny (audits, Known Issues, prior disclosures). This is a novelty prior, never a skip.
4. Production writes are forbidden unless AUTHORIZED_LIVE says otherwise.

Rewrite `research/NOW.md` with pin, env, and next action = Phase 1 map.
