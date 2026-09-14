#!/usr/bin/env bash
# Sourced by gate_check.sh and harness_init.sh — do not run directly.
# Contradiction-card parsing, focus lock, witness, composition, invariant
# mapping, and killed.md reopen-on-map-growth.

if ! declare -F section_body >/dev/null 2>&1; then
  section_body() {
    local file="$1" re="$2"
    [ -f "$file" ] || return 0
    awk -v re="$re" '
      BEGIN { found=0 }
      /^#{1,3}[^#]/ {
        if (found==1) { exit }
        if (tolower($0) ~ re) { found=1; next }
        next
      }
      found==1 { print }
    ' "$file"
  }
fi

if ! declare -F is_placeholder_or_blank >/dev/null 2>&1; then
  is_placeholder_or_blank() {
    local text="$1" trimmed
    trimmed="$(printf '%s' "$text" | tr -d '[:space:]')"
    [ -z "$trimmed" ] && return 0
    if printf '%s' "$text" | grep -qiE '<fill|<name>|_e\.g\.|0x\.\.\.|\bTBD\b|<-- ?set one|<statement of|<concise|<underlying|placeholder'; then
      return 0
    fi
    [ "${#trimmed}" -lt 15 ] && return 0
    return 1
  }
fi

LIVE_STATUSES_RE='^(INVENTED|PROBING|REACHABLE)$'
OPEN_PROBE_RE='^PROBING$'
KILL_OUTCOME_RE='KILLED|UNREACHABLE'

cx_file() {
  printf '%s' "$RESEARCH/contradictions.md"
}

cx_ids() {
  local f
  f="$(cx_file)"
  [ -f "$f" ] || return 0
  grep -oE '^##+ *CX-[0-9]+' "$f" | grep -oE 'CX-[0-9]+' | sort -t- -k2 -n
}

cx_body() {
  local id="$1"
  local re
  re="$(printf '%s' "$id" | tr '[:upper:]' '[:lower:]')"
  section_body "$(cx_file)" "$re"
}

cx_field() {
  local body="$1" label="$2"
  printf '%s\n' "$body" | grep -iE "^-?\\s*${label}:" | head -1 | sed -E 's/^[^:]*:[[:space:]]*//'
}

cx_status_token() {
  local raw="$1" token
  token="$(printf '%s' "$raw" | tr '[:lower:]' '[:upper:]' | sed -E 's/[^A-Z_].*$//' | tr -d '[:space:]')"
  printf '%s' "$token"
}

cx_is_live() {
  local status="$1"
  printf '%s' "$status" | grep -qiE "$KILL_OUTCOME_RE" && return 1
  printf '%s' "$status" | grep -qiE "$LIVE_STATUSES_RE"
}

is_assertable_witness() {
  local w="$1"
  is_placeholder_or_blank "$w" && return 1
  if ! printf '%s' "$w" | grep -qE '(==|!=|>=|<=|<|>|assertTrue|assertEq|assertGt|assertLt|assertGe|assertLe|assertFalse)'; then
    return 1
  fi
  if ! printf '%s' "$w" | grep -qiE 'balanceOf|totalSupply|totalAssets|convertTo|allowance|shares|assets|supply|slot|storage|claim|debt|collateral|ticket|settled|paused|reserves|nav|rate|price|queued|escrow|minted|burned|balance|liquidity|solvent|backing|sharesMinted|previewRedeem|previewDeposit'; then
    return 1
  fi
  return 0
}

is_pairing_card() {
  local body="$1"
  local pairing components trimmed
  pairing="$(cx_field "$body" 'PAIRING')"
  components="$(cx_field "$body" 'COMPONENTS')"
  trimmed="$(printf '%s' "$pairing" | tr -d '[:space:]')"
  if [ -n "$trimmed" ] && ! printf '%s' "$pairing" | grep -qiE '<fill|_e\.g\.|\bTBD\b|placeholder|ComponentA'; then
    if printf '%s' "$pairing" | grep -qE '[↔+,/]|[[:space:]]+and[[:space:]]+|[[:space:]]+vs[[:space:]]+'; then
      return 0
    fi
    if printf '%s' "$pairing" | grep -qE '[A-Za-z0-9_]+[[:space:]]+[A-Za-z0-9_]+'; then
      return 0
    fi
  fi
  trimmed="$(printf '%s' "$components" | tr -d '[:space:]')"
  if [ -n "$trimmed" ] && ! printf '%s' "$components" | grep -qiE '<fill|_e\.g\.|\bTBD\b|placeholder'; then
    if printf '%s' "$components" | grep -qE ',|[↔+]|[[:space:]]+and[[:space:]]+'; then
      return 0
    fi
  fi
  return 1
}

