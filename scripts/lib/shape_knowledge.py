#!/usr/bin/env python3
"""Ragnarok knowledge-layer primitives.

Past findings are FUEL for inventing worlds. This module:

- filters a public audit-finding table for quality
- abstracts each kept row into a state SHAPE (not a bug class)
- clusters near-duplicate shapes
- retrieves a small seam-matched pack

It never implements LazyAudit-style retrieval (describe code → similar
known bug titles → "is this like that?"). Retrieval is by seam tag only.
"""

from __future__ import annotations

import hashlib
import json
import re
import sys
import urllib.request
from dataclasses import asdict, dataclass, field
from pathlib import Path
from typing import Iterable, Mapping, Sequence

_LIB = Path(__file__).resolve().parent
if str(_LIB) not in sys.path:
    sys.path.insert(0, str(_LIB))

from shape_families import FALLBACK_FAMILY, FAMILIES, Family  # noqa: E402

DATASET_REPO = "Zaevlad/audit-findings-dataset"
DATASET_PARQUET_URL = (
    "https://huggingface.co/datasets/Zaevlad/audit-findings-dataset"
    "/resolve/main/data/train-00000-of-00001.parquet"
)
DEFAULT_MAX_SHAPES = 350
DEFAULT_RETRIEVE_N = 15
MEDIUM_WEIGHT_FLOOR = 0.7
MIN_POC_CHARS = 80
MIN_DESC_CHARS = 40
NEAR_DUP_PREFIX = 300
JACCARD_MERGE = 0.42
PROVENANCE_ID_CAP = 12

PRIMARY_SEV = frozenset({"Critical", "High"})
MEDIUM_SEV = "Medium"
NOISE_SEV = frozenset(
    {"Gas Optimization", "Informational", "Unknown", "Other", "Low"}
)
SEV_RANK = {"Critical": 0, "High": 1, "Medium": 2, "Low": 3}

CANONICAL_SEAMS: tuple[str, ...] = (
    "vault",
    "stablecoin",
    "payments",
    "bridge",
    "oracle",
    "privilege",
    "lending",
    "amm",
    "staking",
    "nft",
    "signature",
    "callback",
    "accounting",
)

# Hand-written calibration shapes in references/shapes.md. Not a scanner list.
HAND_SHAPE_SEAMS: dict[str, tuple[str, ...]] = {
    "SHAPE-01": ("vault", "accounting"),
    "SHAPE-02": ("payments", "vault"),
    "SHAPE-03": ("payments", "privilege", "signature"),
    "SHAPE-04": ("accounting",),
    "SHAPE-05": ("payments", "vault", "stablecoin"),
    "SHAPE-06": ("payments", "vault"),
    "SHAPE-07": ("privilege", "payments", "nft"),
    "SHAPE-08": ("oracle", "stablecoin", "lending"),
    "SHAPE-09": ("vault", "accounting"),
    "SHAPE-10": ("payments", "vault", "stablecoin"),
    "SHAPE-11": ("vault", "payments", "lending"),
    "SHAPE-12": ("stablecoin", "bridge", "vault"),
    "SHAPE-13": ("bridge",),
    "SHAPE-14": ("payments", "bridge"),
    "SHAPE-15": ("vault", "staking"),
    "SHAPE-16": ("privilege",),
    "SHAPE-17": ("privilege",),
    "SHAPE-18": ("vault", "accounting"),
    "SHAPE-19": ("payments", "oracle", "callback"),
    "SHAPE-20": ("vault",),
    "SHAPE-21": ("vault", "amm"),
    "SHAPE-22": ("oracle", "lending", "amm"),
    "SHAPE-23": ("privilege", "oracle"),
    "SHAPE-24": ("privilege", "vault"),
    "SHAPE-25": ("bridge", "privilege", "signature"),
    "SHAPE-26": ("payments", "amm"),
    "SHAPE-27": ("payments",),
    "SHAPE-28": ("accounting", "callback"),
    "SHAPE-29": ("oracle", "payments", "lending"),
    "SHAPE-30": ("payments", "privilege", "lending"),
}

PLACEHOLDER_POC_RE = re.compile(
    r"^\s*("
    r"no\s*poc\.?"
    r"|n/?a"
    r"|n\.a\.?"
    r"|no\s*data"
    r"|none"
    r"|nil"
    r"|null"
    r"|not\s*provided"
    r"|information\s+not\s+provided"
    r"|no\s*proof"
    r"|no\s*recommendation"
    r"|tba"
    r"|tbd"
    r"|-+"
    r"|—+"
    r"|n/a"
    r")\s*$",
    re.IGNORECASE,
)

CODE_POC_RE = re.compile(
    r"(pragma\s+solidity|function\s+\w+|contract\s+\w+|library\s+\w+"
    r"|assert(True|Eq|Gt|Lt|Ge|Le|False)?"
    r"|expectRevert|\bvm\.|forge-std|```|call\{"
    r"|transfer\(|deposit\(|withdraw\(|mint\(|burn\(|liquidate\()"
    r"|bytes32\s+|uint256\s+|msg\.sender",
    re.IGNORECASE,
)

SUBMITTED_BY_RE = re.compile(
    r"(submitted by|reported by|also found by)[^\n|]{0,80}",
    re.IGNORECASE,
)

