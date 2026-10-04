#!/usr/bin/env bash
# @file lint_examples.sh
# @brief Lint the recommended examples of the guide
# @description
#   Extracts every `sh` code block that follows a **Recommended** label in the
#   guide, in either language, and runs dyshellint on it with the configuration
#   of this repository. Findings are reported against the line of the README the
#   example comes from.
#
#   A line right before the opening fence can steer the check of one block:
#   `<!-- lint: skip -->` leaves it out, and `<!-- lint: allow SC2145,BSG043 -->`
#   accepts those rules in it, for an example that shows them on purpose. A line
#   holding only `...` is read as `:`.
set -euo pipefail

SCRIPT_DIR="$(CDPATH='' cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
REPO_DIR="$(CDPATH='' cd -P -- "${SCRIPT_DIR}/.." && pwd)"
readonly REPO_DIR

# Rules that a snippet breaks by being a snippet rather than a file: it has no
# header, no shebang, no namespace taken from a file name and no spec; its
# `local` lines stand outside the function they would live in; the variables it
# reads are set, and the libraries it calls are loaded, somewhere else; and it is
# neither a library (BSG038, BSG055) nor a script that has loaded dybatpho
# (BSG046). SC2312 is an info-level check the guide only asks to consider, and
# BSG049 guards Bash 4.3, older than the 4.4 that the examples target.
readonly -a SNIPPET_RULES=(
  BSG004 BSG020 BSG021 BSG022 BSG030 BSG031 BSG033 BSG037 BSG038 BSG046 BSG049
  BSG051 BSG052 BSG053 BSG055 BSG060 BSG073
  SC1090 SC1091 SC2034 SC2154 SC2168 SC2312 SC2317
)

#######################################
# @description Write the recommended blocks of one README into a directory.
# @arg $1 string README to read
# @arg $2 string Directory that receives one file per block
# @arg $3 string Map file that receives `<file> <readme> <fence line> <allowed rules>` per block
# @stdout Nothing
#######################################
function _extract_blocks {
  local readme out_dir map_file
  readme="$1"
  out_dir="$2"
  map_file="$3"

  local line kind="" skip=false allow="-" block_allow="-" in_block=false fence=0 number=0 block="" index
  while IFS= read -r line || [[ -n "${line}" ]]; do
    number=$((number + 1))
    if [[ "${in_block}" == true ]]; then
      if [[ "${line}" == '```' ]]; then
        in_block=false
        local -a mapped=()
        mapfile -t mapped < "${map_file}"
        printf -v index '%04d' "${#mapped[@]}"
        local extension=sh
        [[ "${block}" != *'@test '* ]] || extension=bats
        printf '%s' "${block}" > "${out_dir}/${index}.${extension}"
        printf '%s %s %d %s\n' "${index}.${extension}" "${readme}" "${fence}" "${block_allow}" >> "${map_file}"
      elif [[ "${line}" =~ ^([[:space:]]*)\.\.\.$ ]]; then
        block+="${BASH_REMATCH[1]}:"$'\n'
      else
        block+="${line}"$'\n'
      fi
      continue
    fi
    case "${line}" in
      '**Recommended**' | '**Nên dùng**') kind=good ;;
      '**Discouraged**' | '**Không nên dùng**') kind=bad ;;
      '#'*) kind="" ;;
      '<!-- lint: skip -->')
        skip=true
        continue
        ;;
      '<!-- lint: allow '*' -->')
        allow="${line#'<!-- lint: allow '}"
        allow="${allow%' -->'}"
        continue
        ;;
      '```sh')
        if [[ "${kind}" == good && "${skip}" == false ]]; then
          in_block=true
          fence="${number}"
          block_allow="${allow}"
          block=""
        fi
        ;;
      *) ;;
    esac
    skip=false
    allow="-"
  done < "${readme}"
}

#######################################
# @description Lint the recommended examples of every README given.
# @arg $@ string READMEs to check, `README.md` and `README.vi.md` by default
# @stdout Findings, as `<readme>:<line>:<column>: <severity>: <message>`
# @exitcode 0 No finding
# @exitcode 1 At least one finding
#######################################
function _main {
  local -a readmes=("$@")
  ((${#readmes[@]} > 0)) || readmes=("${REPO_DIR}/README.md" "${REPO_DIR}/README.vi.md")

  command -v dyshellint > /dev/null || {
    printf 'dyshellint is required: go install gitlab.com/dynamo-tools/dyshellint/cmd/dyshellint@latest\n' >&2
    return 1
  }

  local work_dir
  work_dir="$(mktemp -d)"
  # shellcheck disable=SC2064 # expand now: work_dir is local
  trap "rm -rf -- '${work_dir}'" EXIT
  cp -- "${REPO_DIR}/.shellcheckrc" "${REPO_DIR}/.editorconfig" "${work_dir}/"
  local map_file="${work_dir}/map"
  : > "${map_file}"

  local readme
  for readme in "${readmes[@]}"; do
    _extract_blocks "${readme}" "${work_dir}" "${map_file}"
  done

  local -A source_of=() fence_of=() allowed_in=()
  local -a block_files=()
  local block_file block_readme block_fence block_allow
  while read -r block_file block_readme block_fence block_allow || [[ -n "${block_file}" ]]; do
    block_files+=("${block_file}")
    source_of["${block_file}"]="${block_readme#"${REPO_DIR}"/}"
    fence_of["${block_file}"]="${block_fence}"
    allowed_in["${block_file}"]=",${block_allow},"
  done < "${map_file}"

  ((${#block_files[@]} > 0)) || return 0

  local excluded report finding count=0
  printf -v excluded '%s,' "${SNIPPET_RULES[@]}"
  excluded="${excluded%,}"
  # dyshellint exits non-zero on any finding; the findings are read below
  report="$(cd -- "${work_dir}" && dyshellint --exclude-rules "${excluded}" -- "${block_files[@]}")" || true
  while IFS= read -r finding; do
    [[ "${finding}" =~ ^(\./)?([0-9]+\.(sh|bats)):([0-9]+):(.*\[([A-Z]+[0-9]+)\].*)$ ]] || continue
    block_file="${BASH_REMATCH[2]}"
    [[ "${allowed_in["${block_file}"]}" != *",${BASH_REMATCH[6]},"* ]] || continue
    printf '%s:%d:%s\n' "${source_of["${block_file}"]}" \
      "$((fence_of["${block_file}"] + BASH_REMATCH[4]))" "${BASH_REMATCH[5]}"
    count=$((count + 1))
  done <<< "${report}"

  printf '%d finding(s) in %d example(s)\n' "${count}" "${#source_of[@]}" >&2
  ((count == 0))
}

_main "$@"