has_recorded_falsifier_result() {
  local body="$1"
  local result
  result="$(cx_field "$body" 'FALSIFIER RESULT')"
  [ -z "$(printf '%s' "$result" | tr -d '[:space:]')" ] && result="$(cx_field "$body" 'PROBE RESULT')"
  [ -z "$(printf '%s' "$result" | tr -d '[:space:]')" ] && result="$(cx_field "$body" 'RESULT')"
  local trimmed
  trimmed="$(printf '%s' "$result" | tr -d '[:space:]')"
  [ -z "$trimmed" ] && return 1
  printf '%s' "$result" | grep -qiE 'unrecorded|<fill|_e\.g\.|\bTBD\b|placeholder' && return 1
  return 0
}

has_invariant_mapping() {
  local body="$1"
  local harness handlers ht
  harness="$(cx_field "$body" 'INVARIANT HARNESS')"
  handlers="$(cx_field "$body" 'HANDLERS')"
  ht="$(printf '%s' "$harness$handlers" | tr -d '[:space:]')"
  [ -z "$ht" ] && return 1
  printf '%s' "$harness$handlers" | grep -qiE '<fill|_e\.g\.|\bTBD\b|placeholder' && return 1
  return 0
}

cx_numeric_id() {
  printf '%s' "$1" | grep -oE '[0-9]+' | head -1
}

# Map nodes and entrypoints currently written on the thin/wide map.
collect_map_keys() {
  local f="$RESEARCH/architecture.md"
  [ -f "$f" ] || return 0
  awk '
    BEGIN { in_graph=0; in_entry=0 }
    /^#{1,3}[^#]/ {
      in_graph=0; in_entry=0
      low=tolower($0)
      if (low ~ /component graph|contracts? & components/) in_graph=1
      if (low ~ /entry.?point/) in_entry=1
      next
    }
    in_graph && /^[[:space:]]*[^|<][^|]*\|[^|]+\|[^|]+/ {
      if ($0 ~ /^---/) next
      if (tolower($0) ~ /component[[:space:]]*\|/) next
      split($0, a, "|")
      key=a[1]
      gsub(/^[ \t]+|[ \t]+$/, "", key)
      if (length(key)>0) print key
    }
    in_entry {
      line=$0
      while (match(line, /[A-Za-z_][A-Za-z0-9_]*\(/)) {
        print substr(line, RSTART, RLENGTH-1) "()"
        line = substr(line, RSTART+RLENGTH)
      }
    }
  ' "$f" | sort -u
}

map_stamp_path() {
  printf '%s' "$RESEARCH/map-stamp.txt"
}

new_map_keys() {
  local stamp current
  stamp="$(map_stamp_path)"
  current="$(collect_map_keys)"
  if [ ! -f "$stamp" ] || [ -z "$(tr -d '[:space:]' < "$stamp")" ]; then
    return 0
  fi
  comm -13 <(sort -u "$stamp") <(printf '%s\n' "$current" | sort -u)
}

killed_revisit_blocks() {
  local f="$RESEARCH/killed.md"
  [ -f "$f" ] || return 0
  awk '
    BEGIN { id=""; block="" }
    /^##+ / {
      if (id != "" && block ~ /[Rr]evisit if/) {
        printf "%s\n", id
        n = split(block, lines, "\n")
        for (i=1; i<=n; i++) {
          if (lines[i] ~ /[Rr]evisit if/) print lines[i]
        }
        print "---"
      }
      id=$0
      sub(/^##+[[:space:]]*/, "", id)
      block=""
      next
    }
    { block = block $0 "\n" }
    END {
      if (id != "" && block ~ /[Rr]evisit if/) {
        printf "%s\n", id
        n = split(block, lines, "\n")
        for (i=1; i<=n; i++) {
          if (lines[i] ~ /[Rr]evisit if/) print lines[i]
        }
        print "---"
      }
    }
  ' "$f"
}