IDENT_CALL_RE = re.compile(r"\b([a-zA-Z_][a-zA-Z0-9_]{2,48})\s*\(")
TOKEN_RE = re.compile(r"[a-z0-9]{3,}")

STOP_FUNCS = frozenset(
    {
        "if",
        "for",
        "while",
        "require",
        "assert",
        "revert",
        "return",
        "emit",
        "new",
        "super",
        "this",
        "catch",
        "try",
        "pragma",
        "function",
        "contract",
        "modifier",
        "event",
        "struct",
        "mapping",
        "console",
        "log",
        "test",
        "setUp",
        "vm",
        "expectRevert",
        "prank",
        "startPrank",
        "deal",
        "warp",
        "roll",
        "label",
        "encode",
        "decode",
        "abi",
        "type",
        "string",
        "bytes",
        "uint",
        "int",
        "bool",
        "address",
        "true",
        "false",
        "memory",
        "storage",
        "calldata",
        "public",
        "external",
        "internal",
        "private",
        "view",
        "pure",
        "override",
        "virtual",
        "returns",
        "uint256",
        "uint128",
        "uint64",
        "uint32",
        "int256",
        "bytes32",
        "address",
        "stopprank",
        "startprank",
        "loadfixture",
        "vmprank",
        "deal",
        "warp",
        "roll",
        "label",
        "snapshot",
        "revertto",
        "expectemit",
        "asserttrue",
        "asserteq",
        "assertgt",
        "assertlt",
        "console2",
        "from",
        "only",
        "async",
        "await",
        "connect",
        "wait",
        "then",
        "background",
        "newint",
        "newcoin",
        "getandfundtestusers",
        "divdown",
        "divup",
        "muldown",
        "mulup",
    }
)

PROTOCOL_ACTIONS = frozenset(
    {
        "deposit",
        "withdraw",
        "mint",
        "burn",
        "borrow",
        "repay",
        "liquidate",
        "swap",
        "harvest",
        "redeem",
        "claim",
        "stake",
        "unstake",
        "transfer",
        "transferfrom",
        "approve",
        "permit",
        "settle",
        "execute",
        "fill",
        "cancel",
        "refund",
        "donate",
        "notify",
        "flashloan",
        "liquidateborrow",
        "rebalance",
        "unwrap",
        "wrap",
        "bridge",
        "lock",
        "unlock",
        "initialize",
        "upgrade",
        "pause",
        "unpause",
        "queue",
        "complete",
        "request",
        "fulfill",
        "bid",
        "ask",
        "liquidateposition",
        "open",
        "close",
        "addliquidity",
        "removeliquidity",
        "skim",
        "sync",
        "previewdeposit",
        "previewredeem",
        "converttoshares",
        "converttoassets",
    }
)

BANNED_NAME_RE = re.compile(
    r"\b("
    r"reentrancy|reentrant|overflow|underflow|swc-?\d*|cwe-?\d*"
    r"|access\s*control|oracle\s*manipulation|flash\s*loan\s*attack"
    r"|front-?running|sandwich\s*attack|rounding\s*bug"
    r"|check\s+for|vulnerability\s+class"
    r")\b",
    re.IGNORECASE,
)

BANNED_REPLACEMENTS: tuple[tuple[re.Pattern[str], str], ...] = (
    (re.compile(r"\breentrancy\b", re.I), "a callback between check and settlement"),
    (re.compile(r"\breentrant\b", re.I), "callback-capable"),
    (re.compile(r"\boracle manipulation\b", re.I), "a mark one path honors and another does not"),
    (re.compile(r"\bflash ?loan attack\b", re.I), "same-transaction capital that reprices a mark"),
    (re.compile(r"\baccess control\b", re.I), "authorization in one world and execution in another"),
    (re.compile(r"\b(overflow|underflow)\b", re.I), "two widths of the same quantity disagree"),
    (re.compile(r"\brounding bugs?\b", re.I), "rounding that breaks conservation"),
    (re.compile(r"\bfront-?runn?(ing|er)?\b", re.I), "force-ordering a keeper settle"),
)

