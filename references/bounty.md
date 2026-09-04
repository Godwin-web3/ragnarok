# Bounty intake and disclosure

Load this when the target has a public program (Immunefi, Sherlock, Cantina, HackenProof) or a private engagement.

Do not hunt a named class because the program page lists it. Hunt contradictions. Use this file so the work can be paid.

## Before the first line of code

Write these into `research/scope.md`:

- Program URL
- In-scope assets (addresses, repos, commit pins)
- Out-of-scope impacts
- Known issues / previously paid reports
- Primacy of Impact or Primacy of Rules
- PoC required (yes/no)
- KYC required for payout
- Safe Harbor active (yes/no/unknown)
- Max critical and how it is calculated (flat vs percent of funds at risk)
- Testing boundaries (fork only, public RPC, no mainnet writes)

If a path is out of scope, record it in `leads.md` as OBSERVED and leave it. Do not spend a week proving an excluded impact.

## What big means here

A first paid High is the goal of a first campaign.
A $15M ceiling is not a plan.
Prefer live mid-tier programs, fresh scope changes, and payment or settlement integrations over the most-hunted blue-chip cores.

## Novelty against the program

Before promoting CX to H:

1. Is this listed as a known issue?
2. Did a public audit already name this exact path at this commit?
3. Is the impact only admin-can-rug when admin is trusted by the program?

If yes, kill or bucket as PRIVILEGED RISK / DESIGN RISK. Do not put it in `report.md`.

## Report that a triage team can pay

`report.md` is internal-complete.
The submission to the platform is the same facts, shorter:

- Title that states the economic effect
- Impact in program language (direct theft, permanent freeze, unbacked mint)
- Pinned source revision and live addresses
- Preconditions that are DEPLOYMENT_VERIFIED
- Ordered attacker steps
- Fork PoC command and expected deltas
- Why known issues do not cover it
- Kill attempts and why it survived

No theory-only submissions.
No severity arguments before ECONOMICALLY_VERIFIED numbers.

## After submit

Do not publish.
Do not tweet a teaser.
Do not reuse the PoC against production.

Update `research/NOW.md` with the report id and the date. The hunt on that construction is paused until the program replies.
