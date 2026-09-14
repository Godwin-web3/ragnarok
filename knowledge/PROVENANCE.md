# Provenance and license

## Source

Shapes in this directory are **abstract distillations** of public contest/audit
findings from:

- Hugging Face dataset: [Zaevlad/audit-findings-dataset](https://huggingface.co/datasets/Zaevlad/audit-findings-dataset)
- Split: `data/train-00000-of-00001.parquet` (~23,625 rows)
- Dataset card license: `license: other`
- Dataset author: Zaevlad (Vlad)

The underlying write-ups appear to originate from third-party researchers on
public audit-contest platforms. Their license/authorship is unclear. The
dataset card says: treat as `license: other` until provenance is confirmed;
do not assume redistribution or commercial-use rights beyond what the original
platforms grant.

## What Ragnarok redistributes

Ragnarok **does not** vendor:

- raw `bug_desc` / `bug_full` / `bug_poc` / `bug_rec` text
- original report markdown
- the parquet or CSV

Each `SHAPE-K###` card stores only:

- an abstract state name (not a bug-class label)
- two representations of a fact
- seam tags
- a valid-action construction sketch
- a witness hint
- a monetization / kill note
- provenance: dataset row ids, severity, whether a PoC existed

That is defensive-research metadata for inventing worlds, not a report dump.

## Filter (v1)

Primary set: `bug_sev` in {Critical, High} **and** a real PoC.

Optional: Medium if `bug_weight` is high (default ≥ 0.7) **and** a real PoC.

Dropped from the primary shape set: Gas Optimization, Informational, Unknown,
Other, Low, placeholder PoCs (`no poc`, `N/A`, `No data`, empty, URL-only,
very short non-code text).

Near-duplicate descriptions are collapsed before clustering.

## Intended use

Defensive security research inside the Ragnarok methodology. Shapes feed
imagination **by seam**. They are not training labels for a vulnerability
classifier and not a LazyAudit retrieval index.