SEAM_CUES: dict[str, tuple[str, ...]] = {
    "vault": (
        r"\berc-?4626\b",
        r"\bvault\b",
        r"convertto(shares|assets)",
        r"totalassets",
        r"share price",
        r"pricepershare",
        r"\bshares?\b",
        r"deposit.*withdraw",
    ),
    "stablecoin": (
        r"stablecoin",
        r"\busdc\b|\busdt\b|\bdai\b|\bfrax\b",
        r"mint.*redeem",
        r"collateralized.?debt|\bcdp\b",
        r"\bbacking\b",
        r"\bpeg\b",
    ),
    "payments": (
        r"\bpayment\b",
        r"\bsettle(ment)?\b",
        r"\bescrow\b",
        r"\bintent\b",
        r"\breceipt\b",
        r"\brefund\b",
        r"\border\b",
        r"\binvoice\b",
    ),
    "bridge": (
        r"\bbridge\b",
        r"cross-?chain",
        r"layerzero|\blz\b",
        r"anycall",
        r"message.?passing",
        r"lock.?mint|burn.?unlock",
        r"\bunwrap\b",
        r"\brelayer\b",
    ),
    "oracle": (
        r"\boracle\b",
        r"\btwap\b",
        r"chainlink",
        r"price.?feed",
        r"spot price",
        r"stale (price|round)",
        r"heartbeat",
    ),
    "privilege": (
        r"\bupgrade\b",
        r"\bproxy\b",
        r"initializ",
        r"\bowner\b|\bonlyowner\b",
        r"\badmin\b",
        r"\bpause",
        r"\bguardian\b",
        r"access.?control",
        r"\broles?\b",
    ),
    "lending": (
        r"\bborrow\b",
        r"\bliquida",
        r"collateral.?factor|\bltv\b",
        r"debt.?token",
        r"health factor",
        r"\baave\b|\bcompound\b",
    ),
    "amm": (
        r"\bamm\b",
        r"uniswap|balancer|curve",
        r"\bpool\b",
        r"\bswap\b",
        r"\bliquidity\b",
        r"\btick\b",
        r"\blp\b",
        r"\bhook\b",
    ),
    "staking": (
        r"\bstak(e|ing|ed)\b",
        r"notifyreward",
        r"\bgauge\b",
        r"reward(per|.?index|pertoken)",
        r"\bemissions?\b",
    ),
    "nft": (
        r"\bnft\b",
        r"erc-?721",
        r"erc-?1155",
        r"tokenid",
        r"\brental\b",
        r"seaport",
    ),
    "signature": (
        r"\bsignature\b",
        r"eip-?712",
        r"\bpermit\b",
        r"ecrecover",
        r"\bdigest\b",
        r"typed.?data",
    ),
    "callback": (
        r"\bcallback\b",
        r"oner[cC]721|oner[cC]1155",
        r"reentran",
        r"fallback handler",
        r"checks.?effects",
    ),
    "accounting": (
        r"\bledger\b",
        r"\baccounting\b",
        r"totalsupply",
        r"conservation",
        r"double.?count",
        r"inconsistent (balanc|account|share|debt)",
    ),
}

SEAM_CUE_RE: dict[str, tuple[re.Pattern[str], ...]] = {
    seam: tuple(re.compile(p, re.IGNORECASE) for p in pats)
    for seam, pats in SEAM_CUES.items()
}

FAMILY_CUE_RE: dict[str, tuple[re.Pattern[str], ...]] = {
    fam.fid: tuple(re.compile(p, re.IGNORECASE) for p in fam.cues)
    for fam in FAMILIES
}


@dataclass
class FindingRow:
    dataset_id: int
    title: str
    desc: str
    poc: str
    full: str
    severity: str
    weight: float
    file_name: str = ""


@dataclass
class Abstracted:
    dataset_id: int
    severity: str
    weight: float
    poc_present: bool
    family: Family
    seams: tuple[str, ...]
    actions: tuple[str, ...]
    tokens: frozenset[str]
    fact_a: str
    fact_b: str
    construction: str
    witness: str
    monetize_kill: str
    name: str


@dataclass
class ShapeCard:
    shape_id: str
    name: str
    fact_a: str
    fact_b: str
    seams: list[str]
    construction: str
    witness: str
    monetize_kill: str
    provenance_ids: list[int]
    severity: str
    poc_present: bool
    member_count: int
    family_id: str
    source: str = "knowledge"
    calibration: bool = False


def _norm_space(text: str) -> str:
    return re.sub(r"\s+", " ", (text or "").strip())


def normalize_desc(text: str) -> str:
    s = SUBMITTED_BY_RE.sub(" ", text or "")
    s = s.lower()
    s = re.sub(r"[`*_#>-]+", " ", s)
    s = _norm_space(s)
    return s


def is_real_poc(poc: str | None) -> bool:
    """Reject placeholder / empty / URL-only / very short non-code PoCs."""
    s = (poc or "").strip()
    if not s or len(s) < MIN_POC_CHARS:
        return False
    if PLACEHOLDER_POC_RE.match(s):
        return False
    without_urls = _norm_space(re.sub(r"https?://\S+", " ", s))
    if len(without_urls) < 40 and not CODE_POC_RE.search(s):
        return False
    if CODE_POC_RE.search(s):
        return True
    if len(s) >= 400 and re.search(r"\b(step|attacker|exploit|call)\b", s, re.I):
        return True
    return False


def keep_finding(
    severity: str,
    weight: float,
    poc: str | None,
    desc: str | None = None,
    *,
    include_medium: bool = True,
    medium_weight_floor: float = MEDIUM_WEIGHT_FLOOR,
) -> bool:
    sev = (severity or "").strip()
    if sev in NOISE_SEV:
        return False
    if not is_real_poc(poc):
        return False
    if desc is not None and len(_norm_space(desc)) < MIN_DESC_CHARS:
        return False
    if sev in PRIMARY_SEV:
        return True
    if include_medium and sev == MEDIUM_SEV:
        try:
            w = float(weight)
        except (TypeError, ValueError):
            return False
        return w >= medium_weight_floor
    return False


def blob_of(row: FindingRow) -> str:
    return f"{row.title}\n{row.desc}\n{row.poc}"


