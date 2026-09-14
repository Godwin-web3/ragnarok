# Knowledge layer (V5.1)

Abstract STATE shapes distilled from public audit/contest findings.

This directory is **fuel for inventing worlds**, not a checklist of bugs to tick.

## Doctrine

- The unit of reasoning remains the impossible state / CX card.
- After SYNTHESIS OPEN, load **only** a small seam-matched pack (≈10–20 shapes).
- Never load this corpus wholesale into a hunt.
- Never load raw findings (`bug_desc` / `bug_full` / PoC source) during a hunt.
- Never retrieve by “describe the code → similar known bug titles.”
- A retrieved shape is not a finding. Evidence ladder: CX → witness → harness → kill.

## Hunt path

```bash
# seams come from the thin map / current dive, not from a bug-class guess
scripts/shape_retrieve.sh vault oracle
# default N=15
scripts/shape_retrieve.sh --n 12 bridge payments
```

Then invent CX cards with the same generator Ragnarok already uses:

> What state can I create that the designers never modeled?
> Where do two components have different realities about the same fact?

Wrong generator: “which of these shapes is present in the code?”

Focus lock still applies. A pack of 15 shapes does not authorize 15 live CX cards.

## Layout

| Path | Role |
| :--- | :--- |
| `shapes.jsonl` | Source of truth (machine) |
| `seams.json` | Shape ids by seam tag |
| `index.md` | Human index |
| `shapes/SHAPE-K###.md` | One abstract card each |
| `by-seam/<seam>.md` | Browse files. Do **not** load wholesale on a hunt; use `shape_retrieve.sh` |
| `PROVENANCE.md` | Dataset, license, what we refuse to redistribute |

Hand-written calibration shapes stay in `references/shapes.md` (SHAPE-01…30). Retrieval mixes a few of those with seam-matched distilled shapes.

## Rebuild

Raw parquet is **not** committed (license: other; do not redistribute reports).

```bash
pip install -r scripts/requirements-distill.txt
python3 scripts/distill_shapes.py --download --out knowledge
```

Or pass a local file:

```bash
python3 scripts/distill_shapes.py --parquet data/train-00000-of-00001.parquet --out knowledge
```

The distiller filters hard (Critical/High, optional high-weight Medium, real PoC, dedup), abstracts into state language, and clusters to hundreds of distinct shapes — not 23k files.

v1 seed (this tree): 23,625 rows → 1,864 kept (real PoC + C/H or high-weight Medium) → **282** clustered shapes. 59 Critical / 198 High / 25 Medium. Rebuild to refresh.
