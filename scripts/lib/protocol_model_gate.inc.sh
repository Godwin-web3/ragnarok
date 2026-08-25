#!/usr/bin/env bash
# Sourced by scripts/gate_check.sh after gate_check.inc.sh.
ids_in() {
  printf '%s' "$1" | grep -oE '(ASM|INV|ACC|ST|ACT|PROM|COND)-[0-9]+' | sort -u
}

record_ids() {
  local file="$1" prefix="$2"
  [ -f "$file" ] || return 0
  grep -oE "^#+ *${prefix}-[0-9]+" "$file" | grep -oE "${prefix}-[0-9]+" | sort -u
}

field_from_body() {
  local body="$1" label="$2"
  printf '%s\n' "$body" | grep -iE "^-?\\s*${label}" | head -1 | sed -E 's/^[^:]*:[[:space:]]*//'
}

check_phase5() {
  REASONS=()
  local f="$RESEARCH/protocol-model.md"
  if is_empty_file "$f"; then
    REASONS+=("protocol-model.md: MISSING/EMPTY")
    return
  fi
  if grep -qiE '^##+ *no applicable protocol model' "$f"; then
    local body
    body="$(section_body "$f" 'no applicable protocol model')"
    if is_placeholder_or_blank "$body"; then
      REASONS+=("protocol-model.md: 'No applicable protocol model' rationale is present but empty/placeholder")
    fi
    return
  fi

  if ! grep -qE '^##+ *ACT-[0-9]+' "$f"; then
    REASONS+=("protocol-model.md: no ACT-### actors")
  fi
  if ! grep -qE '^##+ *PROM-[0-9]+' "$f"; then
    REASONS+=("protocol-model.md: no PROM-### promises")
    return
  fi

  local act_ids prom_ids st_ids acc_ids cond_ids asm_ids inv_ids
  act_ids="$(record_ids "$f" ACT)"
  prom_ids="$(record_ids "$f" PROM)"
  st_ids="$(record_ids "$f" ST)"
  acc_ids="$(record_ids "$f" ACC)"
  cond_ids="$(record_ids "$f" COND)"
  asm_ids="$(record_ids "$RESEARCH/assumptions.md" ASM)"
  inv_ids="$(record_ids "$RESEARCH/invariants.md" INV)"

  local critical_actors=()
  local id body crit
  for id in $act_ids; do
    body="$(section_body "$f" "${id,,}")"
    crit="$(field_from_body "$body" 'Critical\?:')"
    if [ -z "$(printf '%s' "$crit" | tr -d '[:space:]')" ] || printf '%s' "$crit" | grep -qiE '^yes'; then
      critical_actors+=("$id")
    fi
  done
  if [ "${#critical_actors[@]}" -eq 0 ]; then
    REASONS+=("protocol-model.md: no critical actor (mark Critical?: yes, or omit the field)")
  fi

  local promised_actors=""
  for id in $prom_ids; do
    body="$(section_body "$f" "${id,,}")"
    for field in 'Actor:' 'Promise:' 'Required conditions:' 'Accounting:' 'State transitions:' 'Enforcement:' 'Attacker influence:' 'Potential value transfer:' 'Falsification plan:'; do
      local val
      val="$(field_from_body "$body" "${field}")"
      if [ -z "$(printf '%s' "$val" | tr -d '[:space:]')" ]; then
        REASONS+=("protocol-model.md: $id missing field '$field'")
      fi
    done

    local actor_field cond_field acc_field st_field
    actor_field="$(field_from_body "$body" 'Actor:')"
    cond_field="$(field_from_body "$body" 'Required conditions:')"
    acc_field="$(field_from_body "$body" 'Accounting:')"
    st_field="$(field_from_body "$body" 'State transitions:')"

    local aid
    aid="$(printf '%s' "$actor_field" | grep -oE 'ACT-[0-9]+' | head -1)"
    if [ -z "$aid" ]; then
      REASONS+=("protocol-model.md: $id Actor does not cite ACT-###")
    else
      printf '%s\n' "$act_ids" | grep -qx "$aid" || REASONS+=("protocol-model.md: $id cites unknown $aid")
      promised_actors="$promised_actors $aid"
    fi

    local linked has_cond=0
    for linked in $(ids_in "$cond_field"); do
      case "$linked" in
        ASM-*)
          has_cond=1
          printf '%s\n' "$asm_ids" | grep -qx "$linked" || REASONS+=("protocol-model.md: $id required condition $linked missing from assumptions.md")
          ;;
        COND-*)
          has_cond=1
          printf '%s\n' "$cond_ids" | grep -qx "$linked" || REASONS+=("protocol-model.md: $id required condition $linked is not defined")
          ;;
      esac
    done
    [ "$has_cond" -eq 0 ] && REASONS+=("protocol-model.md: $id has no ASM-### or COND-### required condition")

    local has_acc=0
    for linked in $(ids_in "$acc_field"); do
      case "$linked" in
        INV-*)
          has_acc=1
          printf '%s\n' "$inv_ids" | grep -qx "$linked" || REASONS+=("protocol-model.md: $id accounting $linked missing from invariants.md")
          ;;
        ACC-*)
          has_acc=1
          printf '%s\n' "$acc_ids" | grep -qx "$linked" || REASONS+=("protocol-model.md: $id accounting $linked is not defined")
          ;;
      esac
    done
    [ "$has_acc" -eq 0 ] && REASONS+=("protocol-model.md: $id has no INV-### or ACC-### accounting link")

    local has_st=0
    for linked in $(ids_in "$st_field"); do
      case "$linked" in
        ST-*)
          has_st=1
          printf '%s\n' "$st_ids" | grep -qx "$linked" || REASONS+=("protocol-model.md: $id state transition $linked is not defined")
          ;;
      esac
    done
    [ "$has_st" -eq 0 ] && REASONS+=("protocol-model.md: $id has no ST-### state transition")
  done

  local ca
  for ca in "${critical_actors[@]}"; do
    printf '%s' "$promised_actors" | grep -q "$ca" || REASONS+=("protocol-model.md: critical actor $ca has no promise")
  done

  for id in $st_ids; do
    body="$(section_body "$f" "${id,,}")"
    local who
    who="$(field_from_body "$body" 'Who can trigger:')"
    if [ -z "$(printf '%s' "$who" | tr -d '[:space:]')" ]; then
      REASONS+=("protocol-model.md: $id missing field 'Who can trigger:'")
    fi
  done

  for id in $acc_ids; do
    body="$(section_body "$f" "${id,,}")"
    local vars
    vars="$(field_from_body "$body" 'Variables:')"
    if [ -z "$(printf '%s' "$vars" | tr -d '[:space:]')" ]; then
      REASONS+=("protocol-model.md: $id missing field 'Variables:'")
    fi
  done

  for id in $cond_ids; do
    body="$(section_body "$f" "${id,,}")"
    local prov
    prov="$(field_from_body "$body" 'Provenance:')"
    if [ -z "$(printf '%s' "$prov" | tr -d '[:space:]')" ]; then
      REASONS+=("protocol-model.md: $id missing field 'Provenance:'")
    elif ! printf '%s' "$prov" | grep -qiE 'SOURCE_VERIFIED|DEPLOYMENT_VERIFIED|RUNTIME_VERIFIED|ECONOMICALLY_VERIFIED|UNVERIFIED'; then
      REASONS+=("protocol-model.md: $id provenance is not an evidence level")
    fi
  done
}
