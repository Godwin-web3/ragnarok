# Worked example — density calibration

Synthetic target **HearthVault**: an ERC-4626-style vault that mints shares against `totalAssets()` reported by a spot oracle. Inspired by the public donation / inflation class plus stale-oracle composition. Not a disclosure of a live protocol.

This file shows how dense artifacts should be. Copy the shape, not the sentences.

## NOW.md (excerpt)

```
Phase: 7
Gate: OPEN
Env: LOCAL_FORK
Pin: hearth/hearth-vault@4f2c1aa
Adapter: evm
Map: Vault 0xAAA (proxy), Impl 0xA11, Oracle 0xBBB, Token 0xCCC, Owner 0xDDD
Seam: Vault+Oracle mint path
Queue: 1. cheapest falsifier H-001  2. scenario H-001  3. expand to redeem
Open: H-001 P1 cheapest=oracle.updatedAt
```

## Component graph

```
Component | Type | Address | Role | Trusts | Trusted by
Vault     | proxy | 0xAAA | custody + shares | Impl, Oracle, Token | Users
Oracle    | feed  | 0xBBB | spot price | off-chain source | Vault
Token     | ERC20 | 0xCCC | underlying | — | Vault, Users
Owner     | msig  | 0xDDD | upgrade + pause | — | Vault
```

## Composition trace

```
Pairing        | Trace                                      | Invariant at risk
Vault + Oracle | deposit() → totalAssets() → oracle.spot()  | INV-001 share value monotonic
Vault + Token  | token.transfer on donate, no share mint    | INV-001
```

## Protocol model (excerpt)

```
ACT-001 Lender — Critical yes — PROM-001
PROM-001 Shares redeemable for underlying
  conditions: ASM-001
  accounting: INV-001
  transitions: ST-001 deposit→mint, ST-002 withdraw→burn
  attacker influence: donate token then mint
  falsification plan: eth_call convertToShares(1) after 1-wei donate
ST-001 Who can trigger: any token holder
```

## H-001 (ranked)

```
RANK P1 | permissionless yes | ACTIVE yes | capital 1 wei + 1 donation
cheapest falsifier: eth_call oracle.updatedAt and convertToShares(1)
```

What this example is for: if your `architecture.md` is three pages of prose and your hypothesis has no RANK or cheapest falsifier, you are off calibration.
