# SHAPE-K262 — Signed bytes authorize a different execution context than the signer saw (privilege seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: digest the signer hashed vs fields the contract actually executes
- SEAMS: `privilege`, `signature`, `nft`, `callback`
- CONSTRUCTION: Reuse, extend, or wrap a signature so nonce, chainid, verifyingContract, amount, or spender is not the executed one.
- WITNESS: executed fields != signed fields AND the call succeeds
- MONETIZATION / KILL: Spender drains under a signature meant for something else. Dies if the digest binds every executed field including chain and contract.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 1593, 2889, 18655, 20663, 20748, 21850, 23374; severity Critical; PoC present: yes; cluster size 7. Distilled, not a report dump.
