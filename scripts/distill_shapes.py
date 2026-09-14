#!/usr/bin/env python3
"""Distill Zaevlad/audit-findings-dataset into abstract Ragnarok STATE shapes.

Past findings are fuel for inventing worlds. This script never writes a
bug-class checklist and never dumps raw reports into knowledge/.

Usage:
  python3 scripts/distill_shapes.py --download --out knowledge
  python3 scripts/distill_shapes.py --parquet /path/to/train.parquet --out knowledge
"""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
LIB = HERE / "lib"
if str(LIB) not in sys.path:
    sys.path.insert(0, str(LIB))

from shape_knowledge import (  # noqa: E402
    DATASET_PARQUET_URL,
    DATASET_REPO,
    DEFAULT_MAX_SHAPES,
    MEDIUM_WEIGHT_FLOOR,
    distill,
    download_parquet,
    load_parquet_rows,
    write_knowledge,
)


def repo_root() -> Path:
    return HERE.parent


def main(argv: list[str] | None = None) -> int:
    p = argparse.ArgumentParser(
        description="Distill public audit findings into abstract STATE shapes."
    )
    p.add_argument(
        "--parquet",
        type=Path,
        help="Local parquet path (Zaevlad/audit-findings-dataset train split).",
    )
    p.add_argument(
        "--download",
        action="store_true",
        help=f"Download {DATASET_REPO} parquet if --parquet is missing.",
    )
    p.add_argument(
        "--cache-dir",
        type=Path,
        default=HERE / ".cache",
        help="Where to store the downloaded parquet (not committed).",
    )
    p.add_argument(
        "--out",
        type=Path,
        default=repo_root() / "knowledge",
        help="Output directory for shapes.jsonl, index, and markdown cards.",
    )
    p.add_argument("--max-shapes", type=int, default=DEFAULT_MAX_SHAPES)
    p.add_argument(
        "--include-medium",
        action=argparse.BooleanOptionalAction,
        default=True,
        help="Keep Medium rows with real PoC and high bug_weight (default: on).",
    )
    p.add_argument("--medium-weight-floor", type=float, default=MEDIUM_WEIGHT_FLOOR)
    p.add_argument(
        "--dry-run",
        action="store_true",
        help="Filter and cluster, print stats, do not write knowledge/.",
    )
    args = p.parse_args(argv)

    parquet = args.parquet
    if parquet is None:
        parquet = args.cache_dir / "train-00000-of-00001.parquet"
        if not parquet.is_file():
            if not args.download:
                print(
                    "No --parquet given and cache is empty. Pass --download "
                    f"to fetch {DATASET_PARQUET_URL}",
                    file=sys.stderr,
                )
                return 2
            print(f"Downloading {DATASET_REPO} → {parquet}")
            download_parquet(parquet)
    elif not parquet.is_file():
        if args.download:
            print(f"Downloading {DATASET_REPO} → {parquet}")
            download_parquet(parquet)
        else:
            print(f"parquet not found: {parquet}", file=sys.stderr)
            return 2

    print(f"Reading {parquet}")
    rows = load_parquet_rows(parquet)
    print(f"Rows: {len(rows)}")
    cards, stats = distill(
        rows,
        max_shapes=args.max_shapes,
        include_medium=args.include_medium,
        medium_weight_floor=args.medium_weight_floor,
    )
    print("Filter / cluster stats:")
    print(json.dumps(stats, indent=2, sort_keys=True))
    print(f"Distinct shapes: {len(cards)}")
    if args.dry_run:
        print("Dry run: not writing knowledge/")
        return 0
    write_knowledge(cards, args.out, stats=stats)
    print(f"Wrote {len(cards)} shapes under {args.out}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
