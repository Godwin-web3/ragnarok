# Worked example — composition win

Synthetic target **TwinRail**: a vault that mints against an oracle, and a queue that later redeems against a different mark. Inspired by public vault↔oracle / mint↔settle splits. Not a disclosure of a live protocol.

This file shows a pairing CX invented **right after the thin map**, not during the late composition walk.

## Thin map

```
Component | Type | Address | Role | Trusts | Trusted by
Vault     | proxy | 0xAAA | mint shares | OracleMint, Token | Users
OracleMint| feed  | 0xBBB | mint mark | off-chain | Vault
Queue     | proxy | 0xCCC | redeem tickets | OracleSettle, Token | Users
OracleSettle | feed | 0xDDD | redeem mark | off-chain | Queue
Token     | ERC20 | 0xEEE | underlying | — | Vault, Queue
```

Trace: User -> vault.mint() -> OracleMint.spot(); later User -> queue.requestRedeem() -> OracleSettle.spot().

## CX-001 (first card, pairing)

```
STATE: shares minted at OracleMint = 200 AND same backing redeemed at OracleSettle = 100 AND both calls succeed
CONTRADICTION: mint mark and settle mark are supposed to be the same FACT (price of one token)
PAIRING: Vault ↔ Queue  (OracleMint vs OracleSettle)
CONSTRUCTION: mint while mint feed is high, requestRedeem while settle feed is low
SEQUENCE: poke mint feed → mint → poke settle feed → requestRedeem → settle
WITNESS: sharesMinted * mintPrice > collateralReleased * settlePrice
MONETIZATION: attacker token.balanceOf after settle exceeds token spent at mint
CHEAPEST FALSIFIER: eth_call OracleMint.latestRoundData vs OracleSettle.latestRoundData
FALSIFIER RESULT: two addresses, two updatedAt, no code path copies one into the other
HANDLERS: mint, requestRedeem, settle
INVARIANT HARNESS: research/experiments/CX001_invariant.t.sol
CLASS: EXTRACT
STATUS: REACHABLE
```

Late composition walk still ran. It found the same pairing plus rewards↔shares (no CX). The win was the **early** pairing card, not the walk.

What this example is for: after SYNTHESIS OPEN, invent a world where two components disagree. The late walk is coverage. It is not the start of imagination.