def tag_seams(text: str, *, extra: Sequence[str] = ()) -> tuple[str, ...]:
    blob = text or ""
    hits: list[str] = []
    for seam in CANONICAL_SEAMS:
        if any(rx.search(blob) for rx in SEAM_CUE_RE[seam]):
            hits.append(seam)
    for seam in extra:
        if seam in CANONICAL_SEAMS and seam not in hits:
            hits.append(seam)
    if not hits:
        hits.append("accounting")
    return tuple(hits[:4])


def match_family(text: str) -> tuple[Family, int]:
    blob = text or ""
    best: Family = FALLBACK_FAMILY
    best_score = -1
    for fam in FAMILIES:
        if fam.fid == FALLBACK_FAMILY.fid:
            continue
        score = sum(1 for rx in FAMILY_CUE_RE[fam.fid] if rx.search(blob))
        if score > best_score:
            best = fam
            best_score = score
    if best_score <= 0:
        return FALLBACK_FAMILY, 0
    return best, best_score


def extract_actions(text: str, *, limit: int = 8) -> tuple[str, ...]:
    found: list[str] = []
    seen: set[str] = set()
    for match in IDENT_CALL_RE.finditer(text or ""):
        raw = match.group(1)
        key = raw.lower()
        if key in STOP_FUNCS or raw in STOP_FUNCS:
            continue
        if key.startswith("test") or key.startswith("fuzz") or key.startswith("invariant"):
            continue
        if key.startswith("set") and key.endswith("up"):
            continue
        if key not in PROTOCOL_ACTIONS:
            continue
        if key in seen:
            continue
        seen.add(key)
        found.append(raw)
        if len(found) >= limit:
            break
    return tuple(found)


def token_set(*parts: str) -> frozenset[str]:
    blob = " ".join(parts).lower()
    return frozenset(TOKEN_RE.findall(blob))


def sanitize_state_language(text: str) -> str:
    out = text or ""
    for rx, repl in BANNED_REPLACEMENTS:
        out = rx.sub(repl, out)
    out = BANNED_NAME_RE.sub("impossible state", out)
    return _norm_space(out)


def abstract_finding(row: FindingRow) -> Abstracted:
    text = blob_of(row)
    family, _score = match_family(text)
    seams = tag_seams(text, extra=family.seams_hint)
    actions = extract_actions(f"{row.poc}\n{row.desc}\n{row.title}")
    name = sanitize_state_language(family.name)
    construction = family.construction
    if len(actions) >= 2:
        shown = ", ".join(actions[:4])
        construction = (
            f"{family.construction} Valid-action sketch from this seam: "
            f"a permissionless actor reaches {shown}, each call returning success."
        )
    construction = sanitize_state_language(construction)
    witness = sanitize_state_language(family.witness)
    monetize = sanitize_state_language(family.monetize_kill)
    tokens = token_set(family.fid, " ".join(seams), " ".join(actions), name)
    return Abstracted(
        dataset_id=row.dataset_id,
        severity=row.severity,
        weight=float(row.weight or 0.0),
        poc_present=True,
        family=family,
        seams=seams,
        actions=actions,
        tokens=tokens,
        fact_a=family.fact_a,
        fact_b=family.fact_b,
        construction=construction,
        witness=witness,
        monetize_kill=monetize,
        name=name,
    )


def _jaccard(a: frozenset[str], b: frozenset[str]) -> float:
    if not a or not b:
        return 0.0
    inter = len(a & b)
    if inter == 0:
        return 0.0
    return inter / len(a | b)


@dataclass
class _Cluster:
    family_id: str
    primary_seam: str
    members: list[Abstracted] = field(default_factory=list)
    tokens: frozenset[str] = field(default_factory=frozenset)

    def add(self, item: Abstracted) -> None:
        self.members.append(item)
        if not self.tokens:
            self.tokens = item.tokens
        else:
            # Keep a stable core: union would drift; intersect keeps the cluster tight.
            merged = self.tokens | item.tokens
            if len(merged) > 80:
                merged = frozenset(sorted(merged)[:80])
            self.tokens = merged


def _primary_seam(seams: Sequence[str]) -> str:
    return seams[0] if seams else "accounting"


def _sev_rank(sev: str) -> int:
    return SEV_RANK.get(sev, 9)


def _exemplar(members: Sequence[Abstracted]) -> Abstracted:
    return min(
        members,
        key=lambda m: (
            _sev_rank(m.severity),
            -m.weight,
            -len(m.actions),
            m.dataset_id,
        ),
    )


