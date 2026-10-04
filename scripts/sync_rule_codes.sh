#!/usr/bin/env bash
# @file sync_rule_codes.sh
# @brief Keep the dyshellint rule codes on the tips of the guide in sync
# @description
#   Every tip the linter checks ends with the code of the rule that checks it,
#   written as a key, such as `<kbd>BSG010</kbd>`. This script reads the rules from `dyshellint --list-rules`
#   and brings `README.md` in line with them:
#
#   - a code already on a tip stays where it is, as that placement may have been
#     chosen by hand;
#   - the code of a rule that dyshellint no longer has is removed;
#   - the code of a new rule goes on the tip of its section that shares the most
#     words with the summary of the rule, and is listed so the placement can be
#     reviewed.
#
#   `README.vi.md` then gets the same codes on the same tips, matched by the
#   position of the section and of the tip in it, as both files keep the same
#   structure. With `--check`, nothing is written: the script only fails when a
#   file would change.
if ((BASH_VERSINFO[0] < 4 || (BASH_VERSINFO[0] == 4 && BASH_VERSINFO[1] < 4))); then
  printf 'This script needs Bash 4.4 or newer, found %s\n' "${BASH_VERSION}" >&2
  exit 1
fi
set -euo pipefail
shopt -s inherit_errexit

SCRIPT_DIR="$(CDPATH='' cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
REPO_DIR="$(CDPATH='' cd -P -- "${SCRIPT_DIR}/.." && pwd)"
readonly REPO_DIR
readonly SOURCE_README="${REPO_DIR}/README.md"
readonly MIRROR_READMES=("${REPO_DIR}/README.vi.md")

# Words too common to say which tip a rule belongs to.
readonly STOP_WORDS=" the and not for with that this from when which than its are use into out does any all one "

# One code at the end of a tip, and the tip before it.
readonly TRAILING_CODE='^(.*[^ ]) +<kbd>(BSG[0-9]{3})</kbd>$'

#######################################
# @description Split a tip into its text and the codes at its end.
# @arg $1 string Name of the variable that receives the text
# @arg $2 string Name of the variable that receives the codes, space-separated
# @arg $3 string Line of the tip
# @set The two variables named by the caller
#######################################
function __sync_split_into {
  local -n __sync_split_text="$1" __sync_split_codes="$2"
  local __sync_split_line="$3"
  __sync_split_codes=""
  while [[ "${__sync_split_line}" =~ ${TRAILING_CODE} ]]; do
    __sync_split_line="${BASH_REMATCH[1]}"
    __sync_split_codes="${BASH_REMATCH[2]}${__sync_split_codes:+ ${__sync_split_codes}}"
  done
  __sync_split_text="${__sync_split_line}"
}

#######################################
# @description Print one tab-separated line per rule: code, section heading,
#   summary.
# @noargs
# @stdout `<code>\t<heading>\t<summary>` per rule
# @exitcode 1 dyshellint is missing or fails
#######################################
function _list_rules {
  local listing
  listing="$(dyshellint --list-rules 2>&1)" || {
    printf 'dyshellint --list-rules failed:\n%s\n' "${listing}" >&2
    return 1
  }
  local line code="" summary=""
  while IFS= read -r line || [[ -n "${line}" ]]; do
    if [[ "${line}" =~ ^(BSG[0-9]{3})[[:space:]]+[a-z]+[[:space:]]+(.*)$ ]]; then
      code="${BASH_REMATCH[1]}"
      summary="${BASH_REMATCH[2]}"
    elif [[ -n "${code}" && "${line}" =~ ^[[:space:]]+(.+)$ ]]; then
      # The section path is printed under the rule; its last part is the heading
      printf '%s\t%s\t%s\n' "${code}" "${BASH_REMATCH[1]##*> }" "${summary}"
      code=""
    fi
  done <<< "${listing}"
}

