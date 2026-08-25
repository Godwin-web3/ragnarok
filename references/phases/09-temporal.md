# PHASE 9 — Temporal & state-machine

For important machines `S0 → S1 → S2 → S3`:

- Can S2 be entered without S1?
- Can S1 be repeated?
- Can two users interact between transitions?
- Can external / governance / oracle state change between steps?
- Can a callback re-enter another transition?
- Can a failed transition partially alter state?
- Can an attacker force an unusual ordering?

Search for transient states developers assume are unreachable. Add hypotheses only for transitions you can cheaply falsify.
