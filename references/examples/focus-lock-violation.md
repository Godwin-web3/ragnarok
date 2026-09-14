# Worked example — focus-lock violation (what NOT to do)

Synthetic target **ScatterFarm**. Not a disclosure of a live protocol.

This file is a negative example. If your disk looks like this, `gate_check` must fail.

## Illegal NOW.md

```
Phase: 6
Gate: OPEN
Focus lock: live 5/2, probes 3/1   # already illegal
Queue: CX-001, CX-002, CX-003, CX-004, CX-005 all INVENTED
Open probes: none recorded — "will fuzz later"
```

## Illegal contradictions.md (excerpt)

```
CX-001 STATUS INVENTED  WITNESS: vault looks wrong
CX-002 STATUS PROBING   FALSIFIER RESULT: unrecorded
CX-003 STATUS PROBING   FALSIFIER RESULT: unrecorded
CX-004 STATUS INVENTED  PAIRING: (missing)
CX-005 STATUS REACHABLE HANDLERS: (missing)  INVARIANT HARNESS: (missing)
```

## What the gate must say

```
Focus lock: VIOLATION  live 5/2  probes 2/1  unresolved 2
- FOCUS LOCK: 5 live CX cards (max 2)
- FOCUS LOCK: 2 open probes (max 1)
- FOCUS LOCK: unresolved probe blocks inventing another live CX
- CX-001: WITNESS is not assertable — card stays INVENTED
- CX-005: REACHABLE requires INVARIANT HARNESS or HANDLERS
- COMPOSITION: at least one CX must name a PAIRING of two components
```

Exit 3. Do not invent CX-006. Do not write report.md.

## The legal repair

Kill or unreach CX-003/004/005 (or never write them). Keep two live cards. One of them is a pairing. One probe. Record `FALSIFIER RESULT` before the next invention. Replace "vault looks wrong" with `token.balanceOf(vault) < convertToAssets(totalSupply)`.

What this example is for: breadth without a recorded falsifier is architecture fiction. Focus lock exists so a live hunt produces paid bugs instead of a wiki.
