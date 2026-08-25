# PHASE 8 — Cross-contract composition (graph walk)

Assume A is correct, B is correct, C is correct. Can A+B+C still violate a protocol invariant?

Walk pairings on the **existing map**. Do not rebuild architecture. Do not drop nodes.

Priority pairings: accounting↔oracle, oracle↔liquidation, liquidation↔redemption, rewards↔shares, token↔vault, governance↔positions, upgrade↔storage, callback↔auth, external protocol↔solvency, config↔existing state.

If a pairing names a node not yet dived, **grow the cut-set** and dive that node. That is expansion, not scope creep.

`final.md` must later state which pairings were traced and which were not.
