#!/usr/bin/env python3
"""Unit tests for the knowledge-layer filter, seams, retrieve, and fallback."""

from __future__ import annotations

import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent.parent
LIB = HERE.parent / "lib"
sys.path.insert(0, str(LIB))

from shape_knowledge import (  # noqa: E402
    FindingRow,
    ShapeCard,
    abstract_finding,
    filter_rows,
    is_real_poc,
    keep_finding,
    parse_hand_shapes,
    retrieve_shapes,
    tag_seams,
    write_knowledge,
)

PASS = 0
FAIL = 0


def ok(desc: str, cond: bool) -> None:
    global PASS, FAIL
    if cond:
        print(f"ok   - {desc}")
        PASS += 1
    else:
        print(f"FAIL - {desc}")
        FAIL += 1


def test_placeholder_poc_rejection() -> None:
    placeholders = [
        "",
        "no poc",
        "No poc.",
        "N/A",
        "No data",
        "none",
        "information not provided",
        "tbd",
        "short",
        "https://github.com/guardianaudits/gmx_3/tree/main",
    ]
    for p in placeholders:
        ok(f"reject placeholder poc {p!r}", is_real_poc(p) is False)

    real = """
    pragma solidity ^0.8.17;
    contract PoC {
      function testDrain() public {
        vault.deposit(100, attacker);
        vault.withdraw(100, attacker, attacker);
        assert(token.balanceOf(address(vault)) == 0);
      }
    }
    """
    ok("accept solidity poc", is_real_poc(real) is True)

    prose = (
        "Step 1: attacker calls deposit.\n"
        "Step 2: attacker calls harvest.\n"
        "Step 3: attacker calls withdraw and extract the leftover.\n"
        "The exploit sequence uses only valid calls and the last call succeeds.\n"
    ) * 8
    ok("accept long attacker-step prose poc", is_real_poc(prose) is True)


def test_keep_finding_severity() -> None:
    poc = "pragma solidity ^0.8.0; function attack() public { vault.deposit(1); }"
    poc = poc + " assert(true); " * 5
    ok(
        "keep Critical + real poc",
        keep_finding("Critical", 0.1, poc, "The vault share ledger and custody token can diverge after a harvest.") is True,
    )
    ok(
        "keep High + real poc",
        keep_finding("High", 0.0, poc, "The vault share ledger and custody token can diverge after a harvest.") is True,
    )
    ok(
        "drop Gas Optimization even with poc",
        keep_finding("Gas Optimization", 0.9, poc, "Use unchecked for gas savings in the loop.") is False,
    )
    ok(
        "drop Informational",
        keep_finding("Informational", 0.9, poc, "NatSpec is missing on an internal function.") is False,
    )
    ok(
        "drop Unknown",
        keep_finding("Unknown", 0.9, poc, "Commit location scraping artifact rather than a finding.") is False,
    )
    ok(
        "drop Medium with low weight",
        keep_finding("Medium", 0.4, poc, "A medium issue with a real proof of concept included.") is False,
    )
    ok(
        "keep Medium with high weight and real poc",
        keep_finding("Medium", 0.75, poc, "A medium issue with a real proof of concept included.") is True,
    )
    ok(
        "drop Critical with placeholder poc",
        keep_finding("Critical", 1.0, "no poc", "Critical title with no executable proof.") is False,
    )


def test_filter_dedup() -> None:
    poc = "pragma solidity ^0.8.0; function attack() public { vault.deposit(1); assert(true); }"
    poc = poc + " bytes32 x; " * 4
    rows = [
        FindingRow(1, "a", "The vault share ledger diverges from custody after harvest. " * 2, poc, "", "High", 0.5),
        FindingRow(2, "b", "The vault share ledger diverges from custody after harvest. " * 2, poc, "", "High", 0.9),
        FindingRow(3, "c", "A totally different bridge message is accepted without a source lock. " * 2, poc, "", "Critical", 0.4),
    ]
    kept, stats = filter_rows(rows)
    ok("dedup keeps one of two identical descs", len(kept) == 2)
    ids = {r.dataset_id for r in kept}
    ok("dedup keeps higher-weight duplicate", 2 in ids)
    ok("stats record dedup drop", stats["dedup_dropped"] == 1)


