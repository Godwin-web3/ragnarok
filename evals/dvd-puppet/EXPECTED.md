# Answer key — do not load during a hunt

## Pairing

Thin DEX spot (`pair.eth / pair.token`) ↔ borrow collateralization in the pool.

## Impossible state

Oracle price after a spot dump implies a tiny ETH deposit can borrow the entire pool, while the pool still holds 100_000 DVT as if the pre-dump price were real.

## Witness

After selling player DVT into the pair, `calculateDepositRequired(100_000 ether) <= player ETH`. Then `borrow` drains the pool.

## Class

EXTRACT.
