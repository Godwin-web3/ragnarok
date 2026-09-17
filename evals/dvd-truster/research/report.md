# Ragnarok Finding Report

Target: DVD Truster (educational)

CX-001 CONFIRMED EXTRACT on a local harness.

`flashLoan` lets the pool execute arbitrary calldata. Approve is not a token outflow, so the repay check passes. `transferFrom` extracts the pool.

Eval score: PASS.