def test_seam_tagging() -> None:
    vault = tag_seams("The ERC-4626 vault convertToAssets rate changes after a donation.")
    ok("vault seam tagged", "vault" in vault)
    bridge = tag_seams("LayerZero message on the destination mints without a source lock.")
    ok("bridge seam tagged", "bridge" in bridge)
    mixed = tag_seams("Oracle used by the vault to price shares is stale at redeem.")
    ok("vault+oracle multi-tag", "vault" in mixed and "oracle" in mixed)
    generic = tag_seams("Something happens in a helper.")
    ok("untagged text falls back to accounting", generic == ("accounting",))


def test_abstract_is_state_language() -> None:
    poc = "pragma solidity ^0.8.0; function attack() public { vault.deposit(1); }" + " x" * 40
    row = FindingRow(
        dataset_id=9,
        title="Reentrancy in withdraw allows draining the vault",
        desc="A reentrancy on withdraw lets the attacker drain assets while shares stay constant.",
        poc=poc,
        full="",
        severity="High",
        weight=0.8,
    )
    ab = abstract_finding(row)
    blob = f"{ab.name} {ab.construction} {ab.witness}".lower()
    ok("abstract name avoids 'reentrancy'", "reentrancy" not in blob)
    ok("abstract name avoids 'check for'", "check for" not in blob)
    ok("shape stays in state language (diverge/claims/callback/ledger)", any(
        w in blob for w in ("claim", "callback", "ledger", "representation", "check and settlement")
    ))


def test_retrieve_only_tagged_seams(tmp_path: Path) -> None:
    vault = ShapeCard(
        shape_id="SHAPE-K001",
        name="Claims stay constant while redeemable assets fall",
        fact_a="shares",
        fact_b="assets",
        seams=["vault"],
        construction="valid deposit then leak",
        witness="totalSupply unchanged AND balance down",
        monetize_kill="redeem",
        provenance_ids=[1],
        severity="High",
        poc_present=True,
        member_count=3,
        family_id="claims_vs_assets",
    )
    bridge = ShapeCard(
        shape_id="SHAPE-K002",
        name="Message accepted without a lock",
        fact_a="message",
        fact_b="lock",
        seams=["bridge"],
        construction="replay message",
        witness="mint succeeded AND lock absent",
        monetize_kill="sell minted",
        provenance_ids=[2],
        severity="Critical",
        poc_present=True,
        member_count=2,
        family_id="message_without_lock",
    )
    write_knowledge([vault, bridge], tmp_path, stats={"kept": 2})
    cards, _note = retrieve_shapes(
        ["vault"],
        knowledge_dir=tmp_path,
        repo_root=ROOT,
        n=15,
    )
    ids = {c.shape_id for c in cards}
    ok("retrieve includes vault knowledge shape", "SHAPE-K001" in ids)
    ok("retrieve excludes bridge-only knowledge shape", "SHAPE-K002" not in ids)
    ok("every retrieved shape has the vault seam or is a vault-tagged hand shape", all("vault" in c.seams for c in cards))


def test_empty_knowledge_falls_back_to_hand(tmp_path: Path) -> None:
    cards, note = retrieve_shapes(
        ["vault"],
        knowledge_dir=tmp_path,
        repo_root=ROOT,
        n=15,
    )
    ok("empty knowledge returns some shapes", len(cards) > 0)
    ok("fallback note mentions empty or missing", "empty" in note or "missing" in note)
    ok("fallback shapes are hand calibration", all(c.calibration or c.source == "hand" for c in cards))
    ok("fallback vault pack is vault-tagged", all("vault" in c.seams for c in cards))
    ok("hand SHAPE-01 present in vault fallback", any(c.shape_id == "SHAPE-01" for c in cards))


def test_hand_parser() -> None:
    md = (ROOT / "references" / "shapes.md").read_text(encoding="utf-8")
    cards = parse_hand_shapes(md)
    ok("parsed 30 hand shapes", len(cards) == 30)
    ok("SHAPE-01 parsed", cards[0].shape_id == "SHAPE-01")
    ok("hand shapes are calibration", all(c.calibration for c in cards))


def main() -> int:
    print("=== shape knowledge unit tests ===")
    test_placeholder_poc_rejection()
    test_keep_finding_severity()
    test_filter_dedup()
    test_seam_tagging()
    test_abstract_is_state_language()
    test_hand_parser()
    import tempfile

    with tempfile.TemporaryDirectory() as td:
        test_retrieve_only_tagged_seams(Path(td))
    with tempfile.TemporaryDirectory() as td:
        test_empty_knowledge_falls_back_to_hand(Path(td))
    print("===============================")
    print(f"Passed: {PASS}  Failed: {FAIL}")
    return 0 if FAIL == 0 else 1


if __name__ == "__main__":
    raise SystemExit(main())