#######################################
# @description Split a text into the lowercase words that can tell tips apart,
#   with each code span counted three times.
# @arg $1 string Name of the array that receives the words
# @arg $2 string Text
# @set The array named by the caller
#######################################
function __sync_words_into {
  local -n __sync_words_ref="$1"
  local __sync_words_text="$2"
  __sync_words_ref=()
  local __sync_words_rest="${__sync_words_text}" __sync_words_span
  while [[ "${__sync_words_rest}" =~ \`([^\`]+)\`(.*)$ ]]; do
    __sync_words_span="${BASH_REMATCH[1]}"
    __sync_words_rest="${BASH_REMATCH[2]}"
    __sync_words_ref+=("=${__sync_words_span}" "=${__sync_words_span}" "=${__sync_words_span}")
  done
  local __sync_words_lower="${__sync_words_text,,}" __sync_words_word
  local -a __sync_words_all=()
  read -r -a __sync_words_all <<< "${__sync_words_lower//[^a-z0-9_:.-]/ }"
  for __sync_words_word in ${__sync_words_all[@]+"${__sync_words_all[@]}"}; do
    ((${#__sync_words_word} > 2)) || continue
    [[ "${STOP_WORDS}" != *" ${__sync_words_word} "* ]] || continue
    __sync_words_ref+=("${__sync_words_word}")
  done
}

#######################################
# @description Count the words a rule summary shares with a tip.
# @arg $1 string Name of the variable that receives the score
# @arg $2 string Summary of the rule
# @arg $3 string Text of the tip
# @set The variable named by the caller
#######################################
function __sync_score_into {
  local -n __sync_score_ref="$1"
  local __sync_score_summary="$2" __sync_score_tip="$3"
  local -a __sync_score_tip_words=() __sync_score_summary_words=()
  __sync_words_into __sync_score_tip_words "${__sync_score_tip}"
  __sync_words_into __sync_score_summary_words "${__sync_score_summary}"
  local -A __sync_score_in_tip=()
  local __sync_score_word __sync_score_count=0
  for __sync_score_word in ${__sync_score_tip_words[@]+"${__sync_score_tip_words[@]}"}; do
    __sync_score_in_tip["${__sync_score_word}"]=1
  done
  for __sync_score_word in ${__sync_score_summary_words[@]+"${__sync_score_summary_words[@]}"}; do
    [[ -z "${__sync_score_in_tip["${__sync_score_word}"]-}" ]] || __sync_score_count=$((__sync_score_count + 1))
  done
  __sync_score_ref="${__sync_score_count}"
}

#######################################
# @description Bring the codes on the tips of the source README in line with
#   the rules, writing the new content to a file.
# @arg $1 string Rules, as `_list_rules` prints them
# @arg $2 string File that receives the new README
# @stderr One line per code added or removed
# @exitcode 1 A new rule names a section the README does not have
#######################################
function _sync_source {
  local rules output
  rules="$1"
  output="$2"

  local -A section_of=() summary_of=() known=()
  local code heading summary
  while IFS=$'\t' read -r code heading summary; do
    [[ -n "${code}" ]] || continue
    section_of["${code}"]="${heading}"
    summary_of["${code}"]="${summary}"
    known["${code}"]=1
  done <<< "${rules}"

  local -a lines=()
  mapfile -t lines < "${SOURCE_README}"

  # One pass: drop the codes of removed rules, and note where each tip and each
  # placed code is.
  local -A placed=() tips_of=()
  local index line current="" fenced=false text codes kept
  for index in "${!lines[@]}"; do
    line="${lines[index]}"
    if [[ "${line}" == '```'* ]]; then
      if [[ "${fenced}" == true ]]; then fenced=false; else fenced=true; fi
      continue
    fi
    [[ "${fenced}" == false ]] || continue
    if [[ "${line}" =~ ^##+\ (.+)$ ]]; then
      current="${BASH_REMATCH[1]}"
      continue
    fi
    [[ "${line}" == '> - '* && -n "${current}" ]] || continue
    tips_of["${current}"]+="${index} "
    __sync_split_into text codes "${line}"
    [[ -n "${codes}" ]] || continue
    kept=""
    for code in ${codes}; do
      if [[ -n "${known["${code}"]-}" ]]; then
        kept+=" <kbd>${code}</kbd>"
        placed["${code}"]=1
      else
        printf 'removed %s, which dyshellint no longer has\n' "${code}" >&2
      fi
    done
    lines[index]="${text}${kept}"
  done

  # Then place the codes of new rules, in code order.
  local best best_score score candidate sorted
  sorted="$(printf '%s\n' "${!known[@]}" | LC_ALL=C sort)"
  while IFS= read -r code; do
    [[ -z "${placed["${code}"]-}" ]] || continue
    heading="${section_of["${code}"]}"
    if [[ -z "${tips_of["${heading}"]-}" ]]; then
      printf '%s belongs to "%s", which has no tips in %s\n' "${code}" "${heading}" "${SOURCE_README##*/}" >&2
      return 1
    fi
    best="" best_score=-1
    for candidate in ${tips_of["${heading}"]}; do
      __sync_score_into score "${summary_of["${code}"]}" "${lines[candidate]}"
      if ((score > best_score)); then
        best="${candidate}"
        best_score="${score}"
      fi
    done
    lines[best]+=" <kbd>${code}</kbd>"
    printf 'added %s on line %d: %s\n' "${code}" "$((best + 1))" "${lines[best]:0:100}" >&2
  done <<< "${sorted}"

  printf '%s\n' "${lines[@]}" > "${output}"
}

#######################################
# @description Print the codes of each tip of a README, by position.
# @arg $1 string README
# @stdout `<section number> <tip number> <codes>` per tip, codes space-separated
#######################################
function _codes_by_position {
  local readme
  readme="$1"
  local line section=0 tip=0 fenced=false text codes
  while IFS= read -r line || [[ -n "${line}" ]]; do
    if [[ "${line}" == '```'* ]]; then
      if [[ "${fenced}" == true ]]; then fenced=false; else fenced=true; fi
      continue
    fi
    [[ "${fenced}" == false ]] || continue
    if [[ "${line}" =~ ^##+\  ]]; then
      section=$((section + 1))
      tip=0
      continue
    fi
    [[ "${line}" == '> - '* ]] || continue
    tip=$((tip + 1))
    __sync_split_into text codes "${line}"
    printf '%d %d %s\n' "${section}" "${tip}" "${codes}"
  done < "${readme}"
}

#######################################
# @description Give a translated README the codes of the source README, tip by
#   tip, writing the new content to a file.
# @arg $1 string Source README, already synced
# @arg $2 string Translated README
# @arg $3 string File that receives the new translation
# @exitcode 1 The two files do not have the same sections and tips
#######################################
function _sync_mirror {
  local source mirror output
  source="$1"
  mirror="$2"
  output="$3"

  local source_codes mirror_codes
  source_codes="$(_codes_by_position "${source}")"
  mirror_codes="$(_codes_by_position "${mirror}")"

  local -A codes_at=()
  local section tip codes
  local -a positions=() mirror_positions=()
  while read -r section tip codes || [[ -n "${section}" ]]; do
    codes_at["${section}:${tip}"]="${codes}"
    positions+=("${section}:${tip}")
  done <<< "${source_codes}"
  while read -r section tip codes || [[ -n "${section}" ]]; do
    mirror_positions+=("${section}:${tip}")
  done <<< "${mirror_codes}"
  if [[ "${positions[*]}" != "${mirror_positions[*]}" ]]; then
    printf '%s and %s do not have the same sections and tips\n' "${source##*/}" "${mirror##*/}" >&2
    return 1
  fi

  local line fenced=false code at_section=0 at_tip=0
  while IFS= read -r line || [[ -n "${line}" ]]; do
    if [[ "${line}" == '```'* ]]; then
      if [[ "${fenced}" == true ]]; then fenced=false; else fenced=true; fi
    elif [[ "${fenced}" == false && "${line}" =~ ^##+\  ]]; then
      at_section=$((at_section + 1))
      at_tip=0
    elif [[ "${fenced}" == false && "${line}" == '> - '* ]]; then
      at_tip=$((at_tip + 1))
      # The codes of the translation are replaced, whatever they were
      while [[ "${line}" =~ ${TRAILING_CODE} ]]; do
        line="${BASH_REMATCH[1]}"
      done
      for code in ${codes_at["${at_section}:${at_tip}"]}; do
        line+=" <kbd>${code}</kbd>"
      done
    fi
    printf '%s\n' "${line}"
  done < "${mirror}" > "${output}"
}

#######################################
# @description Sync the rule codes of every README, or check that they are.
# @arg $1 string Optional `--check`, to report instead of writing
# @exitcode 0 Every README is in sync, or has been brought in sync
# @exitcode 1 A README is out of sync under `--check`, or cannot be synced
# @exitcode 2 Wrong usage
#######################################
function _main {
  local check=false
  case "${1-}" in
    --check) check=true ;;
    "") ;;
    *)
      printf 'Usage: %s [--check]\n' "${0##*/}" >&2
      return 2
      ;;
  esac
  command -v dyshellint &> /dev/null || {
    printf 'dyshellint is required: go install gitlab.com/dynamo-tools/dyshellint/cmd/dyshellint@latest\n' >&2
    return 1
  }

  local work_dir
  work_dir="$(mktemp -d)"
  # shellcheck disable=SC2064 # expand now: work_dir is local
  trap "rm -rf -- '${work_dir}'" EXIT

  local rules
  rules="$(_list_rules)"
  _sync_source "${rules}" "${work_dir}/source"

  local -a changed=()
  cmp -s -- "${work_dir}/source" "${SOURCE_README}" || changed+=("${SOURCE_README}")
  local mirror index=0
  for mirror in "${MIRROR_READMES[@]}"; do
    index=$((index + 1))
    _sync_mirror "${work_dir}/source" "${mirror}" "${work_dir}/mirror.${index}"
    cmp -s -- "${work_dir}/mirror.${index}" "${mirror}" || changed+=("${mirror}")
  done

  if ((${#changed[@]} == 0)); then
    printf 'Rule codes are in sync\n' >&2
    return 0
  fi
  if [[ "${check}" == true ]]; then
    printf 'Rule codes are out of sync in %s; run: bash ./scripts/sync_rule_codes.sh\n' "${changed[*]##*/}" >&2
    return 1
  fi
  # Each file is replaced by a copy made in its own directory, so the rename
  # cannot cross filesystems and keeps the mode of the file it replaces.
  local target staging
  cp -- "${work_dir}/source" "${work_dir}/mirror.0"
  index=0
  for target in "${SOURCE_README}" "${MIRROR_READMES[@]}"; do
    staging="$(mktemp "$(dirname -- "${target}")/.staging.XXXXXXXX")"
    cp -p -- "${target}" "${staging}"
    cat -- "${work_dir}/mirror.${index}" > "${staging}"
    mv -f -- "${staging}" "${target}"
    index=$((index + 1))
  done
  printf 'Updated %s\n' "${changed[*]##*/}" >&2
}

_main "$@"