def cluster_abstracts(
    items: Sequence[Abstracted],
    *,
    max_shapes: int = DEFAULT_MAX_SHAPES,
    jaccard_merge: float = JACCARD_MERGE,
) -> list[list[Abstracted]]:
    ordered = sorted(
        items,
        key=lambda x: (x.family.fid, _primary_seam(x.seams), x.dataset_id),
    )
    clusters: list[_Cluster] = []
    for item in ordered:
        pseam = _primary_seam(item.seams)
        placed = False
        for cluster in clusters:
            if cluster.family_id != item.family.fid:
                continue
            if cluster.primary_seam != pseam:
                continue
            if _jaccard(cluster.tokens, item.tokens) >= jaccard_merge:
                cluster.add(item)
                placed = True
                break
        if not placed:
            c = _Cluster(family_id=item.family.fid, primary_seam=pseam)
            c.add(item)
            clusters.append(c)

    def _merge_pair(a: _Cluster, b: _Cluster) -> _Cluster:
        out = _Cluster(family_id=a.family_id, primary_seam=a.primary_seam)
        for m in a.members + b.members:
            out.add(m)
        return out

    # Collapse extras within family+seam, then within family.
    while len(clusters) > max_shapes:
        grouped: dict[tuple[str, str], list[int]] = {}
        for i, c in enumerate(clusters):
            grouped.setdefault((c.family_id, c.primary_seam), []).append(i)
        pair: tuple[int, int] | None = None
        for idxs in grouped.values():
            if len(idxs) >= 2:
                idxs_sorted = sorted(idxs, key=lambda i: len(clusters[i].members))
                pair = (idxs_sorted[0], idxs_sorted[1])
                break
        if pair is None:
            by_fam: dict[str, list[int]] = {}
            for i, c in enumerate(clusters):
                by_fam.setdefault(c.family_id, []).append(i)
            for idxs in by_fam.values():
                if len(idxs) >= 2:
                    idxs_sorted = sorted(idxs, key=lambda i: len(clusters[i].members))
                    pair = (idxs_sorted[0], idxs_sorted[1])
                    break
        if pair is None:
            idxs_sorted = sorted(range(len(clusters)), key=lambda i: len(clusters[i].members))
            if len(idxs_sorted) < 2:
                break
            pair = (idxs_sorted[0], idxs_sorted[1])
        i, j = pair
        if i > j:
            i, j = j, i
        merged = _merge_pair(clusters[i], clusters[j])
        del clusters[j]
        clusters[i] = merged

    return [c.members for c in clusters]


def _unique_name(family_name: str, seam: str, actions: Sequence[str], used: set[str]) -> str:
    base = sanitize_state_language(family_name)
    candidates = [base, f"{base} ({seam} seam)"]
    if actions:
        candidates.append(f"{base} via {actions[0]}")
    if len(actions) >= 2:
        candidates.append(f"{base} via {actions[0]}/{actions[1]}")
    n = 2
    for cand in candidates:
        if cand not in used:
            return cand
    while True:
        cand = f"{base} ({seam} #{n})"
        if cand not in used:
            return cand
        n += 1