# Populate HUNT_VIOLATIONS, FOCUS_*, COMPOSITION_*, REOPEN_* for the V5 gates.
check_hunt_discipline() {
  HUNT_VIOLATIONS=()
  FOCUS_LIVE=()
  FOCUS_PROBES=()
  FOCUS_UNRESOLVED=()
  COMPOSITION_CARDS=()
  SOFT_WITNESS_INVENTED=()
  REOPEN_ITEMS=()
  LIVE_COUNT=0
  PROBE_COUNT=0
  UNRESOLVED_PROBE_COUNT=0

  local f
  f="$(cx_file)"
  local pairing_found=0
  local cx_count=0

  if [ -f "$f" ]; then
  local id body status token witness
  for id in $(cx_ids); do
    body="$(cx_body "$id")"
    status="$(cx_field "$body" 'STATUS')"
    token="$(cx_status_token "$status")"
    [ -z "$token" ] && token="INVENTED"

    if cx_is_live "$token"; then
      LIVE_COUNT=$((LIVE_COUNT + 1))
      FOCUS_LIVE+=("$id:$token")
    fi
    if printf '%s' "$token" | grep -qiE "$OPEN_PROBE_RE"; then
      PROBE_COUNT=$((PROBE_COUNT + 1))
      FOCUS_PROBES+=("$id")
      if ! has_recorded_falsifier_result "$body"; then
        UNRESOLVED_PROBE_COUNT=$((UNRESOLVED_PROBE_COUNT + 1))
        FOCUS_UNRESOLVED+=("$id")
      fi
    fi

    witness="$(cx_field "$body" 'WITNESS')"
    if ! is_assertable_witness "$witness"; then
      if printf '%s' "$token" | grep -qiE '^(PROBING|REACHABLE|MONETIZABLE)$'; then
        HUNT_VIOLATIONS+=("$id: WITNESS is not assertable — card stays INVENTED and cannot promote to $token")
      else
        SOFT_WITNESS_INVENTED+=("$id")
      fi
    fi

    if is_pairing_card "$body"; then
      pairing_found=1
      COMPOSITION_CARDS+=("$id")
    fi

    if printf '%s' "$token" | grep -qiE '^REACHABLE$'; then
      if ! has_invariant_mapping "$body"; then
        HUNT_VIOLATIONS+=("$id: REACHABLE requires INVARIANT HARNESS or HANDLERS mapping (fuzzer must try to walk into the STATE)")
      fi
    fi
  done

  if [ "$LIVE_COUNT" -gt 2 ]; then
    HUNT_VIOLATIONS+=("FOCUS LOCK: $LIVE_COUNT live CX cards (max 2: INVENTED/PROBING/REACHABLE without kill outcome)")
  fi
  if [ "$PROBE_COUNT" -gt 1 ]; then
    HUNT_VIOLATIONS+=("FOCUS LOCK: $PROBE_COUNT open probes (max 1 PROBING card)")
  fi
  if [ "$UNRESOLVED_PROBE_COUNT" -ge 1 ] && [ "$LIVE_COUNT" -gt 1 ]; then
    HUNT_VIOLATIONS+=("FOCUS LOCK: unresolved probe (${FOCUS_UNRESOLVED[*]}) blocks inventing another live CX until FALSIFIER RESULT is recorded")
  fi

  cx_count="$(cx_ids | grep -c . || true)"
  if [ "${cx_count:-0}" -gt 0 ] && [ "$pairing_found" -eq 0 ]; then
    HUNT_VIOLATIONS+=("COMPOSITION: after SYNTHESIS OPEN at least one CX must name a PAIRING of two components (vault↔oracle, queue↔settlement, message↔mint, ...)")
    COMPOSITION_STATUS="MISSING"
  elif [ "${cx_count:-0}" -eq 0 ]; then
    COMPOSITION_STATUS="PENDING"
  else
    COMPOSITION_STATUS="OK"
  fi
  fi

  if [ "${#HUNT_VIOLATIONS[@]}" -eq 0 ]; then
    FOCUS_STATUS="HOLD"
  else
    FOCUS_STATUS="VIOLATION"
  fi

  local added
  added="$(new_map_keys)"
  if [ -n "$(printf '%s' "$added" | tr -d '[:space:]')" ]; then
    local killed_f="$RESEARCH/killed.md"
    if [ -f "$killed_f" ] && grep -qiE '^-[[:space:]]*Revisit if:' "$killed_f"; then
      local compact
      compact="$(printf '%s' "$added" | tr '\n' ',' | sed 's/,$//')"
      REOPEN_ITEMS+=("map added: $compact — queue every killed.md 'Revisit if' item")
      local line
      while IFS= read -r line; do
        [ -z "$line" ] && continue
        REOPEN_ITEMS+=("$line")
      done < <(killed_revisit_blocks)
    fi
  fi
}

