# PHASE 9 — Cross-contract composition (graph walk)

Assume A is correct, B is correct, C is correct. Can A+B+C still violate a protocol invariant?

This walk is **late and still required**. It is not when you start inventing pairing CX cards.

After SYNTHESIS OPEN you already invented at least one CX whose `PAIRING` names two components. Keep that card. This phase walks the rest of the pairings on the **existing map**.

Do not rebuild architecture. Do not drop nodes.

Priority pairings: accounting↔oracle, oracle↔liquidation, liquidation↔redemption, rewards↔shares, token↔vault, governance↔positions, upgrade↔storage, callback↔auth, external protocol↔solvency, config↔existing state, queue↔settlement, message↔mint.

If a pairing names a node not yet dived, **grow the cut-set** and dive that node. That is expansion, not scope creep. Growing the map reopens `killed.md` (see `references/kill.md`).

`final.md` must later state which pairings were traced and which were not.

`scripts/gate_check.sh` already failed you if you wrote CX cards with no pairing. Do not "save composition for later" as an excuse to write only single-component cards.
