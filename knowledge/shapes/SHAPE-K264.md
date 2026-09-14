# SHAPE-K264 — Signed bytes authorize a different execution context than the signer saw (stablecoin seam)

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: digest the signer hashed vs fields the contract actually executes
- SEAMS: `stablecoin`, `payments`, `bridge`, `privilege`
- CONSTRUCTION: Reuse, extend, or wrap a signature so nonce, chainid, verifyingContract, amount, or spender is not the executed one.
- WITNESS: executed fields != signed fields AND the call succeeds
- MONETIZATION / KILL: Spender drains under a signature meant for something else. Dies if the digest binds every executed field including chain and contract.
- PROVENANCE: Zaevlad/audit-findings-dataset; dataset ids 5315, 20738, 23471; severity Critical; PoC present: yes; cluster size 3. Distilled, not a report dump.
