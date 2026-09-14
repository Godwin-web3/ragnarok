# Worked example — invent → probe → survive → monetize → confirm

Synthetic target **HearthVault** (same family as `donation-inflation.md`). Not a disclosure of a live protocol.

This file shows a card that earns CONFIRMED. Copy the shape, not the sentences.

## NOW.md (excerpt)

```
Phase: 10
Gate: OPEN
Focus lock: live 1/2, probes 0/1, unresolved 0
Env: LOCAL_FORK
Pin: hearth/hearth-vault@4f2c1aa
Adapter: evm
Seam: Vault+Oracle mint path
Open: CX-001 REACHABLE → H-001 P1 CLASS EXTRACT
```

## CX-001

```
STATE: totalSupply unchanged after a raw donation AND convertToShares(1) cheaper than before AND attacker can mint
CONTRADICTION: share ledger did not mint, asset ledger increased, next minter owns more of the pot
PAIRING: Vault ↔ Token
CONSTRUCTION: token.transfer(vault, donation); vault.deposit(1)
SEQUENCE: donate → mint → redeem
WITNESS: convertToShares(1 ether) < preDonateSharesForOne AND token.balanceOf(attacker) > start + 1 ether - donation
MONETIZATION: attacker.balanceOf(token) increases by victim deposits
CHEAPEST FALSIFIER: eth_call convertToShares(1 ether) before/after a 1-wei donation
FALSIFIER RESULT: shares-for-1 dropped from 1e18 to 1 after 1-wei donate on empty-ish vault
HANDLERS: deposit, mint, withdraw, redeem
INVARIANT HARNESS: research/experiments/CX001_invariant.t.sol
CLASS: EXTRACT
STATUS: REACHABLE
```

## Probe survived

```
cast call $VAULT "convertToShares(uint256)(uint256)" 1000000000000000000 --rpc-url $RPC
# after deal(token, attacker, 1); token.transfer(vault, 1)
# result changed. WITNESS compiles. harness_init --cx CX-001 wrote asserts.
```

Invariant fuzzer (`handler_deposit` / `handler_withdraw`) hit the same WITNESS in 40 depth. Sequence copied into Campaign.t.sol.

## Monetize + economics

```
ATTACKER BEFORE 1 wei + 1 donation token
ATTACKER AFTER  99 victim tokens
FLASHLOANABLE / CAPITAL: donation is attacker inventory; 1 wei mint is dust; same-tx flashloan yes
SAME-TX ATOMICITY: donate+mint+redeem in one tx, profit survives
EXIT LIQUIDITY: vault holds victim deposit, withdraw pays token
MEV / KEEPER RACE: permissionless, no keeper; sandwich risk is the attacker
CLASS: EXTRACT
```

## Kill attempts (failed)

Empty-vault virtual offset absent. onlyOwner donate unused (raw ERC-20 transfer works). Heartbeat on mint absent.

```
H-001 CONFIRMED
RUNTIME_VERIFIED + ECONOMICALLY_VERIFIED
CLASS EXTRACT
```

What this example is for: REACHABLE is not enough. Value must move, the class must be EXTRACT, and the kill attempt must be on disk. Then — and only then — report.md may exist.