def cards_from_clusters(clusters: Sequence[Sequence[Abstracted]]) -> list[ShapeCard]:
    used_names: set[str] = set()
    cards: list[ShapeCard] = []
    sortable: list[tuple[tuple[object, ...], list[Abstracted]]] = []
    for members in clusters:
        if not members:
            continue
        ex = _exemplar(members)
        sortable.append(
            (
                (
                    ex.family.fid,
                    _primary_seam(ex.seams),
                    -len(members),
                    _sev_rank(ex.severity),
                    ex.dataset_id,
                ),
                list(members),
            )
        )
    sortable.sort(key=lambda t: t[0])
    for i, (_key, members) in enumerate(sortable, start=1):
        ex = _exemplar(members)
        name = _unique_name(ex.name, _primary_seam(ex.seams), ex.actions, used_names)
        used_names.add(name)
        ids = sorted({m.dataset_id for m in members})
        best_sev = min((m.severity for m in members), key=_sev_rank)
        seam_counts: dict[str, int] = {}
        for m in members:
            for s in m.seams:
                seam_counts[s] = seam_counts.get(s, 0) + 1
        # Majority / exemplar seams only — do not union every member tag
        # or retrieve becomes "everything matches vault".
        majority_floor = max(1, (len(members) + 1) // 2)
        majority = [s for s, n in seam_counts.items() if n >= majority_floor]
        ranked = sorted(
            seam_counts,
            key=lambda s: (
                -seam_counts[s],
                CANONICAL_SEAMS.index(s) if s in CANONICAL_SEAMS else 99,
            ),
        )
        seams: list[str] = []
        for s in list(ex.seams) + majority + ranked:
            if s not in seams:
                seams.append(s)
            if len(seams) >= 4:
                break
        if not seams:
            seams = ["accounting"]
        cards.append(
            ShapeCard(
                shape_id=f"SHAPE-K{i:03d}",
                name=name,
                fact_a=ex.fact_a,
                fact_b=ex.fact_b,
                seams=seams,
                construction=ex.construction,
                witness=ex.witness,
                monetize_kill=ex.monetize_kill,
                provenance_ids=ids[:PROVENANCE_ID_CAP],
                severity=best_sev,
                poc_present=any(m.poc_present for m in members),
                member_count=len(members),
                family_id=ex.family.fid,
                source="knowledge",
                calibration=False,
            )
        )
    return cards


def parse_hand_shapes(shapes_md: str) -> list[ShapeCard]:
    cards: list[ShapeCard] = []
    blocks = re.split(r"(?m)^## (SHAPE-\d+) — ", shapes_md)
    # split → [preamble, id, body, id, body, ...]
    i = 1
    while i + 1 < len(blocks):
        sid = blocks[i].strip()
        body = blocks[i + 1]
        name_line, _, rest = body.partition("\n")
        name = sanitize_state_language(name_line.strip())
        pairing = ""
        witness = ""
        for line in rest.splitlines():
            low = line.lower()
            if "pairing hint:" in low:
                pairing = line.split(":", 1)[-1].strip()
            elif "witness sketch:" in low:
                witness = line.split(":", 1)[-1].strip()
        fact_a, fact_b = "component A record", "component B record"
        if "↔" in pairing:
            left, right = [p.strip() for p in pairing.split("↔", 1)]
            fact_a, fact_b = left, right
        cards.append(
            ShapeCard(
                shape_id=sid,
                name=name,
                fact_a=fact_a,
                fact_b=fact_b,
                seams=list(HAND_SHAPE_SEAMS.get(sid, ("accounting",))),
                construction=(
                    "Invent a valid-action sequence on this seam that makes the two "
                    "representations diverge while every call returns success."
                ),
                witness=witness or "reprA != reprB AND last call success",
                monetize_kill=(
                    "Who redeems, withdraws, settles, or is forced to absorb the divergence? "
                    "Kill it if both representations update atomically."
                ),
                provenance_ids=[],
                severity="calibration",
                poc_present=False,
                member_count=1,
                family_id="hand",
                source="hand",
                calibration=True,
            )
        )
        i += 2
    return cards


def load_hand_shapes(repo_root: Path) -> list[ShapeCard]:
    path = repo_root / "references" / "shapes.md"
    if not path.is_file():
        return []
    return parse_hand_shapes(path.read_text(encoding="utf-8"))


def shape_to_dict(card: ShapeCard) -> dict[str, object]:
    return asdict(card)


def shape_from_dict(data: Mapping[str, object]) -> ShapeCard:
    seams_raw = data.get("seams") or []
    seams = [str(s) for s in seams_raw] if isinstance(seams_raw, list) else []
    ids_raw = data.get("provenance_ids") or []
    ids = [int(x) for x in ids_raw] if isinstance(ids_raw, list) else []
    return ShapeCard(
        shape_id=str(data.get("shape_id") or ""),
        name=str(data.get("name") or ""),
        fact_a=str(data.get("fact_a") or ""),
        fact_b=str(data.get("fact_b") or ""),
        seams=seams,
        construction=str(data.get("construction") or ""),
        witness=str(data.get("witness") or ""),
        monetize_kill=str(data.get("monetize_kill") or ""),
        provenance_ids=ids,
        severity=str(data.get("severity") or ""),
        poc_present=bool(data.get("poc_present")),
        member_count=int(data.get("member_count") or 1),
        family_id=str(data.get("family_id") or ""),
        source=str(data.get("source") or "knowledge"),
        calibration=bool(data.get("calibration")),
    )


def load_knowledge_shapes(knowledge_dir: Path) -> list[ShapeCard]:
    jsonl = knowledge_dir / "shapes.jsonl"
    if not jsonl.is_file():
        return []
    cards: list[ShapeCard] = []
    for line in jsonl.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line:
            continue
        cards.append(shape_from_dict(json.loads(line)))
    return cards


def _shape_num(shape_id: str) -> int:
    match = re.search(r"(\d+)$", shape_id or "")
    return int(match.group(1)) if match else 9999


def score_shape(card: ShapeCard, requested: Sequence[str]) -> tuple[int, int, int, int]:
    req = [s.lower() for s in requested]
    overlap = sum(1 for s in card.seams if s.lower() in req)
    cal = 1 if card.calibration else 0
    # Sort with negated fields so SHAPE-01 (core) precedes SHAPE-30.
    return (-overlap, -cal, -card.member_count, _shape_num(card.shape_id))


def retrieve_shapes(
    requested_seams: Sequence[str],
    *,
    knowledge_dir: Path | None,
    repo_root: Path,
    n: int = DEFAULT_RETRIEVE_N,
) -> tuple[list[ShapeCard], str]:
    """Return top-N shapes tagged with the requested seams.

    Ranking is seam overlap, not similarity to a code description.
    Empty knowledge falls back to hand-written calibration shapes.
    """
    req = [s.strip().lower() for s in requested_seams if s.strip()]
    unknown = [s for s in req if s not in CANONICAL_SEAMS]
    req = [s for s in req if s in CANONICAL_SEAMS]
    if not req:
        raise ValueError(
            "Need at least one canonical seam tag. Canonical: "
            + ", ".join(CANONICAL_SEAMS)
        )

    hand = load_hand_shapes(repo_root)
    knowledge: list[ShapeCard] = []
    fallback_reason = ""
    if knowledge_dir is not None and knowledge_dir.exists():
        knowledge = load_knowledge_shapes(knowledge_dir)
        if not knowledge:
            fallback_reason = "knowledge corpus empty; using hand-written calibration shapes"
    else:
        fallback_reason = "knowledge directory missing; using hand-written calibration shapes"

    pool = knowledge + hand
    matched = [c for c in pool if any(s.lower() in req for s in c.seams)]
    if not matched:
        # Still return generic calibration rather than inventing a RAG hit.
        matched = [c for c in hand if "accounting" in c.seams or c.shape_id in {"SHAPE-04", "SHAPE-28", "SHAPE-01"}]
        if fallback_reason:
            fallback_reason += "; no seam hits, returning generic calibration"
        else:
            fallback_reason = "no seam hits in knowledge; returning generic calibration"

    matched.sort(key=lambda c: score_shape(c, req))
    calibration_matches = [c for c in matched if c.calibration]
    knowledge_matches = [c for c in matched if not c.calibration]
    n = max(1, n)
    if not knowledge_matches:
        top = calibration_matches[:n]
    else:
        # Calibration is a core, not the whole pack. Leave room for distilled fuel.
        cal_n = min(len(calibration_matches), n // 3)
        know_n = n - cal_n
        top = knowledge_matches[:know_n] + calibration_matches[:cal_n]
    if not top:
        top = matched[:n]
    note = fallback_reason
    if unknown:
        extra = "ignored unknown seam tags: " + ", ".join(unknown)
        note = f"{note}; {extra}" if note else extra
    return top, note


def render_shape_md(card: ShapeCard) -> str:
    seams = ", ".join(f"`{s}`" for s in card.seams) or "`accounting`"
    ids = ", ".join(str(i) for i in card.provenance_ids) or "none (calibration)"
    poc = "yes" if card.poc_present else "no"
    src = "hand-written calibration" if card.calibration else DATASET_REPO
    return f"""# {card.shape_id} — {card.name}

Abstract state generator. Not a vulnerability category. Invent a CX; do not tick this as a match. Do not promote this shape to a finding without CX → witness → harness → kill.

- FACT that diverges: {card.fact_a} vs {card.fact_b}
- SEAMS: {seams}
- CONSTRUCTION: {card.construction}
- WITNESS: {card.witness}
- MONETIZATION / KILL: {card.monetize_kill}
- PROVENANCE: {src}; dataset ids {ids}; severity {card.severity}; PoC present: {poc}; cluster size {card.member_count}. Distilled, not a report dump.
"""


def render_pack(cards: Sequence[ShapeCard], *, seams: Sequence[str], note: str = "") -> str:
    lines = [
        "# Seam-matched shape pack",
        "",
        "Generators for impossible states. Not a checklist. Not LazyAudit.",
        "Question: which impossible state could this seam inhabit?",
        "Not: which of these known bugs is present?",
        "",
        f"Seams: {', '.join(seams)}",
        f"Count: {len(cards)} (do not load more of the corpus)",
    ]
    if note:
        lines.append(f"Note: {note}")
    lines += ["", "Focus lock still applies: at most 2 live CX cards. These shapes do not authorize 30 cards.", ""]
    for card in cards:
        lines += [
            f"## {card.shape_id} — {card.name}",
            f"- FACT that diverges: {card.fact_a} vs {card.fact_b}",
            f"- SEAMS: {', '.join(card.seams)}",
            f"- CONSTRUCTION: {card.construction}",
            f"- WITNESS: {card.witness}",
            f"- MONETIZATION / KILL: {card.monetize_kill}",
            "",
        ]
    lines += [
        "## Anti-pattern",
        "Matching SWC / bug-class names, dumping the corpus, or promoting a retrieved",
        "shape without CX → witness → harness → kill is a method failure.",
        "",
    ]
    return "\n".join(lines)


def finding_rows_from_mapping(cols: Mapping[str, Sequence[object]]) -> list[FindingRow]:
    n = len(cols["id"])
    rows: list[FindingRow] = []
    for i in range(n):
        rows.append(
            FindingRow(
                dataset_id=int(cols["id"][i]),
                title=str(cols["bug_title"][i] or ""),
                desc=str(cols["bug_desc"][i] or ""),
                poc=str(cols["bug_poc"][i] or ""),
                full=str(cols.get("bug_full", [""] * n)[i] or ""),
                severity=str(cols["bug_sev"][i] or ""),
                weight=float(cols["bug_weight"][i] or 0.0),
                file_name=str(cols.get("file_name", [""] * n)[i] or ""),
            )
        )
    return rows


def filter_rows(
    rows: Iterable[FindingRow],
    *,
    include_medium: bool = True,
    medium_weight_floor: float = MEDIUM_WEIGHT_FLOOR,
) -> tuple[list[FindingRow], dict[str, int]]:
    stats = {
        "input": 0,
        "kept": 0,
        "drop_severity": 0,
        "drop_placeholder_poc": 0,
        "drop_short_desc": 0,
        "drop_medium_weight": 0,
        "dedup_dropped": 0,
    }
    kept: list[FindingRow] = []
    for row in rows:
        stats["input"] += 1
        sev = (row.severity or "").strip()
        if sev in NOISE_SEV:
            stats["drop_severity"] += 1
            continue
        if not is_real_poc(row.poc):
            stats["drop_placeholder_poc"] += 1
            continue
        if len(_norm_space(row.desc)) < MIN_DESC_CHARS:
            stats["drop_short_desc"] += 1
            continue
        if sev in PRIMARY_SEV:
            kept.append(row)
            continue
        if include_medium and sev == MEDIUM_SEV:
            if float(row.weight or 0.0) >= medium_weight_floor:
                kept.append(row)
            else:
                stats["drop_medium_weight"] += 1
            continue
        stats["drop_severity"] += 1
    # Exact / near-identical desc dedup. Keep higher severity, then weight.
    by_key: dict[str, FindingRow] = {}
    dropped = 0
    for row in kept:
        norm = normalize_desc(row.desc or row.full)
        key = hashlib.sha256(norm[:NEAR_DUP_PREFIX].encode("utf-8")).hexdigest()
        prev = by_key.get(key)
        if prev is None:
            by_key[key] = row
            continue
        dropped += 1
        better = sorted(
            [prev, row],
            key=lambda r: (_sev_rank(r.severity), -r.weight, r.dataset_id),
        )[0]
        by_key[key] = better
    stats["dedup_dropped"] = dropped
    stats["kept"] = len(by_key)
    return list(by_key.values()), stats


def download_parquet(dest: Path, *, url: str = DATASET_PARQUET_URL, timeout: int = 120) -> Path:
    dest.parent.mkdir(parents=True, exist_ok=True)
    req = urllib.request.Request(url, headers={"User-Agent": "ragnarok-distiller/5.1"})
    with urllib.request.urlopen(req, timeout=timeout) as resp:
        dest.write_bytes(resp.read())
    return dest


def load_parquet_rows(path: Path) -> list[FindingRow]:
    try:
        import pyarrow.parquet as pq
    except ImportError as exc:
        raise SystemExit(
            "pyarrow is required to read the dataset parquet. "
            "Install with: pip install -r scripts/requirements-distill.txt"
        ) from exc
    table = pq.read_table(path)
    cols = {name: table.column(name).to_pylist() for name in table.column_names}
    return finding_rows_from_mapping(cols)


def write_knowledge(
    cards: Sequence[ShapeCard],
    out_dir: Path,
    *,
    stats: Mapping[str, object],
) -> None:
    out_dir.mkdir(parents=True, exist_ok=True)
    shapes_dir = out_dir / "shapes"
    by_seam = out_dir / "by-seam"
    if shapes_dir.exists():
        for old in shapes_dir.glob("SHAPE-K*.md"):
            old.unlink()
    shapes_dir.mkdir(exist_ok=True)
    if by_seam.exists():
        for old in by_seam.glob("*.md"):
            old.unlink()
    by_seam.mkdir(exist_ok=True)

    jsonl_path = out_dir / "shapes.jsonl"
    with jsonl_path.open("w", encoding="utf-8") as fh:
        for card in cards:
            fh.write(json.dumps(shape_to_dict(card), sort_keys=True) + "\n")
            (shapes_dir / f"{card.shape_id}.md").write_text(render_shape_md(card), encoding="utf-8")

    seam_index: dict[str, list[str]] = {s: [] for s in CANONICAL_SEAMS}
    for card in cards:
        for seam in card.seams:
            seam_index.setdefault(seam, []).append(card.shape_id)
    (out_dir / "seams.json").write_text(
        json.dumps(seam_index, indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
    )

    for seam, ids in seam_index.items():
        subset = [c for c in cards if c.shape_id in ids]
        lines = [
            f"# {seam} seam — shape index",
            "",
            "Browse file. **Do not load this file on a hunt.** Use:",
            "",
            f"`scripts/shape_retrieve.sh {seam}`",
            "",
            f"{len(subset)} shapes tagged `{seam}`.",
            "",
            "| ID | Name | Other seams |",
            "| :--- | :--- | :--- |",
        ]
        for card in subset:
            others = ", ".join(s for s in card.seams if s != seam)
            lines.append(f"| `{card.shape_id}` | {card.name} | {others} |")
        (by_seam / f"{seam}.md").write_text("\n".join(lines) + "\n", encoding="utf-8")

    index_lines = [
        "# Knowledge shape index",
        "",
        "Abstract STATE generators distilled from Zaevlad/audit-findings-dataset.",
        "Not a vulnerability catalog. After SYNTHESIS OPEN, load only a seam-matched pack:",
        "",
        "```",
        "scripts/shape_retrieve.sh vault oracle",
        "```",
        "",
        f"Corpus size: {len(cards)} distinct shapes.",
        f"Filter stats: {json.dumps(dict(stats), sort_keys=True)}",
        "",
        "| ID | Name | Seams | Severity | Cluster |",
        "| :--- | :--- | :--- | :--- | ---: |",
    ]
    for card in cards:
        index_lines.append(
            f"| `{card.shape_id}` | {card.name} | {', '.join(card.seams)} | {card.severity} | {card.member_count} |"
        )
    (out_dir / "index.md").write_text("\n".join(index_lines) + "\n", encoding="utf-8")


def distill(
    rows: Sequence[FindingRow],
    *,
    max_shapes: int = DEFAULT_MAX_SHAPES,
    include_medium: bool = True,
    medium_weight_floor: float = MEDIUM_WEIGHT_FLOOR,
) -> tuple[list[ShapeCard], dict[str, int]]:
    kept, stats = filter_rows(
        rows,
        include_medium=include_medium,
        medium_weight_floor=medium_weight_floor,
    )
    abstracts = [abstract_finding(row) for row in kept]
    clusters = cluster_abstracts(abstracts, max_shapes=max_shapes)
    cards = cards_from_clusters(clusters)
    stats["clusters"] = len(cards)
    stats["abstracted"] = len(abstracts)
    return cards, stats
