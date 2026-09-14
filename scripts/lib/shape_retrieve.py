#!/usr/bin/env python3
"""CLI for seam-tagged shape retrieval. Called by scripts/shape_retrieve.sh."""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

_LIB = Path(__file__).resolve().parent
if str(_LIB) not in sys.path:
    sys.path.insert(0, str(_LIB))

from shape_knowledge import render_pack, retrieve_shapes  # noqa: E402


def main(argv: list[str] | None = None) -> int:
    p = argparse.ArgumentParser(description="Retrieve a small seam-matched shape pack.")
    p.add_argument("--n", type=int, default=15)
    p.add_argument("--knowledge", type=Path, required=True)
    p.add_argument("--root", type=Path, required=True)
    p.add_argument("seams", nargs="+")
    args = p.parse_args(argv)
    try:
        cards, note = retrieve_shapes(
            args.seams,
            knowledge_dir=args.knowledge,
            repo_root=args.root,
            n=args.n,
        )
    except ValueError as exc:
        print(str(exc), file=sys.stderr)
        return 2
    sys.stdout.write(render_pack(cards, seams=args.seams, note=note))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
