#!/usr/bin/env bash
# Seam-matched shape retrieval for Ragnarok (V5.1 knowledge layer).
#
# After SYNTHESIS OPEN, pass the current seam tags from the thin map.
# Prints a SMALL pack (default 15) of abstract STATE generators.
#
# This is NOT LazyAudit. It does not take a code description. It does not
# rank "similar known bugs". It filters a curated shape corpus by seam tag.
#
# Usage:
#   scripts/shape_retrieve.sh vault oracle
#   scripts/shape_retrieve.sh --n 12 vault
#   scripts/shape_retrieve.sh --knowledge /tmp/empty vault
#
# Exit 0 on success, 2 on usage error.
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$HERE/.." && pwd)"
N=15
KNOWLEDGE="$ROOT/knowledge"

SEAMS=()
while [ "$#" -gt 0 ]; do
  case "$1" in
    --n)
      N="${2:-}"
      shift 2
      ;;
    --knowledge)
      KNOWLEDGE="${2:-}"
      shift 2
      ;;
    --root)
      ROOT="${2:-}"
      shift 2
      ;;
    -h|--help)
      sed -n '2,20p' "$0"
      exit 0
      ;;
    --)
      shift
      SEAMS+=("$@")
      break
      ;;
    -*)
      echo "unknown flag: $1" >&2
      exit 2
      ;;
    *)
      SEAMS+=("$1")
      shift
      ;;
  esac
done

if [ "${#SEAMS[@]}" -eq 0 ]; then
  echo "usage: scripts/shape_retrieve.sh [--n 15] [--knowledge DIR] <seam> [seam...]" >&2
  echo "canonical seams: vault stablecoin payments bridge oracle privilege lending amm staking nft signature callback accounting" >&2
  exit 2
fi

export RAGNAROK_ROOT="$ROOT"
export RAGNAROK_KNOWLEDGE="$KNOWLEDGE"
export RAGNAROK_RETRIEVE_N="$N"
# Pass seams as separate args after --
python3 "$HERE/lib/shape_retrieve.py" --n "$N" --knowledge "$KNOWLEDGE" --root "$ROOT" -- "${SEAMS[@]}"