write_map_stamp() {
  collect_map_keys > "$(map_stamp_path)"
}

next_lead_id() {
  local f="$RESEARCH/leads.md"
  local n
  n="$(grep -oE '^L-[0-9]+' "$f" 2>/dev/null | grep -oE '[0-9]+' | sort -n | tail -1)"
  n="${n:-0}"
  printf 'L-%03d' "$((10#$n + 1))"
}

queue_reopen_leads() {
  [ "${#REOPEN_ITEMS[@]}" -eq 0 ] && return 0
  local leads="$RESEARCH/leads.md"
  local reopen="$RESEARCH/reopen.md"
  mkdir -p "$RESEARCH"
  if [ ! -f "$leads" ]; then
    cat > "$leads" <<'EOF'
# Pending Leads

ID | LOCATION | OBSERVATION | INITIAL CONFIDENCE | INITIAL IMPACT | STATUS
---|---|---|---|---|---
EOF
  fi
  if ! grep -q 'REOPEN queue (map growth)' "$reopen" 2>/dev/null; then
    {
      echo "# Reopen queue (map growth)"
      echo
      echo "Killed constructions are not permanently dead. When the map gains a node or entrypoint, their 'Revisit if' lines are queued here."
      echo
    } >> "$reopen"
  fi
  local item id
  for item in "${REOPEN_ITEMS[@]}"; do
    [ "$item" = "---" ] && continue
    grep -qF "$item" "$leads" 2>/dev/null && continue
    grep -qF "$item" "$reopen" 2>/dev/null && continue
    id="$(next_lead_id)"
    echo "$id | killed.md | REOPEN: $item | MED | unknown | QUEUED" >> "$leads"
    echo "- $id — $item" >> "$reopen"
  done
}

# --- harness scaffolding from a CX card ---

cx_sol_id() {
  local n
  n="$(cx_numeric_id "$1")"
  printf 'CX%03d' "$((10#$n))"
}

sol_c() {
  printf '%s' "$1" | tr '\n"' " '" | sed 's/\*\// /g' | cut -c1-180
}

extract_handlers() {
  local body="$1"
  local handlers
  handlers="$(cx_field "$body" 'HANDLERS')"
  printf '%s' "$handlers" | tr ',;/' '\n' | sed -E 's/\(.*//; s/^[[:space:]]+//; s/[[:space:]]+$//' | grep -E '^[A-Za-z_][A-Za-z0-9_]*$' || true
}

