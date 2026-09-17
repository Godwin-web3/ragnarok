# Scope

## Authorization & research environment (PHASE 0 — REQUIRED)
- Authorization status: NONE
- Research environment: LOCAL_FORK
- Live exploitation permitted: NO

## Authorization
- Bounty / engagement: Damn Vulnerable DeFi Unstoppable (educational)
- Reference / link: https://github.com/theredguild/damn-vulnerable-defi
- Date confirmed: 2026-09-17

## Target
- Repository: theredguild/damn-vulnerable-defi
- Commit / version (pin): master / latest public Unstoppable sources
- Local checkout path: evals/dvd-unstoppable

## Bounty scope
- In-scope assets: UnstoppableVault, UnstoppableMonitor, DVT token as used by the challenge
- Out-of-scope: other DVD challenges, mainnet, live protocols
- Testing boundaries: local Foundry / challenge test harness only

## Prior scrutiny
- Known: public CTF. Answer key lives in EXPECTED.md and must not be used as hunt input.

## Deployment
- Chains: local
- Deployed addresses: challenge setup
- Assets at risk: 1_000_000 DVT inside the vault (flash-loan availability)

## Infrastructure
- Test harness: DVD Foundry tests for Unstoppable