write_cx_witness_harness() {
  local target="$1" id="$2"
  local exp="$target/research/experiments"
  mkdir -p "$exp"
  local body witness monetization state sequence pairing sol
  body="$(cx_body "$id")"
  witness="$(sol_c "$(cx_field "$body" 'WITNESS')")"
  monetization="$(sol_c "$(cx_field "$body" 'MONETIZATION')")"
  state="$(sol_c "$(cx_field "$body" 'STATE')")"
  sequence="$(sol_c "$(cx_field "$body" 'SEQUENCE')")"
  pairing="$(sol_c "$(cx_field "$body" 'PAIRING')")"
  sol="$(cx_sol_id "$id")"
  local out="$exp/${sol}_witness.t.sol"
  cat > "$out" <<EOF
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";

/// Falsifiable witness harness for ${id}.
/// Asserts that the invented STATE holds and that MONETIZATION moves value.
/// Fork only. Never broadcast to production.
contract ${sol}Witness is Test {
    uint256 internal forkId;

    function setUp() public {
        string memory rpc = vm.envString("FORK_RPC");
        uint256 blockNum = vm.envUint("FORK_BLOCK");
        forkId = vm.createSelectFork(rpc, blockNum);
    }

    /// STATE: ${state}
    /// PAIRING: ${pairing}
    /// SEQUENCE: ${sequence}
    function test_${sol}_impossible_state_holds() public {
        // Replace the boolean with a compiled reading of STATE / WITNESS.
        // WITNESS (must remain an assert, not prose): ${witness}
        bool impossibleStateHolds = false;
        assertTrue(impossibleStateHolds, "${id} STATE must hold: ${state}");
        assertTrue(${sol}_witnessPredicate(), "${id} WITNESS: ${witness}");
    }

    function test_${sol}_monetization_moves_value() public {
        uint256 beforeValue = ${sol}_valueSnapshot();
        // SEQUENCE: ${sequence}
        // MONETIZATION: ${monetization}
        uint256 afterValue = ${sol}_valueSnapshot();
        assertGt(afterValue, beforeValue, "${id} MONETIZATION must move value: ${monetization}");
    }

    function ${sol}_witnessPredicate() internal view returns (bool) {
        // Compile: ${witness}
        return false;
    }

    function ${sol}_valueSnapshot() internal view returns (uint256) {
        // Snapshot the balance/claim named in MONETIZATION.
        return 0;
    }
}
EOF
  echo "wrote $out"
}

write_cx_invariant_harness() {
  local target="$1" id="$2"
  local exp="$target/research/experiments"
  mkdir -p "$exp"
  local body witness state handlers sol
  body="$(cx_body "$id")"
  witness="$(sol_c "$(cx_field "$body" 'WITNESS')")"
  state="$(sol_c "$(cx_field "$body" 'STATE')")"
  sol="$(cx_sol_id "$id")"
  local out="$exp/${sol}_invariant.t.sol"
  local handler_fns=""
  local h
  while IFS= read -r h; do
    [ -z "$h" ] && continue
    handler_fns="${handler_fns}
    function handler_${h}(uint256 n) public {
        n;
        // Valid permissionless call: ${h}(...)
        // Do not cheat with admin vm.prank unless CLASS is PRIVILEGED.
    }
"
  done < <(extract_handlers "$body")
  if [ -z "$(printf '%s' "$handler_fns" | tr -d '[:space:]')" ]; then
    handler_fns='
    function handler_permissionless(uint256 n) public {
        n;
        // Fill from CX HANDLERS. Any valid call sequence is in scope.
    }
'
  fi
  cat > "$out" <<EOF
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";

/// Invariant fuzz bridge for ${id}.
/// Ragnarok invented the STATE. This handler set tries to reach it via any
/// valid call sequence. Fail the invariant if WITNESS becomes true.
/// Fork only. Never broadcast to production.
contract ${sol}Invariant is Test {
    uint256 internal forkId;

    function setUp() public {
        string memory rpc = vm.envString("FORK_RPC");
        uint256 blockNum = vm.envUint("FORK_BLOCK");
        forkId = vm.createSelectFork(rpc, blockNum);
    }
${handler_fns}
    /// STATE that must stay unreachable: ${state}
    /// WITNESS that would prove the fuzzer arrived: ${witness}
    function invariant_${sol}_state_unreachable() public view {
        assertFalse(${sol}_witnessHolds(), "${id} WITNESS reached: ${witness}");
    }

    function ${sol}_witnessHolds() internal view returns (bool) {
        // Compile: ${witness}
        return false;
    }
}
EOF
  echo "wrote $out"
}
