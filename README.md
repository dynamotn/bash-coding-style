# bash-coding-style

[English](README.md) | [Tiếng Việt](README.vi.md)

The style guide is not absolute, break it if necessary. The aim of this style guide is to reduce the psychological barriers to writing Bash scripts and to provide answers to common problems encountered when writing Bash scripts. Bash scripts are often delicate, difficult to maintain, and can easily become disliked. However, writing Bash scripts is sometimes necessary, so this style guide has been prepared.

When in doubt, prioritize consistency. By using a single style consistently throughout the codebase, you can focus on other (more important) issues. Consistency also allows for automation. In many cases, the rule of `maintain consistency` means `choose one option and stop worrying about it`. The potential value of allowing flexibility on these points is outweighed by the cost of people debating them. However, there are limits to consistency. Consistency is a good factor for making decisions when there is no clear technical argument or long-term direction. On the other hand, consistency should not be used to justify continuing with an outdated style when there are clear advantages to a new one.

## Table of Contents

<!-- toc -->

- [Introduction](#introduction)
  - [Supported library](#supported-library)
  - [Linter](#linter)
- [Background](#background)
  - [Which Shell to Use](#which-shell-to-use)
  - [Bash Version](#bash-version)
  - [When to Use Shell](#when-to-use-shell)
- [Shell Files and Interpreter Invocation](#shell-files-and-interpreter-invocation)
  - [File Extensions](#file-extensions)
  - [SUID/SGID](#suidsgid)
- [Environment](#environment)
  - [Script Invocation](#script-invocation)
  - [Script Argument Control](#script-argument-control)
  - [Debug and Dry-run Mode](#debug-and-dry-run-mode)
  - [STDOUT and STDERR](#stdout-and-stderr)
  - [Common Function Scripts](#common-function-scripts)
  - [Ambient Environment](#ambient-environment)
  - [Configuration Files](#configuration-files)
  - [Library Side Effects](#library-side-effects)
  - [Interactive Input](#interactive-input)
- [Naming Conventions](#naming-conventions)
  - [Function Names](#function-names)
  - [Variable Names](#variable-names)
  - [Local Names in Nameref and Callback Functions](#local-names-in-nameref-and-callback-functions)
- [Comments](#comments)
  - [File Header](#file-header)
  - [Function Comments](#function-comments)
  - [Implementation Comments](#implementation-comments)
  - [TODO Comments](#todo-comments)
- [Formatting](#formatting)
  - [Tabs and Spaces](#tabs-and-spaces)
  - [Line Length and Long Strings](#line-length-and-long-strings)
  - [Pipelines](#pipelines)
  - [Control Flow](#control-flow)
  - [Case statement](#case-statement)
  - [Variable Expansion](#variable-expansion)
  - [Quoting](#quoting)
  - [Function Declaration](#function-declaration)
- [Features and Bugs](#features-and-bugs)
  - [Use ShellCheck](#use-shellcheck)
  - [Command Substitution](#command-substitution)
  - [Validation in Command Substitution](#validation-in-command-substitution)
  - [Test Expression](#test-expression)
  - [Testing Strings](#testing-strings)
  - [Regular Expressions](#regular-expressions)
  - [Wildcard Expansion of Filenames](#wildcard-expansion-of-filenames)
  - [Locale and Collation](#locale-and-collation)
  - [Eval is Evil](#eval-is-evil)
  - [Secrets and Credentials](#secrets-and-credentials)
  - [Building Structured Output](#building-structured-output)
  - [Printing Data](#printing-data)
  - [Here Documents](#here-documents)
  - [Arrays](#arrays)
  - [Associative Arrays](#associative-arrays)
  - [Pipes to While](#pipes-to-while)
  - [Process Substitution](#process-substitution)
  - [For Loops](#for-loops)
  - [Local Variables](#local-variables)
  - [Arithmetic](#arithmetic)
  - [Portability](#portability)
  - [Comparing Versions](#comparing-versions)
- [Calling Commands](#calling-commands)
  - [Checking Return Values](#checking-return-values)
  - [Errexit in Conditions](#errexit-in-conditions)
  - [Error Handling](#error-handling)
  - [Exit Codes](#exit-codes)
  - [Builtin Commands vs External Commands](#builtin-commands-vs-external-commands)
  - [Signal Handlers](#signal-handlers)
  - [Child Processes](#child-processes)
  - [End of Options](#end-of-options)
  - [Network Requests](#network-requests)
  - [Remote Commands](#remote-commands)
  - [Deprecated Commands](#deprecated-commands)
- [Script Stabilization](#script-stabilization)
  - [Writing Rerunnable Scripts](#writing-rerunnable-scripts)
  - [Check State Before Changing](#check-state-before-changing)
  - [Safely Creating Temporary Files](#safely-creating-temporary-files)
  - [Locks](#locks)
  - [Atomic Writes](#atomic-writes)
  - [Destructive Commands](#destructive-commands)
- [Testing](#testing)
  - [Strict Output Assertions](#strict-output-assertions)
  - [Test Isolation](#test-isolation)
- [References](#references)

<!-- tocstop -->

## Introduction

This style guide provides guidelines for writing Bash scripts. It is based on the [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html) and [icy/bash-coding-style](https://github.com/icy/bash-coding-style), with some custom rules. Items that are intentionally made custom are explicitly marked as `(custom)`.

The following symbols are used:

| Symbol | Meaning |
| ------ | ------- |
| ✔️ SHOULD | Recommended. |
| ❌ AVOID | Not recommended. Make an effort to avoid it. |
| ⚠️ CONSIDER | Consider if possible. It may be applied depending on the situation. |

### Supported library

To help adhere to the style guide, I wrote a Bash library [dybatpho](https://github.com/dynamotn/dybatpho). By using this library, some rules in this style guide have been guaranteed. Items that are supported are explicitly marked as `(dybatpho)`

```sh
DYBATPHO_DIR="<path to dybatpho>"
. "${DYBATPHO_DIR}/init.sh"
```

### Linter

[dyshellint](https://github.com/dynamotn/dyshellint) ([GitLab](https://gitlab.com/dynamo-tools/dyshellint)) checks a script against this guide. It orchestrates the whole check: the rules that are specific to this guide — namespaces, sh-docs headers, file layout, the dybatpho conventions — plus [ShellCheck](https://www.shellcheck.net/) with a `.shellcheckrc` and [shfmt](https://github.com/mvdan/sh) with the options of the Formatting chapter. ✔️ SHOULD and ❌ AVOID rules are reported as errors, ⚠️ CONSIDER rules as warnings.

```sh
go install gitlab.com/dynamo-tools/dyshellint/cmd/dyshellint@latest

# A repository, or one file
dyshellint ./scripts
dyshellint --format json ./scripts/deploy.sh

# Every rule, with the heading of this guide it comes from
dyshellint --list-rules

# A buffer that has not been saved, which is what an editor lints
cat script.sh | dyshellint --stdin-filename script.sh -
```

Every rule carries a code: `BSG###` for a rule of this guide, `SC####` for a ShellCheck finding, and `FMT001` for a formatting difference. Any of them can be turned off for a run with `--exclude-rules`, and a ShellCheck finding can be silenced in place with a `# shellcheck disable=SCXXXX` comment that says why. A tip that the linter checks ends with the code of the rule that checks it, such as `BSG010`, so a finding leads straight to the sentence it enforces. [`scripts/sync_rule_codes.sh`](scripts/sync_rule_codes.sh) keeps those codes in line with `dyshellint --list-rules`: it puts the code of a new rule on the tip of its section that matches it best, for review, removes the code of a rule that is gone, and copies the codes to the translation; `--check`, which the hook and CI run, only reports.

The [`.shellcheckrc`](.shellcheckrc) and [`.editorconfig`](.editorconfig) of this repository are the configuration this guide asks for, and are meant to be copied into a project. `dyshellint` reads the `.shellcheckrc` of the project it checks, and also ships a [nvim-lint](https://github.com/mfussenegger/nvim-lint) definition for Neovim.

The recommended examples of this guide are held to it as well. [`scripts/lint_examples.sh`](scripts/lint_examples.sh) extracts every `sh` block under a **Recommended** label, in both languages, runs dyshellint on it, and reports each finding against the line of the README. It leaves out only the rules that a snippet breaks by being a snippet: no file header, no shebang, variables set somewhere else. A block that shows an exception on purpose names it on the line before its fence, `<!-- lint: allow BSG040 -->`, and `<!-- lint: skip -->` leaves a block out. The same check runs as a [prek](https://github.com/j178/prek) hook from [`.pre-commit-config.yaml`](.pre-commit-config.yaml), and in CI.

```sh
bash ./scripts/lint_examples.sh
prek run --all-files
```

## Background

### Which Shell to Use

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Use Bash for all scripts
> - ✔️ SHOULD: Write `#!/usr/bin/env bash` at the top of the script. (custom) `BSG030`
> - ✔️ SHOULD: Use `set -euo pipefail` for shell option settings. (custom) `BSG031`
> - ✔️ SHOULD: After source [dybatpho](https://github.com/dynamotn/dybatpho), can ignore to `set -euo pipefail`. (dybatpho)
> - ⚠️ CONSIDER: If using other shells, explain the reason in comments. (custom)

Use Bash. Restricting all executable shell scripts to `bash` ensures a consistent shell installed on all machines.

Executable files should start with `#!/usr/bin/env bash` and minimal flags. Using `#!/usr/bin/env bash` provides several notable advantages: works across environments (like Fedora or Termux), although slight performance hit from invoking env to search PATH.

Using `set` for shell option settings ensures that even if the script is called with `bash script_name`, its functionality is not impaired. `set -euo pipefail` automatically detects errors early and terminates the script if an error occurs. `set -e` terminates the script if an error occurs. `set -u` triggers an error when referencing undefined variables. `set -o pipefail` terminates the script if an error occurs in the middle of a pipeline. Add `-E` only when the script installs its own `ERR` trap, so that functions and subshells inherit it; `dybatpho::register_common_handlers` turns it on itself.

**Recommended**

```sh
#!/usr/bin/env bash
set -euo pipefail
# If not used dybatpho

#!/usr/bin/env bash
DYBATPHO_DIR="<path to dybatpho>"
if [[ ! -f "${DYBATPHO_DIR}/init.sh" ]]; then
  printf 'dybatpho not found in %s\n' "${DYBATPHO_DIR}" >&2
  exit 1
fi
. "${DYBATPHO_DIR}/init.sh"
# If used dybatpho
```

**Discouraged**

```sh
#!/bin/bash
# Missing set
# Wrong shebang

#!/bin/bash -euo pipefail
# Use -euo after shebang, it is disabled when using `bash ./script.sh`.
# Wrong shebang
```

### Bash Version

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Target Bash 4.4 or newer, and say so in the README of the project. (custom)
> - ✔️ SHOULD: Check `BASH_VERSINFO` at the top of an entrypoint, before anything that needs a newer feature, and stop with a message that names the version found `BSG099`
> - ✔️ SHOULD: Write the version that introduced a feature next to a rule that depends on it, when it is newer than the target
> - ❌ AVOID: Do not assume the `bash` on `PATH` is new: macOS still ships Bash 3.2 as `/bin/bash`
> - ❌ AVOID: Do not compare the version as `major >= X && minor >= Y`, which refuses Bash 6.0 for a 5.2 floor, nor `BASH_VERSION` as a string, where `5.10` sorts before `5.2` `BSG116`

The guide relies on features that older releases do not have: namerefs (`local -n`, 4.3), `mapfile -d` and `local -` (4.4), and empty arrays that `set -u` accepts (4.4). On Bash 3.2 a script written this way does not fail where the feature is missing; it fails later, with `invalid option` or `unbound variable`, far from the cause. One check at the top turns that into a message the user can act on, such as installing a newer Bash with Homebrew, whose `bash` `#!/usr/bin/env bash` then finds first.

dybatpho checks for the Bash version it needs when it is sourced. (dybatpho)

**Recommended**

```sh
#!/usr/bin/env bash
# Bash 3.2 still parses this, so the message is what the user sees
if ((BASH_VERSINFO[0] < 4 || (BASH_VERSINFO[0] == 4 && BASH_VERSINFO[1] < 4))); then
  printf 'This script needs Bash 4.4 or newer, found %s\n' "${BASH_VERSION}" >&2
  exit 1
fi
set -euo pipefail
```

**Discouraged**

```sh
#!/usr/bin/env bash
set -euo pipefail
# On Bash 3.2: `local: -n: invalid option`, then `mapfile: command not found`
local -n result="$1"
mapfile -d '' -t files < <(command find . -print0)
```

A floor of 5.2 holds for every major above 5 whatever its minor, and for 5 only from minor 2 on. Testing both numbers with `&&` drops the first half: Bash 6.0 has a minor of 0 and is refused. Write the major comparison and the boundary case separately, as in the check above.

**Discouraged**

```sh
# Refuses Bash 6.0: the minor 0 is below 2
((BASH_VERSINFO[0] >= 5 && BASH_VERSINFO[1] >= 2)) || exit 1
# Text comparison: "5.10.0" < "5.2"
[[ "${BASH_VERSION}" > "5.2" ]] || exit 1
```

### When to Use Shell

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Use only for small utilities or simple wrapper scripts
> - ✔️ SHOULD: If you want to write a few lines of script in CI like GitHub Actions, Gitlab CI, create a shell script instead of embedding it in a yaml file. (custom)
> - ✔️ SHOULD: If calling the same process with different parameters in multiple workflows, create a shell script. (custom)
> - ⚠️ CONSIDER: If performance is critical, consider other languages besides shell
> - ⚠️ CONSIDER: If writing a script over 100 lines or using complex control flow logic, rewrite it in a more structured language as soon as possible. Anticipate that the script will grow. Rewriting early can avoid a time-consuming rewrite later
> - ⚠️ CONSIDER: When evaluating code complexity (e.g., deciding whether to switch languages), consider whether the code can be easily maintained by someone other than the original author

Shell is a suitable choice for tasks that mainly involve calling other utilities and performing relatively few data manipulations. Although shell scripts are not a development language, they are used to create various utility scripts in CI or run on end-user's machines. This style guide does not suggest extensive deployment of shell scripts but acknowledges their use.

Use shell scripts for small utilities or simple wrapper scripts. In particular, use shell scripts for "multi-line processing" or "reusable processing in multiple workflows" in GitHub Actions or Gitlab CI. While Bash makes it easy to handle text, it is not suitable for overly complex processing or language/app-specific processing. Consider using a structured language in such cases.

## Shell Files and Interpreter Invocation

### File Extensions

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Use the `.sh` extension for scripts that are library scripts. `chmod -x` for them `BSG037`
> - ✔️ SHOULD: Do not use extensions for scripts that are in PATH. `chmod +x` for them
> - ✔️ SHOULD: Use the `.sh` extension for scripts that aren't in PATH and are able to called from CLI.  `chmod +x` for them (custom)

Executable files should either have a `.sh` extension (strongly recommended) or no extension. Scripts sourced from outside must have a `.sh` extension and should not be made executable.

### SUID/SGID

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Use `sudo` if you need to elevate privileges
> - ✔️ SHOULD: Clear the loader and interpreter variables before a privileged wrapper hands over with `exec`: `LD_PRELOAD`, `LD_LIBRARY_PATH`, `LD_AUDIT`, `BASH_ENV`, `ENV`, `PYTHONPATH`, `PERL5LIB`, `RUBYLIB`, `NODE_PATH`, or start the program under `env -i`
> - ❌ AVOID: SUID and SGID are prohibited
> - ❌ AVOID: `sudo` is also prohibited in CI scripts. (custom) `BSG035`

SUID and SGID are prohibited in shell scripts. Shell has many security issues, making it nearly impossible to ensure sufficient safety to allow SUID/SGID. Although bash makes SUID execution difficult, it is possible on some platforms, so it is explicitly prohibited. If privilege escalation is needed, use `sudo`.

As long as scripts are executed in CI, `sudo`, SUID, and SGID are unnecessary and therefore prohibited.

**Recommended**

<!-- lint: allow BSG035 -->
```sh
# Use sudo when calling (Except in CI)
sudo ./foo.sh
```

**Discouraged**

```sh
# Switching to su or root user inside the script
```

A wrapper that runs through `sudo`, a systemd unit or an SSH `ForceCommand` and then starts another program passes its environment on. `LD_PRELOAD` loads a library of the caller's choosing into that program, `BASH_ENV` runs a file before any Bash script it starts, and `PYTHONPATH` swaps the modules of a Python helper. Clearing them, or starting from an empty environment, keeps the helper running the code it was installed with.

**Recommended**

```sh
unset LD_PRELOAD LD_LIBRARY_PATH LD_AUDIT BASH_ENV ENV PYTHONPATH PERL5LIB RUBYLIB NODE_PATH
exec /usr/libexec/app/helper "$@"
```

```sh
# Stronger: nothing is inherited but what is named
exec env -i HOME="${HOME}" PATH=/usr/bin:/bin /usr/libexec/app/helper "$@"
```

**Discouraged**

```sh
# Run through sudo: LD_PRELOAD and BASH_ENV reach the helper
exec /usr/libexec/app/helper "$@"
```

## Environment

### Script Invocation

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Invoke scripts as `bash ./script.sh`, or through their entrypoint name when they are in PATH
> - ✔️ SHOULD: Quote every argument that may contain spaces
> - ❌ AVOID: Do not invoke a runnable script with `.` or `source`. Reserve those for library scripts. (custom)

Calling a script with `bash ./script.sh` guarantees the interpreter regardless of the file mode, and keeps the options set inside the script from leaking into the caller. `source`-ing a runnable script runs it in the current shell, so a failing `exit` kills the interactive session instead of the script.

**Recommended**

```sh
bash ./scripts/test.sh --all
bash ./scripts/docker.sh --log-level debug "${identity}"
```

**Discouraged**

```sh
# Depends on the executable bit and on the shebang being honoured
./scripts/test.sh --all

# Runs in the caller's shell, an exit inside kills the session
. ./scripts/test.sh --all
```

### Script Argument Control

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Take every argument as a named option in `--option value` form
> - ✔️ SHOULD: Declare the interface of a script in a `_spec_<entrypoint>` function using `dybatpho::opts::*`, and run it with `dybatpho::generate_from_spec "_spec_<entrypoint>" "$@"`. (dybatpho) `BSG051`
> - ✔️ SHOULD: Name the variable that receives an option in `UPPERCASE`, and give every optional one a default with `init:=`. (custom)
> - ✔️ SHOULD: Collect leftover positional arguments into one array, declared as the argument sink of `dybatpho::opts::setup`
> - ✔️ SHOULD: Declare the arguments of a function with `dybatpho::expect_args name... -- "$@"` instead of reading `$1`, `$2` by hand. (dybatpho) `BSG050`
> - ✔️ SHOULD: Always offer `--help`, through `dybatpho::opts::disp` and `dybatpho::generate_help`. (dybatpho) `BSG052`
> - ❌ AVOID: Do not take bare positional values such as `script.sh value1 value2` for anything but a list of the same kind of item
> - ❌ AVOID: Do not define an option that only has a single-letter name

A named option documents itself at the call site: `--dry-run false` says what it does, `false` on its own does not. Declaring the interface as a spec keeps parsing, defaulting, validation and the help text in one place, and gives every script in the repository the same command line behaviour.

Inside a function the same rule applies one level down. `dybatpho::expect_args` names the parameters, fails loudly when the caller passes too few, and doubles as the function's documentation.

**Recommended**

```sh
#######################################
# @description Spec of test.sh
#######################################
function _spec_main {
  dybatpho::opts::setup "Test the dotfiles setup" MAIN_ARGS action:"_main"
  dybatpho::opts::flag "Run all tests" ALL --all -a on:true off:false init:="false"
  dybatpho::opts::param "Log level" LOG_LEVEL --log-level -l init:="info" \
    validate:"dybatpho::validate_log_level \$OPTARG"
  dybatpho::opts::disp "Show help" --help -h action:"dybatpho::generate_help _spec_main"
}

dybatpho::generate_from_spec _spec_main "$@"
```

```sh
#######################################
# @description Install tool using dytoy
# @arg $1 string Name of tool
#######################################
function misc::install_tool {
  local name
  dybatpho::expect_args name -- "$@"
  dybatpho::is command "${name}" || dybatpho::dry_run dytoy -t "${name}"
}
```

**Discouraged**

```sh
# Positional arguments, no defaults, no help, no validation
name=$1
dry_run=$2

# Hand-rolled parsing that every script reimplements slightly differently
while [[ $# -gt 0 ]]; do
  case "$1" in
    -a) ALL=true ;;
  esac
  shift
done
```

### Debug and Dry-run Mode

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Let the caller pick the verbosity with a `--log-level` option bound to `LOG_LEVEL`, validated by `dybatpho::validate_log_level`. (dybatpho)
> - ✔️ SHOULD: Turn command tracing on with `dybatpho::start_trace` rather than writing `set -x` inline, and close it with `dybatpho::end_trace`. (dybatpho) `BSG034`
> - ✔️ SHOULD: Run every command that changes state through `dybatpho::dry_run`, so a dry run reports the command instead of running it. (dybatpho) `BSG095`
> - ✔️ SHOULD: Prefer the dry-run mode a tool provides itself, such as `chezmoi diff` or `kubectl --dry-run=server`, over echoing the command
> - ✔️ SHOULD: Send every side effect through the dry-run wrapper in a script that offers dry-run: downloads, writes, deletes, package and service changes. (dybatpho)
> - ❌ AVOID: Do not perform a side effect directly in a script that offers dry-run, even a "harmless" download or a cache write
> - ⚠️ CONSIDER: Make dry run the default for a script whose real run is destructive. (custom)

A script that can be asked what it *would* do is a script people are willing to run on a machine they care about. Wrapping the state-changing command, rather than branching around it, keeps the dry-run path and the real path identical up to the last step, so the dry run exercises the same conditions and the same arguments.

**Recommended**

```sh
# The wrapper decides whether to run or to report
dybatpho::dry_run mv -- "${temp_file}" "${output_path}"
dybatpho::dry_run chmod +x -- "${output_path}"

# Reading DRY_RUN directly is fine when a whole block must be skipped
if dybatpho::is true "${DRY_RUN}"; then
  dybatpho::info "Would download ${url}"
  return 0
fi

# Tracing, scoped
dybatpho::start_trace
do_something
dybatpho::end_trace
```

**Discouraged**

```sh
# Tracing that is never turned off, and cannot be controlled by the caller
set -x

# Duplicated logic: the dry-run branch drifts away from the real one
if [[ "$DRY_RUN" == "true" ]]; then
  echo "mv $temp_file $output_path"
else
  mv "$temp_file" "$output_path"
fi
```

A dry run is only worth anything if it changes nothing. One direct `curl -o`, `rm` or `systemctl` among wrapped commands makes `--dry-run` a lie: the user trusts it, and the one side effect it did not report happens anyway.

**Recommended**

```sh
dybatpho::dry_run curl --fail -sSL "${url}" -o "${target}"
dybatpho::dry_run rm -f -- "${old_version}"
dybatpho::dry_run systemctl --user restart app.service
```

**Discouraged**

```sh
# --dry-run still downloads and writes the file
curl --fail -sSL "${url}" -o "${target}"
dybatpho::dry_run systemctl --user restart app.service
```

### STDOUT and STDERR

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: All error and fatal messages should go to `STDERR` `BSG036`
> - ✔️ SHOULD: Use `LOG_LEVEL` variable to control logging level with 6 levels: trace, debug, info, warn, error, fatal. (custom)
> - ✔️ SHOULD: Suppress all unnecessary messages to `/dev/null`. (custom)
> - ✔️ SHOULD: Use logging library from [dybatpho](https://github.com/dynamotn/dybatpho) to output messages for better logging. (dybatpho)
> - ✔️ SHOULD: Keep the standard output of a function whose output is captured for its result alone: send progress, paths and notices to `STDERR` or `/dev/null`
> - ✔️ SHOULD: Send both streams to one place with `&>` and `&>>`: `cmd &> /dev/null`, `cmd &>> "${log}"`
> - ❌ AVOID: Do not call a helper that prints to `STDOUT` from a function whose output a caller captures or pipes into a file
> - ❌ AVOID: Do not mix `&>` with `> file 2>&1` in one codebase, and never write `2>&1 > file`, which still sends errors to the terminal `BSG122`

**Recommended**

```sh
# error messages to stderr
echo "Error: Unable to do_something" >&2

# log level default is info
LOG_LEVEL=info

# suppress unnecessary messages
curl -fsSL --max-time 30 "${url}" 2> /dev/null

# use dybatpho
dybatpho::error "Unable to do_something"
dybatpho::debug "var_1 is ${var_1}"
dybatpho::start_trace
do_something
```

**Discouraged**

```sh
# error messages to stdout
echo "Error: Unable to do_something"

# show unnecessary messages
grep -rn "abc" README.md || echo "Error: README.md has no 'abc' word"
```

When a caller writes `value="$(fn)"` or `fn | store`, everything on standard output is the result. A helper inside `fn` that prints the directory it created, or a progress line, becomes part of the value: a cached entry that starts with a path, an archive path followed by `Packaging ...`.

**Recommended**

```sh
function cache::set {
  local key
  dybatpho::expect_args key -- "$@"
  dybatpho::ensure_dir "${CACHE_DIR}" > /dev/null
  cat > "${CACHE_DIR}/${key}"
}

function release::package {
  printf 'Packaging %s\n' "${name}" >&2
  printf '%s\n' "${archive}"
}
```

**Discouraged**

```sh
function release::package {
  # The caller captures the archive path, and gets the progress line with it
  printf 'Packaging %s\n' "${name}"
  printf '%s\n' "${archive}"
}
archive="$(release::package)"
```

Redirections apply from left to right. `> file 2>&1` points standard output at the file, then standard error at the same place; `2>&1 > file` points standard error at the terminal first and only then moves standard output, so errors still reach the screen. `&>` says "both" in one operator and cannot be written in the wrong order.

**Recommended**

```sh
command -v jq &> /dev/null
backup::run &>> "${LOG_FILE}"
```

**Discouraged**

```sh
# Errors still go to the terminal: 2>&1 copied it before > moved stdout
backup::run 2>&1 > "${LOG_FILE}"
```

### Common Function Scripts

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Use `.` to invoke common functions `BSG032`
> - ✔️ SHOULD: Put common functions as libraries in `lib` sub-folder
> - ✔️ SHOULD: Guard a library against being sourced a second time before it declares `readonly` constants `BSG038`
> - ✔️ SHOULD: Locate a library from inside it with `${BASH_SOURCE[0]}` `BSG039`
> - ✔️ SHOULD: Check that a computed library path exists before sourcing it, and say how to get the library when it does not `BSG096`
> - ❌ AVOID: Do not declare `readonly` at the top level of a library that may be sourced twice
> - ❌ AVOID: Do not use `$0` inside a library: it names the script that sourced it `BSG039`
> - ❌ AVOID: Do not source a computed path unchecked
> - ❌ AVOID: Do not rely on the directory of a script that may be read from standard input, `bash -c` or a process substitution: it has none
> - ⚠️ CONSIDER: Resolve the directory of a script with `CDPATH='' cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd` when it must run where `realpath` is missing, such as macOS before 13

When calling common functions, use `.` instead of `source`. This is because `.` is POSIX compliant.

**Recommended**

```sh
. "$(dirname "${BASH_SOURCE[0]}")/lib/functions.sh"
```

**Discouraged**

```sh
# Use source
source "$(dirname "${BASH_SOURCE[0]}")/lib/functions.sh"
```

A library is easily sourced twice — by the script and by another library it loads. The second `readonly NAME=...` fails with `NAME: readonly variable`, which `set -e` turns into an exit. A guard on a variable the library sets makes the second source do nothing.

**Recommended**

```sh
# scripts/lib/net.sh
[[ -z "${__NET_LOADED-}" ]] || return 0
__NET_LOADED=1
readonly NET_TIMEOUT=10
```

**Discouraged**

```sh
# scripts/lib/net.sh: a second `.` stops the script
readonly NET_TIMEOUT=10
```

`$0` is the name of the running script, so in a library it points at whoever sourced it, and every path built from it is relative to the wrong directory. `${BASH_SOURCE[0]}` is the file the current code was read from.

**Recommended**

```sh
# scripts/lib/net.sh
NET_LIB_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
. "${NET_LIB_DIR}/http.sh"
```

**Discouraged**

```sh
# scripts/lib/net.sh: $0 is the caller, so this looks for http.sh next to it
NET_LIB_DIR="$(dirname "$0")"
. "${NET_LIB_DIR}/http.sh"
```

The directory of a script is only known when the script is a file. `curl ... | bash`, `bash -c "$(< script.sh)"` and `bash <(...)` give `BASH_SOURCE[0]` a value that is empty, `bash` or `/dev/fd/63`, and every path built from it points nowhere. A script that loads files next to it therefore has to be run as a file, and should say so when it is not. `realpath` resolves the directory in one call, but it is not on macOS before 13; `cd -P` and `pwd` are builtins and resolve the same symlinks.

**Recommended**

```sh
SCRIPT_DIR="$(CDPATH='' cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
if [[ ! -f "${SCRIPT_DIR}/lib/net.sh" ]]; then
  echo "Run this script from a clone, not from a pipe: ${SCRIPT_DIR}/lib/net.sh is missing" >&2
  exit 1
fi
```

**Discouraged**

```sh
# Run as `curl ... | bash`, BASH_SOURCE[0] is empty and SCRIPT_DIR is the current directory
SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
. "${SCRIPT_DIR}/lib/net.sh"
```

A submodule that was never initialised, or a clone made without it, leaves the library missing. `.` on a missing file prints `No such file or directory` and, without `set -e`, the script carries on and fails later on a function that does not exist. A check with a message turns that into one line telling the user what to run.

**Recommended**

```sh
if [[ ! -f "${SCRIPT_DIR}/lib/dybatpho/init.sh" ]]; then
  echo "dybatpho is missing. Run: git submodule update --init scripts/lib/dybatpho" >&2
  exit 1
fi
# shellcheck source=lib/dybatpho/init.sh
. "${SCRIPT_DIR}/lib/dybatpho/init.sh"
```

**Discouraged**

```sh
# Missing submodule: "No such file", then "command not found" further down
. "${SCRIPT_DIR}/lib/dybatpho/init.sh"
```

### Ambient Environment

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Clear or pin the inherited variables a library depends on, in the narrowest scope: `GIT_DIR`, `FORCE_COLOR`, `CDPATH`, `IFS`, `TMPDIR`
> - ✔️ SHOULD: Read an inherited setting on purpose: document it with `@env` and validate it
> - ✔️ SHOULD: Set `PATH` to fixed system directories at the top of a script that runs with elevated privileges, before its first external command
> - ❌ AVOID: Do not assume that a variable you never set is unset
> - ❌ AVOID: Do not put `.`, an empty element (`::`, or a leading or trailing `:`) or a world-writable directory such as `/tmp` in `PATH` `BSG114`

A script inherits every exported variable of the shell that started it. `CDPATH` makes `cd dir` print a path and go somewhere else; a custom `IFS` changes how every unquoted expansion splits; `GIT_DIR` points every git command at another repository; `FORCE_COLOR` puts escape codes into captured output. A library that depends on any of these has to set it, not hope.

**Recommended**

```sh
# cd prints nothing and goes where the argument says
dir="$(CDPATH='' cd -- "${relative}" && pwd -P)"

# A git call that has to act on this directory only
env -u GIT_DIR -u GIT_WORK_TREE -u GIT_INDEX_FILE git -C "${repo}" status --porcelain
```

**Discouraged**

```sh
# With CDPATH set, the captured path is printed twice or names another directory
dir="$(cd "${relative}" && pwd)"
```

An empty element of `PATH` means the current directory, exactly like `.`: with `PATH=":/usr/bin"`, a file called `ls` in the directory the script was started from runs instead of `/usr/bin/ls`. A world-writable directory lets any user plant a `grep` or an `rm` there. A script run through `sudo` inherits whatever `PATH` the policy lets through, so it sets its own.

**Recommended**

```sh
# A script run as root: only system directories, before the first external command
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export PATH

# Extending PATH without creating an empty element when it was unset
PATH="${HOME}/.local/bin${PATH:+:${PATH}}"
```

**Discouraged**

```sh
# The current directory first: a planted ./ls or ./grep wins
PATH=".:${PATH}"
# A leading empty element is the current directory too
PATH=":${PATH}"
# Anyone can write to /tmp
PATH="/tmp/tools:${PATH}"
```

### Configuration Files

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Read a configuration file as data: parse `key=value` lines, accept only the keys the script knows, and validate each value
> - ✔️ SHOULD: Load the files in a fixed order, system first and user last, and say in `--help` which paths are read
> - ⚠️ CONSIDER: `.` a configuration file only when it is owned by the user running the script, or by root, and nobody else can write to it
> - ❌ AVOID: Do not `.` a file that another user, a world-writable directory or a download can change: every line of it runs as the script `BSG115`

Sourcing a file runs it. A configuration file in a shared directory, or one a less privileged user can edit, then becomes a way to run any command with the rights of the script — for a script that runs through `sudo`, with root's. Parsing keeps the file to what it is meant to be: values for the settings the script knows, checked like any other input.

**Recommended**

```sh
# System defaults first, the user's file last; parsed, never run
dybatpho::config_load --optional /etc/app.env "${XDG_CONFIG_HOME:-${HOME}/.config}/app/config.env"

# Without the library: only known keys, each one validated where it is used
function app::load_config {
  local file key value
  dybatpho::expect_args file -- "$@"
  while IFS='=' read -r key value || [[ -n "${key}" ]]; do
    [[ -n "${key}" && "${key}" != \#* ]] || continue
    case "${key}" in
      port) APP_PORT="${value}" ;;
      log_level) APP_LOG_LEVEL="${value}" ;;
      *) dybatpho::warn "Unknown setting ${key@Q} in ${file@Q}" ;;
    esac
  done < "${file}"
}
```

**Discouraged**

```sh
# Runs whatever the file holds, with the rights of the script
. "${XDG_CONFIG_HOME:-${HOME}/.config}/app/config"
# A world-writable directory: anyone can plant this file
. "/tmp/app-${USER}.conf"
```

### Library Side Effects

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Return a status from a library function, or stop through the library's die helper, which reports the failure. (dybatpho)
> - ✔️ SHOULD: Change directory inside a subshell, `( cd -- "${dir}" && ... )`, or restore the previous directory before returning `BSG091`
> - ✔️ SHOULD: Scope a shell option a function needs: a subshell, `local -` for `set` options, an `IFS=` prefix on the one command that splits, `local IFS`, or save and restore it on every return path `BSG092`
> - ❌ AVOID: Do not call `exit` in a library function: it ends the script that sourced the library `BSG090`
> - ❌ AVOID: Do not `cd` in the caller's shell from a library function
> - ❌ AVOID: Do not leave `set -e`/`+e`/`-C`/`-f`, a `shopt` option, `IFS` or `umask` changed when a library function returns

A library runs in its caller's shell. `exit` there ends the whole script — skipping the caller's error handling, its cleanup decisions and the message that would have said why — and inside `$(...)` it ends only the subshell, so the caller cannot tell a failure from an empty answer.

**Recommended**

```sh
function net::fetch {
  local url
  dybatpho::expect_args url -- "$@"
  [[ -n "${url}" ]] || dybatpho::die "net::fetch: no URL given"
  # curl's own status reaches the caller, which decides what a failure means
  curl --fail -sS --connect-timeout 10 --max-time 60 -- "${url}" || return $?
}
```

**Discouraged**

```sh
function net::fetch {
  # Ends the caller's script with no message and no chance to recover
  curl --fail -sS "$1" || exit 1
}
```

The working directory belongs to the caller. A library function that changes it leaves every relative path the caller uses afterwards pointing somewhere else, and an early `return` or an error skips any `cd -` meant to undo it.

**Recommended**

```sh
function repo::files {
  local root
  dybatpho::expect_args root -- "$@"
  (cd -- "${root}" && git ls-files)
}
```

**Discouraged**

```sh
function repo::files {
  # The caller is left in ${root} after this returns
  cd "$1" && git ls-files
}
```

Shell options are global to the shell. A library that turns on `nullglob` changes what every later glob of the caller expands to; one that leaves `set +e` turns off the caller's error handling; a changed `IFS` or `umask` alters word splitting and file permissions far from the line that changed them.

**Recommended**

```sh
function fs::list {
  local dir
  dybatpho::expect_args dir -- "$@"
  (
    shopt -s nullglob dotglob
    local -a entries=("${dir}"/*)
    # printf with no argument still prints one empty line
    ((${#entries[@]} == 0)) || printf '%s\n' "${entries[@]}"
  )
}

function text::split_into {
  local __text_split_var __text_split_input
  dybatpho::expect_args __text_split_var __text_split_input -- "$@"
  local -n __text_split_ref="${__text_split_var}"
  # IFS changes for this read only; a `local IFS` here would be a local the nameref can bind to
  IFS=, read -r -a __text_split_ref <<< "${__text_split_input}"
}
```

**Discouraged**

```sh
function fs::list {
  # Every glob the caller writes afterwards now expands to nothing on no match
  shopt -s nullglob
  printf '%s\n' "$1"/*
}

function text::split_into {
  local __text_split_var __text_split_input
  dybatpho::expect_args __text_split_var __text_split_input -- "$@"
  local -n __text_split_ref="${__text_split_var}"
  IFS=,
  read -r -a __text_split_ref <<< "${__text_split_input}"
}
```

### Interactive Input

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Ask only when standard input is a terminal, or honour a non-interactive mode, and fall back to a safe default otherwise
> - ✔️ SHOULD: Give a prompt a timeout and a default answer
> - ❌ AVOID: Do not call `read` or a prompt unconditionally in a script that may run in CI, cron or a pipe `BSG098`

With no terminal, `read` waits for input that never comes — a CI job hangs until its timeout — or reads the next line of a pipe meant for something else. Checking `[[ -t 0 ]]` and having a default makes the unattended run decide on its own, and a timeout bounds the interactive one.

**Recommended**

```sh
local answer="n"
if [[ -t 0 ]] && ! dybatpho::is true "${CI-}"; then
  read -r -t 30 -p "Overwrite ${file}? [y/N] " answer || answer="n"
fi
[[ "${answer}" == [yY] ]] || return 1
```

**Discouraged**

```sh
# Hangs forever in CI, and reads the wrong line from a pipe
read -r -p "Overwrite ${file}? [y/N] " answer
[[ "${answer}" == [yY] ]] || return 1
```

## Naming Conventions

### Function Names

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Use the `function` keyword to declare a function `BSG001`
> - ✔️ SHOULD: Write function names in lowercase, with underscores between words `BSG003`
> - ✔️ SHOULD: Separate the namespace from the function name with `::`, and name the namespace after the library file: `scripts/lib/package_manager.sh` defines `package_manager::install` `BSG004`
> - ✔️ SHOULD: Prefix a function that is private to its library with `__<namespace>_`, and a function that is private to an entrypoint script with `_`. (custom)
> - ❌ AVOID: Do not write `()` after the function name when using the `function` keyword. (custom) `BSG002`
> - ❌ AVOID: Do not use PascalCase or camelCase `BSG003`

The `function` keyword makes a declaration greppable, which matters in a language with no other way to list what a file defines. The `::` separator gives libraries a namespace that Bash itself does not have: two libraries can both have a `download` step without colliding, and a reader can tell where a function comes from without looking it up.

The prefix conventions mark what is safe to call. `package_manager::install` is part of the library's API; `__package_manager_resolve_args` is an implementation detail that may change without notice; `_main` belongs to one script and nothing else.

**Recommended**

```sh
# Public API of the `binary` library
function binary::verify_sha256 {
  ...
}

# Private to the same library
function __binary_download_temp_suffix {
  ...
}

# Private to one entrypoint script
function _spec_main {
  ...
}
```

**Discouraged**

```sh
# Redundant parentheses next to the keyword
function binary::verify_sha256() {
  ...
}

# No namespace, so the reader cannot tell where it lives
function verifySha256 {
  ...
}
```

### Variable Names

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Write local and ordinary variable names in lowercase, with underscores between words
> - ✔️ SHOULD: Declare every variable used inside a function with `local`, and declare array locals with `local -a name=()` `BSG011` `BSG013`
> - ✔️ SHOULD: Use `UPPERCASE` for variables the caller sets: script options, exported environment variables and constants
> - ✔️ SHOULD: Make constants read-only with `readonly` or `declare -r`, and declare them at the top of the file
> - ✔️ SHOULD: Name a loop variable after the collection it walks: `for tool in "${tools[@]}"` `BSG012`
> - ❌ AVOID: Do not declare and assign from a command substitution on the same line `BSG010`

`local name="$(some_command)"` throws away the exit status of `some_command`, because the status of the line is the status of `local`, which always succeeds. Under `set -e` that turns a failing command into a silent empty variable. Splitting the two lines keeps the failure visible. `readonly`, `export` and `declare` swallow the status in the same way, so a constant is assigned first and made read-only on the next line.

**Recommended**

```sh
# Constants first, read-only
SCRIPT_DIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
readonly SCRIPT_DIR

function dytoy::install {
  local name
  dybatpho::expect_args name -- "$@"

  # Declare, then assign, so a failure is not swallowed
  local version
  version="$(dytoy::get_yaml "${name}" "version")"

  local -a dependencies=()
  readarray -t dependencies < <(dytoy::get_yaml "${name}" "dependencies")
  local dependency
  for dependency in "${dependencies[@]}"; do
    dytoy::install "${dependency}"
  done
}
```

**Discouraged**

```sh
# The exit status of the command substitution is lost
local version="$(dytoy::get_yaml "$name" "version")"
readonly SCRIPT_DIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"

# Global by accident, leaks into every function called afterwards
version="1.2.3"

# Uppercase for something the caller never sets
NAME="$1"

# A loop variable that says nothing
for i in "${tools[@]}"; do
  install "$i"
done
```

### Local Names in Nameref and Callback Functions

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Prefix every other local of a function that binds `local -n` to a name its caller chose: `__<namespace>_<function>_<name>` `BSG014`
> - ✔️ SHOULD: Prefix the locals of a function that runs caller code — `"$@"`, `eval`, a callback, handler or producer name — when they are live across that call `BSG015`
> - ❌ AVOID: Do not give such a function plain locals like `status`, `name`, `path`, `count` or `result`

Bash scopes variables dynamically. `local -n ref="$1"` resolves the name the caller passed when it is used, so if the function has a local of that name, the nameref binds to the local and the caller's variable is never filled. Code a function runs on its caller's behalf sees the function's locals in the same way, and can read or overwrite them: a command that kept its own `count` once changed how often a retry helper retried.

**Recommended**

```sh
function text::split_into {
  local __text_split_var __text_split_input
  dybatpho::expect_args __text_split_var __text_split_input -- "$@"
  local -n __text_split_ref="${__text_split_var}"
  IFS=, read -r -a __text_split_ref <<< "${__text_split_input}"
}

function net::retry {
  local __net_retry_count=0
  until "$@"; do
    ((++__net_retry_count < 3)) || return 1
  done
}
```

**Discouraged**

```sh
function text::split_into {
  local -n ref="$1"
  # A caller that passes `input` gets this local back, unfilled
  local input="$2"
  IFS=, read -r -a ref <<< "${input}"
}

function net::retry {
  local count=0
  # A command that sets `count` changes how often this retries
  until "$@"; do
    ((++count < 3)) || return 1
  done
}
```

## Comments

### File Header

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Include a comment at the beginning of the file that concisely explains the purpose or content of the file. However, do not include comments before the shebang line `BSG024`
> - ✔️ SHOULD: Use [sh-docs](https://github.com/dynamotn/sh-docs) ([GitLab](https://gitlab.com/dynamo-tools/sh-docs)) format includes: `@file`, `@brief`, `@description` to explain the file. (custom) `BSG020`

All files should include a top-level comment that briefly describes their content.

**Recommended**

```sh
#!/usr/bin/env bash
# @file backup.sh
# @brief Perform hot backups of Oracle databases
# @description Perform hot backups of Oracle databases
```

### Function Comments

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Use [sh-docs](https://github.com/dynamotn/sh-docs) ([GitLab](https://gitlab.com/dynamo-tools/sh-docs)) format to explain the function. (custom) `BSG021` `BSG022`

It should be possible for someone else to learn how to use your program or to use a function in your library by reading the comments (and self-help, if provided) without reading the code.

All function header comments should describe the intended API behaviour using:

- `@description`: Description of the function.
- `@set`: List of global variables modified.
- `@arg`: Arguments taken. If not take any arguments, use `@noargs`
- `@option`: Options taken.
- `@stdout` and `@stderr`: Output to STDOUT or STDERR.
- `@exitcode`: Returned values of the last command run.

**Recommended**

```sh
#######################################
# @description Get exist configuration directory.
# @arg $1 string Path of configuration directory
# @stdout Location of configuration directory
# @stderr Output 'Not have configuration directory' on error
# @exitcode 0 If successful
# @exitcode 1 If configuration directory is not exist
#######################################
function get_dir {
  local config_dir="${1:-${HOME}/.config/abc}"
  if [[ -e "${config_dir}" ]]; then
    printf '%s\n' "${config_dir}"
  else
    echo "Not have configuration directory" >&2
    return 1
  fi
}
```

### Implementation Comments

> [!TIP]
>
> - ✔️ SHOULD: Add comments to code that is tricky, has significant meaning, or requires attention
> - ✔️ SHOULD: Keep comments short and easy to understand whenever possible
> - ⚠️ CONSIDER: If a brief explanation is not sufficient, consider providing detailed background information

Comment on parts of the code that are tricky, not immediately obvious, interesting, or important. However, do not comment on everything. Add comments when there are complex algorithms or when doing something unusual. If a short comment cannot provide a clear explanation, include detailed background information.

### TODO Comments

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Consider using TODO comments
> - ❌ AVOID: Do not include the name of the person who wrote the TODO comment. (custom) `BSG023`

Use TODO comments for temporary, short-term solutions, or code that is good enough but not perfect. TODO comments should include the uppercase string `TODO`. There is no need to include the individual's name, as it can be identified using `git blame`. The purpose of TODO comments is to provide a searchable and consistent `TODO` marker that can be looked up for more details as needed. Since the person referenced in the TODO is not necessarily committed to fixing the issue, it is helpful to include the expected resolution.

**Recommended**

```sh
# TODO: This code needs to be fixed due to insufficient error handling. Add error checks and exit with 1.
```

## Formatting

### Tabs and Spaces

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Indent with two spaces. Do not use tabs `BSG071`
> - ✔️ SHOULD: Include blank lines between blocks for readability
> - ✔️ SHOULD: Do not include trailing spaces. (custom) `BSG072`
> - ❌ AVOID: Do not leave more than one blank line in a row

Indentation should be two spaces. Under no circumstances should tabs be used.

Many editors cannot switch between actual indentation and displayed spaces/tabs according to user preference. Another person's editor may not have the same settings as yours. Using spaces ensures that code looks the same in any editor.

One blank line is enough to separate two blocks; a second one says nothing more and pushes the code below it off the screen. shfmt joins a run of blank lines into one.

### Line Length and Long Strings

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Maximum line length is 120 characters. (custom) `BSG070`
> - ✔️ SHOULD: Consider using here documents or embedded newlines for excessively long strings. (custom)
> - ⚠️ CONSIDER: Look for ways to shorten string literals

Keep every line at 120 characters or fewer; `max_line_length` in [`.editorconfig`](.editorconfig) sets the limit for editors, and the linter checks it. Break a long command at its options with `\`, and a long string with a here document or embedded newlines. A literal that cannot be divided, such as a URL, is better moved into a variable of its own than left to run past the limit.

**Recommended**

```sh
# Use of here document
cat << END
I am an exceptionally long
string.
END

# Embedded newline
long_string="I am an exceptionally
long string."
```

**Discouraged**

```sh
# Fitting into one line using \n (acceptable for specific cases like Slack API)
str="I am an exceptionally long\nstring."
```

### Pipelines

> [!TIP]
>
> - ✔️ SHOULD: Write the entire pipeline on one line if it fits neatly
> - ✔️ SHOULD: Break the pipeline into separate lines if it is long and hard to read
> - ✔️ SHOULD: Apply the same rule to chains of commands with `|`, and logical operators `||` and `&&`

If a pipeline is long and hard to read, break it into separate lines. If the entire pipeline fits neatly on one line, write it on one line. When breaking lines, indicate continuation for the following pipe sections by adding a `\` at the end of the line, indent by two spaces, and place the pipe at the beginning of the next line.

This applies to chains of commands using `|`, and logical operators `||` and `&&`.

**Recommended**

```sh
# If it fits on one line
command1 | command2

# Long command
command1 \
  | command2 \
  | command3 \
  | command4
```

**Discouraged**

```sh
# Unnecessary line break when it fits on one line
command1 \
  | command2

# Difficult to read without line breaks
command1 | command2 | command3 | command4
```

### Control Flow

> [!TIP]
>
> - ✔️ SHOULD: Place `; do` and `; then` on the same line as `while`, `for`, and `if`
> - ✔️ SHOULD: Place `elif` and `else` on their own lines
> - ✔️ SHOULD: Write a choice between two actions as `if`/`else`
> - ✔️ SHOULD: Pick the first value that is not empty with `dybatpho::coalesce`, and the first installed command with `dybatpho::coalesce_cmd`, rather than `test && x=a || x=b`. (dybatpho)
> - ❌ AVOID: Do not write `test && action || other` for an if/else: `other` also runs when `action` fails. ShellCheck reports it as SC2015
> - ❌ AVOID: Do not use `test && { ...; }` as an `if` that spans several lines
> - ❌ AVOID: Do not end a statement with `;`: a semicolon belongs only before `then` and `do`, or between statements on one line

Shell loops are a bit different, but following the principle of braces when declaring functions, place `; then` and `; do` on the same line as `if/for/while`. `else` should be placed on its own line, and closing constructs should also be on their own lines. They should be vertically aligned with their opening constructs.

**Recommended**

```sh
if [[ -n "${name}" ]]; then
  dybatpho::info "Installing ${name}"
else
  dybatpho::die "No tool name given"
fi

for tool in "${tools[@]}"; do
  printf '%s\n' "${tool}"
done
```

**Discouraged**

```sh
if [[ -n "${name}" ]];
then
  dybatpho::info "Installing ${name}"
fi

for tool in "${tools[@]}"
do
  printf '%s\n' "${tool}"
done
```

`a && b || c` is not an `if`: `c` runs when `a` fails, and also when `a` succeeds and `b` fails. A message such as `|| echo "not found"` then claims the opposite of what happened. A block after `&&` reads as an `if` without saying so, and its status leaks out when the test is false — see [Checking Return Values](#checking-return-values). The one-line guard `test || action`, which stops or skips, is still fine.

**Recommended**

```sh
if [[ -f "${config}" ]]; then
  dybatpho::info "Using ${config}"
else
  dybatpho::warn "No ${config}, using defaults"
fi

[[ -f "${config}" ]] || dybatpho::die "Missing ${config}"
```

**Discouraged**

```sh
# Also warns when the file exists but the message cannot be printed
[[ -f "${config}" ]] && dybatpho::info "Using ${config}" || dybatpho::warn "No ${config}, using defaults"

# An `if` in disguise
[[ -f "${config}" ]] && {
  load_config "${config}"
  validate_config
}
```

Most `a && b || c` lines choose a value: a setting or its default, the first tool that is installed. `dybatpho::coalesce` prints the first of its arguments that is not empty, and `dybatpho::coalesce_cmd` the first name that `command -v` finds. Both fail when there is none, so the missing case is handled once, instead of slipping into the `||` branch. (dybatpho)

**Recommended**

```sh
local editor pager
editor="$(dybatpho::coalesce "${VISUAL-}" "${EDITOR-}" vi)"
pager="$(dybatpho::coalesce_cmd bat less more)" || dybatpho::die "No pager is installed"
```

**Discouraged**

```sh
[[ -n "${VISUAL-}" ]] && editor="${VISUAL}" || editor="${EDITOR:-vi}"
# Picks less even when less is not installed either
command -v bat > /dev/null && pager=bat || pager=less
```

A newline ends a statement already, so a `;` at the end of a line is noise left over from other languages; shfmt removes it.

**Recommended**

```sh
name="dotfiles"
printf '%s\n' "${name}"
```

**Discouraged**

```sh
name="dotfiles";
printf '%s\n' "${name}";
```

### Case statement

> [!TIP]
>
> - ✔️ SHOULD: Indent cases by two spaces
> - ✔️ SHOULD: For single-line cases, place one space after the closing parenthesis of the pattern and before `;;`
> - ✔️ SHOULD: For long or multiple command cases, split the pattern, action, and `;;` into multiple lines
> - ✔️ SHOULD: End every `case` with a `*)` branch, which handles or rejects what no other pattern matched. `add-default-case` in [`.shellcheckrc`](.shellcheckrc) checks it
> - ❌ AVOID: Do not write an opening parenthesis before a pattern, and do not fall through with `;&` or `;;&`
> - ⚠️ CONSIDER: For short command cases, consider placing the pattern, action, and `;;` on one line if readability is maintained

Indent the conditions one level from `case` and `esac`. For multi-line actions, indent an additional level. There should be no opening parentheses before the pattern expression. A fall-through with `;&` or `;;&` makes the reader trace every branch below the one that matched, so give each branch its own action instead. Without a `*)` branch, a value nobody expected passes through silently.

**Recommended**

```sh
case "${format}" in
  json | yaml)
    output_file="${name}.${format}"
    renderer="render_${format}"
    ;;
  text) renderer=render_text ;;
  *) dybatpho::die "Unknown format: ${format}" ;;
esac
```

For simple commands, place the pattern and `;;` on the same line if readability is maintained. If the action does not fit on a single line, place the pattern on its own line, followed by the action on the next line, and then `;;` on its own line. When placing the pattern on the same line as the action, include one space after the closing parenthesis of the pattern and before `;;`.

### Variable Expansion

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Brace every named variable, `${var}`, even when it stands alone in quotes. `require-variable-braces` in [`.shellcheckrc`](.shellcheckrc) checks it
> - ✔️ SHOULD: Enclose variable expansions in double quotes. Single quotes do not expand variables
> - ✔️ SHOULD: Read an environment variable that may be unset with a default under `set -u`: `${NO_COLOR-}`, `${TMPDIR:-/tmp}` `BSG073`
> - ❌ AVOID: Avoid bracing shell special variables/positional parameters unless explicitly necessary or to avoid serious confusion `BSG043`
> - ❌ AVOID: Do not read an optional environment variable bare under `set -u`

Variables should be quoted. Use `${var}` instead of `$var`, also when the variable is the whole quoted string: one form everywhere is easier to read and to check than a rule with an exception.
This is a strongly recommended guideline but not an absolute regulation. However, even though it is not mandatory, do not disregard it.

All other variables should preferably be enclosed in braces.

**Recommended**

<!-- lint: allow BSG043,SC2145,SC2250,SC2320 -->
```sh
# Preferred style for 'special' variables:
echo "Positional: $1" "$5" "$3"
echo "Specials: !=$!, -=$-, _=$_. ?=$?, #=$# *=$* @=$@ \$=$$ …"

# Braces necessary:
echo "many parameters: ${10}"

# Braces avoiding confusion:
# Output is "a0b0c0"
set -- a b c
printf '%s\n' "${1}0${2}0${3}0"

# Preferred style for other variables:
echo "PATH=${PATH}, PWD=${PWD}, mine=${some_var}"
printf '%s\n' "${PATH}"
while IFS= read -r -d '' file; do
  echo "file=${file}"
done < <(command find /tmp -print0)
```

**Discouraged**

```sh
# Unquoted vars, unbraced vars, brace-delimited single letter
# shell specials.
echo a=$avar "b=$bvar" "PID=${$}" "${1}"

# Confusing use: this is expanded as "${1}0${2}0${3}0",
# not "${10}${20}${30}
set -- a b c
echo "$10$20$30"
```

`set -u` stops the script on the first read of an unset variable. Variables the caller may or may not export — `NO_COLOR`, `TMPDIR`, `XDG_*`, `CI` — are as often unset as set, so a bare `${NO_COLOR}` works on the developer's machine and stops every script whose user ran `unset NO_COLOR`. `${NAME-}` reads an unset variable as empty; `${NAME:-default}` also replaces an empty value.

**Recommended**

```sh
if [[ -n "${NO_COLOR-}" ]]; then
  color=false
fi
cache_dir="${XDG_CACHE_HOME:-${HOME}/.cache}"
```

**Discouraged**

```sh
# `NO_COLOR: unbound variable` as soon as it is not exported
if [[ -n "${NO_COLOR}" ]]; then
  color=false
fi
```

### Quoting

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Always quote strings containing variables, command substitutions, spaces or shell meta characters, unless careful unquoted expansion is required or it’s a shell-internal integer
> - ✔️ SHOULD:Use arrays to safely quoting multiple elements, especially for command line flags
> - ✔️ SHOULD: Quoting shell internal read-only special variables defined as integers is optional: `$?`, `$#`, `$$`, `$!` (see `man bash`). Prefer quoting of "named" internal integer variables, e.g. PPID etc for consistency.
> - ✔️ SHOULD: Prefer quoting strings that are “words” (as opposed to command options or path names)
> - ✔️ SHOULD: Use canonical quoting. (custom)
> - ❌ AVOID: Do not quote integer literals. Do not quote arithmetic expressions like `$((2 + 2))`
> - ⚠️ CONSIDER: Be aware of the quoting rules for pattern matches in `[[...]]`
> - ⚠️ CONSIDER: Use `"$@"` instead of `$*` unless you have a specific reason to concatenate arguments into a string or log message

**Recommended**

```sh
# 'Single' quotes indicate that no substitution is desired.
# "Double" quotes indicate that substitution is required/tolerated.

# Simple examples

# "quote command substitutions"
# Note that quotes nested inside "$()" don't need escaping.
flag="$(some_command and its args "$@" 'quoted separately')"

# "quote variables"
printf '%s\n' "${flag}"

# Use arrays with quoted expansion for lists.
declare -a FLAGS
FLAGS=(--foo --bar='baz')
readonly FLAGS
mybinary "${FLAGS[@]}"

# It's ok to not quote internal integer variables.
if (($# > 3)); then
  echo "ppid=${PPID}"
fi

# "never quote literal integers"
value=32
# "quote command substitutions", even when you expect integers
number="$(generate_number)"

# "prefer quoting words", not compulsory
readonly USE_INTEGER='true'

# "quote shell meta characters"
echo 'Hello stranger, and well met. Earn lots of $$$'
echo "Process $$: Done making \$\$\$."

# "command options or path names"
# ($1 is assumed to contain a value here)
grep -li Hugo /dev/null "$1"

# Less simple examples
# "quote variables, unless proven false": ccs might be empty
git send-email --to "${reviewers}" ${ccs:+"--cc" "${ccs}"}

# Positional parameter precautions: $1 might be unset
# Single quotes leave regex as-is.
grep -cP '([Ss]pecial|\|?characters*)$' ${1:+"$1"}

# For passing on arguments,
# "$@" is right almost every time, and
# $* is wrong almost every time:
#
# - $* and $@ will split on spaces, clobbering up arguments
#   that contain spaces and dropping empty strings;
# - "$@" will retain arguments as-is, so no args
#   provided will result in no args being passed on;
#   This is in most cases what you want to use for passing
#   on arguments.
# - "$*" expands to one argument, with all args joined
#   by (usually) spaces,
#   so no args provided will result in one empty string
#   being passed on.
#
# Consult
# https://www.gnu.org/software/bash/manual/html_node/Special-Parameters.html and
# https://mywiki.wooledge.org/BashGuide/Arrays for more

(
  set -- 1 "2 two" "3 three tres"
  echo $#
  set -- "$*"
  echo "$#, $*"
)
(
  set -- 1 "2 two" "3 three tres"
  echo $#
  set -- "$@"
  echo "$#, $*"
)
```

### Function Declaration

> [!TIP]
>
> - ✔️ SHOULD: Put the shebang and the file header comment first, then constants, then function declarations, then the single line that starts the script
> - ✔️ SHOULD: Keep the call to the entrypoint as the last line of the file
> - ⚠️ CONSIDER: Guard that call with `[[ "${BASH_SOURCE[0]}" == "$0" ]]` when a test sources the script for its functions
> - ❌ AVOID: Do not place executable code between function declarations `BSG033`

A file that is a list of declarations followed by one call can be read in any order, and sourcing it for a test runs nothing but that call — which a guard on `BASH_SOURCE` skips, since `${BASH_SOURCE[0]}` is `$0` only when the file is executed. Code scattered between functions runs at load time, which makes the script impossible to source and hard to reason about when it fails halfway.

**Recommended**

```sh
#!/usr/bin/env bash
# @file test.sh
# @brief Run tests for the dotfiles setup
SCRIPT_DIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
# shellcheck source=lib/dybatpho/init.sh
. "${SCRIPT_DIR}/lib/dybatpho/init.sh" --modules cli
dybatpho::register_common_handlers

function _spec_main {
  ...
}

function _main {
  ...
}

# Runs only when executed, so a test can source the file for its functions
if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  dybatpho::generate_from_spec _spec_main "$@"
fi
```

**Discouraged**

```sh
function _spec_main {
  ...
}

# Runs the moment the file is sourced, before _main is even defined
rm -rf "${cache_dir}"

function _main {
  ...
}
```

## Features and Bugs

### Use ShellCheck

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Use ShellCheck to identify bugs in shell scripts
> - ✔️ SHOULD: Resolve all ShellCheck warnings with a severity level of warning or higher. (custom)
> - ✔️ SHOULD: Copy the [`.shellcheckrc`](.shellcheckrc) of this guide into the project: it turns on the optional checks the guide asks for by name, and lets ShellCheck follow `source=` directives. (custom)
> - ✔️ SHOULD: Point ShellCheck at a library sourced through a computed path with `# shellcheck source=<path>`, rather than disabling SC1091 `BSG109`
> - ⚠️ CONSIDER: Consider resolving all ShellCheck warnings with a severity level of info or higher. (custom)
> - ⚠️ CONSIDER: If you cannot resolve ShellCheck warnings with a severity level of info, consider adding `# shellcheck disable=SCXXXX` comments to ignore them, with the reason on the same line. (custom) `BSG123`

The [ShellCheck](https://www.shellcheck.net/) project detects common bugs and warnings in shell scripts. Apply it to all shell scripts, regardless of their size.

ShellCheck can be [installed](https://github.com/koalaman/shellcheck) on Windows, Ubuntu, and macOS.

```sh
# Debian/Ubuntu
sudo apt install shellcheck
# macOS
brew install shellcheck
# Windows
winget install --id koalaman.shellcheck
scoop install shellcheck
```

**Recommended**

```sh
# Enclose variables with potential spaces in quotes.
ls "/foo/bar/${file}"

# Tell ShellCheck which file a computed path names, relative to this script
# shellcheck source=lib/functions.sh
. "${SCRIPT_DIR}/lib/functions.sh"

# A finding that is wrong here, silenced with the reason
# shellcheck disable=SC2016 # expanded by the remote shell
ssh -o ConnectTimeout=10 "${host}" 'printf "%s\n" "$HOSTNAME"'
```

### Command Substitution

> [!TIP]
>
> - ✔️ SHOULD: Use `$(command)` for command substitution
> - ✔️ SHOULD: Read lines from a literal argument and from standard input through the same helper, so both give the same lines
> - ❌ AVOID: Do not use backticks
> - ❌ AVOID: Do not mix `$(...)` and `<<<` without accounting for the newline each one removes or adds

`$(...)` nests without escaping and is easier to read, because the opening and closing markers differ.

**Recommended**

```sh
SCRIPT_DIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
```

**Discouraged**

```sh
# Nesting requires escaping, and the two markers look alike
SCRIPT_DIR="`realpath \`dirname "${BASH_SOURCE[0]}"\``"
```

`$(...)` strips every trailing newline, and `<<<` appends one. Text that goes through a substitution and then a here-string gains or loses a line: `mapfile -t lines <<< "${text}"` turns `$'a\nb\n'` into three lines with an empty last one, while the same text piped in gives two.

**Recommended**

```sh
function text::lines_into {
  local __text_lines_var __text_lines_text
  dybatpho::expect_args __text_lines_var __text_lines_text -- "$@"
  local -n __text_lines_ref="${__text_lines_var}"
  __text_lines_ref=()
  local __text_lines_line
  while IFS= read -r __text_lines_line || [[ -n "${__text_lines_line}" ]]; do
    __text_lines_ref+=("${__text_lines_line}")
  done < <(printf '%s' "${__text_lines_text}")
}
```

**Discouraged**

```sh
# `$'a\nb\n'` becomes three lines, the last one empty
mapfile -t lines <<< "${text}"
```

### Validation in Command Substitution

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Return a value that has to be validated through a nameref, with an `*_into` helper, or validate the input before the substitution
> - ✔️ SHOULD: Check the status of a substitution whose function can stop the script: `value="$(fn)" || return $?`
> - ✔️ SHOULD: Call a function that changes state — a global, a cache or memo, a counter, a secret registration — in the caller's shell, and return its value through a nameref
> - ❌ AVOID: Do not call a function that can stop the script, through `dybatpho::die` or `exit`, inside `$(...)` and carry on unconditionally `BSG047`
> - ❌ AVOID: Do not call such a function inside `$(...)`: every change it makes is lost with the subshell `BSG084`

`$(...)` runs in a subshell, so `dybatpho::die` or `exit` inside it ends only that subshell. Under `set -e` the failed assignment still stops the script, but wherever errexit is suspended — inside `if`, after `||`, `&&` or `!`, or under bats' `run` — the caller carries on with an empty value, right after a fatal error that claimed the script was stopping. A helper that validates in the caller's shell stops the script where it should.

**Recommended**

```sh
# Validates in the caller's shell, then sets the variable the caller named
function __net_port_into {
  local __net_port_var __net_port_value
  dybatpho::expect_args __net_port_var __net_port_value -- "$@"
  local -n __net_port_ref="${__net_port_var}"
  [[ "${__net_port_value}" =~ ^[0-9]+$ ]] || dybatpho::die "Not a port: ${__net_port_value}"
  __net_port_ref="${__net_port_value}"
}

function net::connect {
  local raw_port port
  dybatpho::expect_args raw_port -- "$@"
  __net_port_into port "${raw_port}"
  nc "${HOST}" "${port}"
}

# A substitution that cannot be avoided has its status checked
local version
version="$(pkg::read_version "${file}")" || return $?
```

**Discouraged**

```sh
function net::port {
  [[ "$1" =~ ^[0-9]+$ ]] || dybatpho::die "Not a port: $1"
  printf '%s\n' "$1"
}

function net::connect {
  local port
  port="$(net::port "$1")"
  nc "${HOST}" "${port}"
}

# The refusal ends only the subshell: nc runs with an empty port
if ! net::connect "${raw_port}"; then
  dybatpho::warn "Could not connect"
fi
```

The subshell discards side effects as well as refusals. A memo set inside `$(...)` is never seen again, so the expensive probe it was meant to cache runs on every call; a token registered for masking inside `$(...)` is printed unmasked afterwards; a counter never moves.

**Recommended**

```sh
function __date_flavor_into {
  local __date_flavor_var
  dybatpho::expect_args __date_flavor_var -- "$@"
  local -n __date_flavor_ref="${__date_flavor_var}"
  if [[ -z "${__DATE_FLAVOR-}" ]]; then
    if date --version &> /dev/null; then __DATE_FLAVOR=gnu; else __DATE_FLAVOR=bsd; fi
  fi
  __date_flavor_ref="${__DATE_FLAVOR}"
}

local flavor
__date_flavor_into flavor
```

**Discouraged**

```sh
# The memo is set in the subshell, so every call probes again
flavor="$(date::flavor)"

# Registered for masking in the subshell: the caller's logs show the token
token="$(secret::read API_TOKEN)"
```

### Test Expression

> [!TIP]
>
> - ✔️ SHOULD: Use `[[ ... ]]` for tests
> - ✔️ SHOULD: Use `dybatpho::is` for the checks it already covers, such as `command`, `file`, `dir`, `true` and `blank`. (dybatpho)
> - ❌ AVOID: Do not use `[ ... ]`, `test` or `/usr/bin/[`

`[[ ... ]]` is a shell keyword rather than a command, so it does not word-split or glob its operands, and it supports `=~` and `&&`. A missing quote inside `[ ... ]` is a bug; inside `[[ ... ]]` it usually is not.

**Recommended**

```sh
if [[ ! -f "${SCRIPT_DIR}/lib/dybatpho/init.sh" ]]; then
  git -C "${REPO_DIR}" submodule update --init "${SCRIPT_DIR}/lib/dybatpho"
fi

# A named check reads better than the flag it wraps
dybatpho::is command "${name}" || dybatpho::dry_run dytoy -t "${name}"
```

**Discouraged**

```sh
# Word-splits when the variable contains a space, and cannot use =~
if [ ! -f $SCRIPT_DIR/lib/dybatpho/init.sh ]; then
  ...
fi
```

### Testing Strings

> [!TIP]
>
> - ✔️ SHOULD: Use `==` to compare strings inside `[[ ... ]]`
> - ✔️ SHOULD: Use `-z` to test for an empty string and `-n` for a non-empty one
> - ✔️ SHOULD: Use `dybatpho::string_is_blank` when a value that is only whitespace should also count as empty. (dybatpho)
> - ✔️ SHOULD: Compare numbers with `(( ... ))`, or with `-lt`, `-gt`, `-eq` inside `[[ ... ]]`
> - ❌ AVOID: Do not use a single `=` for string comparison
> - ❌ AVOID: Do not use `<` or `>` to compare numbers inside `[[ ... ]]`
> - ❌ AVOID: Do not run a flag variable as a command, as in `if ${force}; then` or `while ${running}; do`: its value is executed `BSG121`
> - ❌ AVOID: Do not prefix both sides of a comparison with a letter, as in `[[ "x${answer}" == "xyes" ]]`: quote the variable instead `BSG127`

Inside `[[ ... ]]` the operators `<` and `>` compare lexicographically, so `[[ 10 < 9 ]]` is true. Numbers belong in `(( ... ))`.

**Recommended**

```sh
if [[ "${identity}" == "personal" ]]; then
  passphrase="$(rbw get 'Age Dotfiles')"
fi

if dybatpho::string_is_blank "${expected_hash}"; then
  dybatpho::die "No checksum found for ${asset_name}"
fi

if ((${#MAIN_ARGS[@]} > 0)); then
  exec "${BATS_CMD}" "${MAIN_ARGS[@]}"
fi
```

**Discouraged**

```sh
# Assignment-looking comparison
[[ "$identity" = "personal" ]]

# Lexicographic, so this is true for 10 and 9
[[ "${count}" > "${limit}" ]]

# Verbose way of writing -z
[[ "${value}" == "" ]]
```

`if ${force}; then` works while the variable holds `true` or `false`, because those are commands. Any other value runs too: a typo in a config file is a "command not found", and a value an attacker controls is a command they chose. Compare the value instead.

**Recommended**

```sh
if dybatpho::is true "${FORCE}"; then
  overwrite=true
fi
while [[ "${running}" == true ]]; do
  poll::once || running=false
done
```

**Discouraged**

```sh
# Runs whatever FORCE holds
if ${FORCE}; then
  overwrite=true
fi
```

The `x` prefix is a workaround for the old `test` command, which could take a value such as `-n`, `!` or `(` for an operator. `[[ ... ]]` parses its operators before it expands anything, so a value is never read as one: the quoted variable is enough, and the prefix only makes the comparison harder to read.

**Recommended**

```sh
if [[ "${answer}" == "yes" ]]; then
  confirmed=true
fi
```

**Discouraged**

```sh
# Guards against a problem [[ ... ]] does not have
if [[ "x${answer}" == "xyes" ]]; then
  confirmed=true
fi
```

### Regular Expressions

> [!TIP]
>
> - ✔️ SHOULD: Keep a regular expression in a variable and expand it unquoted on the right of `=~`
> - ✔️ SHOULD: Quote only the parts that must match literally, such as a value spliced into the pattern
> - ✔️ SHOULD: Copy what you need out of `BASH_REMATCH` right after the match
> - ⚠️ CONSIDER: Use a glob pattern with `==` when it is enough: `[[ "${file}" == *.tar.gz ]]`
> - ❌ AVOID: Do not quote the whole regular expression: a quoted right-hand side matches as a plain string

Quoting on the right of `=~` makes that part literal, so `[[ "${tag}" =~ "^v[0-9]+" ]]` looks for the characters `^v[0-9]+` and never matches a version. Writing the pattern straight into `[[ ]]` works until it holds a space, a `|` or a `)` that the shell reads first. A variable sidesteps both. `BASH_REMATCH` is overwritten by the next `=~`, including one inside a function you call.

**Recommended**

```sh
# The pattern in a variable, unquoted after =~
local version_re='^v?([0-9]+)\.([0-9]+)\.([0-9]+)$'
if [[ "${tag}" =~ ${version_re} ]]; then
  major="${BASH_REMATCH[1]}"
  minor="${BASH_REMATCH[2]}"
fi

# A literal part spliced in, quoted; the rest stays a pattern
[[ "${name}" =~ ^"${prefix}"[0-9]+$ ]]
```

**Discouraged**

```sh
# Quoted: matches only the literal text ^v?([0-9]+)...
[[ "${tag}" =~ "^v?([0-9]+)\.([0-9]+)" ]]

# BASH_REMATCH may belong to a match inside other_check by now
[[ "${tag}" =~ ^v?([0-9]+)\.([0-9]+)$ ]]
other_check "${tag}"
major="${BASH_REMATCH[1]}"
```

### Wildcard Expansion of Filenames

> [!TIP]
>
> - ✔️ SHOULD: Prefix a glob with `./` when it is expanded into command arguments
> - ✔️ SHOULD: Check each match exists with `[[ -e "${file}" || -L "${file}" ]]`, or turn on `nullglob` in a scope that ends with the loop `BSG093`
> - ⚠️ CONSIDER: Use `compgen -G` when you need the matches as data and an empty result is acceptable. (custom)
> - ❌ AVOID: Do not pass a bare `*` to a command
> - ❌ AVOID: Do not assume a glob that matched nothing expands to nothing: it stays as the literal pattern
> - ❌ AVOID: Do not parse the output of `ls`: loop over a glob, or use `find -print0` for a tree `BSG125`

A file named `-rf` in the directory turns `rm *` into `rm -rf`. `./*` expands to paths that begin with `./`, which no command can mistake for an option.

`ls` writes names for a person to read. In `$(ls)` or `ls | ...` a name with a space becomes two words, a name with a newline two lines, and a name with `*` expands again; some versions also replace unprintable characters with `?`. A glob hands each name to the script as it is. `ls` that only shows a listing to the user is fine.

**Recommended**

```sh
local file
for file in ./*.log; do
  [[ -e "${file}" ]] || continue
  gzip -- "${file}"
done
```

**Discouraged**

```sh
# "my app.log" becomes "my" and "app.log"
for file in $(ls *.log); do
  gzip "${file}"
done
```

**Recommended**

```sh
rm -f ./*.tmp

# Matches as data, empty result tolerated
local -a matches=()
mapfile -t matches < <(compgen -G "${search_pattern}" || true)
```

**Discouraged**

```sh
# A file named '-rf' or '--force' becomes an option
rm -f *.tmp
```

dybatpho turns on `nullglob`, `globstar` and `extglob` for the script that sources it, so there an unmatched glob expands to nothing; the check below costs nothing and keeps a function correct when it is sourced without the library. (dybatpho)

Without `nullglob`, a pattern that matches no file is left as it is, so the loop runs once with `file` set to `/etc/app/*.conf` and the command fails on a name that does not exist — or, for a write, creates it.

**Recommended**

```sh
local file
for file in "${dir}"/*.conf; do
  [[ -e "${file}" || -L "${file}" ]] || continue
  load_config "${file}"
done
```

**Discouraged**

```sh
# With no .conf file, this runs once on the literal "/etc/app/*.conf"
for file in "${dir}"/*.conf; do
  load_config "${file}"
done
```

### Locale and Collation

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Set `LC_ALL=C` locally when an order or a comparison has to be byte-wise and stable
> - ✔️ SHOULD: Compare numbers as numbers: extract or zero-pad a numeric key before ordering names that carry one
> - ❌ AVOID: Do not rely on glob order, `[[ a < b ]]`, `sort` or `printf '%f'` behaving the same under every locale

Glob expansion, `[[ < ]]` and `sort` order strings by the current collation, and `printf '%f'` reads and writes the locale's decimal separator. The same script orders `backup-1` before or after `backup` depending on the user's `LANG`, and every locale orders `-10` before `-2`. A retention policy built on that order deletes the wrong backup.

**Recommended**

```sh
local LC_ALL=C
local -a backups=("${dir}"/backup-*)
# Compare the numeric suffix as a number
if ((10#${a_suffix} < 10#${b_suffix})); then
  older="${a}"
fi
```

**Discouraged**

```sh
# The order depends on LANG, and -10 sorts before -2 everywhere
for backup in "${dir}"/backup-*; do
  newest="${backup}"
done
```

### Eval is Evil

> [!TIP]
>
> - ✔️ SHOULD: Quote every value spliced into a string for `eval`, or for a one-string `dybatpho::dry_run`, with `printf %q`; better, pass an argument list `BSG080`
> - ❌ AVOID: Do not use `eval` `BSG040`
> - ❌ AVOID: Do not build a command string for `eval` or `dybatpho::dry_run "<string>"` from data that is not escaped

`eval` makes it impossible to tell, by reading the script, what will run or which variables will be set. When a value has to be executed, use an array for the command and its arguments, or an indirect reference for the variable.

**Recommended**

```sh
local -a options=() packages=()
options+=(--noconfirm)
packages+=("${name}")
dybatpho::dry_run pacman -S "${options[@]}" "${packages[@]}"
```

**Discouraged**

```sh
# The reader cannot tell what this expands to, and a space in $name breaks it
eval "pacman -S ${options} ${packages}"
```

When a string has to be evaluated — generated parser code, a configured command template, a dry-run line — every piece of data spliced into it is code. A path with a space splits into two arguments, and a value holding `$(...)` or `;` runs. `printf %q` escapes a value so the shell reads it back as exactly one word, and an argument list never goes through the parser at all.

**Recommended**

<!-- lint: allow BSG040 -->
```sh
# An argument list: nothing is parsed a second time
dybatpho::dry_run gpg --detach-sign --output "${signature}" "${path}"

# A template that has to stay a string: every value quoted for the shell
local command
printf -v command '%s %q %q' "${SIGN_CMD}" "${signature}" "${path}"
eval "${command}"
```

**Discouraged**

```sh
# A path with a space splits, and a path holding $(...) runs it
dybatpho::dry_run "${SIGN_CMD} ${signature} ${path}"
eval "${SIGN_CMD} ${signature} ${path}"
```

### Secrets and Credentials

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Pass tokens, passwords and secret URLs to a command through a config file, standard input or the environment: `curl --config`, `-H @file`
> - ✔️ SHOULD: Redact a URL before it reaches a message or a log: keep the scheme and the host, drop the user info, the path and the query
> - ✔️ SHOULD: Register a secret for masking as soon as it is read, in the caller's shell. (dybatpho)
> - ❌ AVOID: Do not put a secret in the arguments of a command, where every user of the host reads it from `ps` and `/proc` `BSG081`
> - ✔️ SHOULD: Create a file that holds a secret under `umask 077`, in a subshell, or with `mktemp`, which creates it `0600`
> - ❌ AVOID: Do not log a request URL or body whole when it may carry a token
> - ❌ AVOID: Do not write a secret with a plain `>` under the default umask: the file is readable by every user, at least until a later `chmod`

The arguments of a running process are public on the host, and a log outlives the run that wrote it. A webhook URL is often the credential itself, so printing the URL of a failed request leaks it as surely as printing a token. Secrets therefore travel out of band — a private config file curl reads, standard input, an inherited variable — and a message names a request by its host only.

**Recommended**

```sh
local config
dybatpho::create_temp config ".curl"
printf 'header = "Authorization: Bearer %s"\n' "${TOKEN}" > "${config}"
curl --config "${config}" --fail-with-body "${url}"

# A file that outlives the run: created private
(umask 077 && printf '%s\n' "${TOKEN}" > "${XDG_CONFIG_HOME}/app/token")

# Only the scheme and the host reach the log: https://hooks.slack.com/[redacted]
dybatpho::error "Request to ${redacted_url} failed"
```

**Discouraged**

```sh
# The token is in `ps` for as long as the request runs
curl -H "Authorization: Bearer ${TOKEN}" "${url}"

# Readable by everyone the moment it exists, even if a chmod follows
printf '%s\n' "${TOKEN}" > "${XDG_CONFIG_HOME}/app/token"

# The webhook URL is the secret, and now it is in the log
dybatpho::error "Request to ${WEBHOOK_URL} failed"
```

### Building Structured Output

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Build JSON and YAML with `jq` or `yq` and `--arg`, or through one escaping helper that every module uses
> - ✔️ SHOULD: Write CSV fields through one helper that doubles quotes and quotes a field holding the delimiter, a quote or a line break
> - ❌ AVOID: Do not splice a value into structured text with `printf '{"key":"%s"}'` `BSG086`

A value holding a quote, a backslash or a line break breaks a hand-built document, or changes what it means — the receiving end reads an extra key or a cut-off string. Every module that builds JSON by hand grows its own escaper, and each one misses a different control character.

**Recommended**

```sh
jq -n --arg text "${message}" --arg channel "${channel}" \
  '{text: $text, channel: $channel}'
```

**Discouraged**

```sh
# A message with a quote or a line break produces invalid JSON
printf '{"text":"%s","channel":"%s"}\n' "${message}" "${channel}"
```

### Printing Data

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Print data — a variable, a path, anything that came from outside — with `printf '%s\n' "${value}"`
> - ✔️ SHOULD: Put the variable parts in the arguments of `printf`, never in its format string
> - ⚠️ CONSIDER: `echo` is fine for a fixed message that holds no variable and does not start with `-`
> - ❌ AVOID: Do not use `echo -e` or `echo -n`, and do not `echo` a value that may start with `-` or hold a backslash `BSG100`

`echo` reads its first arguments as options and, depending on the shell and `xpg_echo`, expands backslashes. `echo "${value}"` prints nothing when the value is `-n`, and turns `C:\temp` into a tab when the value goes through `echo -e`. `printf '%s\n'` prints its argument as it is, on every system. A value in the format string is just as unsafe: a `%` in it is read as a directive.

**Recommended**

```sh
printf '%s\n' "${value}"
printf 'Processed: %s\n' "${count}" >&2
printf '%s' "${token}" | gpg --encrypt --recipient "${recipient}"

# A fixed message with no variable
echo "Installing tools"
```

**Discouraged**

```sh
# Prints nothing when value is -n
echo "${value}"
# Expands backslashes in the data, and -n is not portable
echo -e "${message}"
echo -n "${token}" | gpg --encrypt --recipient "${recipient}"
```

### Here Documents

> [!TIP]
>
> - ✔️ SHOULD: Quote the delimiter, `<< 'EOF'`, when the text holds no expansion, so `$`, backticks and backslashes stay as written
> - ✔️ SHOULD: Leave the delimiter unquoted only when the text expands variables on purpose
> - ✔️ SHOULD: Write the body and the closing delimiter at the start of the line
> - ❌ AVOID: Do not use `<<-` to indent a here document: it strips tabs only, which the guide does not allow `BSG101`
> - ❌ AVOID: Do not escape every `$` of a text that expands nothing: quote the delimiter instead `BSG102`

An unquoted delimiter runs parameter expansion, command substitution and arithmetic on the whole body: a help text that mentions `$(date)` runs `date`, and a price of `$5` becomes the fifth argument. The quoted form makes the body literal. `<<-` removes leading tabs and nothing else, so with the two-space indentation of this guide it does nothing, and the closing `EOF` is not found.

**Recommended**

```sh
# Literal text: nothing in it is expanded
cat << 'EOF'
Run: ${HOME}/bin/tool --all
EOF

# Expansion on purpose
cat << EOF > "${config}"
user = ${user}
cache = ${cache_dir}
EOF

# Inside a block, the body and EOF still start the line
if [[ -n "${verbose}" ]]; then
  cat << EOF
Using ${config}
EOF
fi
```

**Discouraged**

```sh
# Escaping by hand: miss one and it expands
cat << EOF
Run: \$HOME/bin/tool, cost: \$5
EOF

# Tab-indented with <<-, which breaks as soon as an editor turns the tabs into spaces
	cat <<- EOF
	Using ${config}
	EOF
```

### Arrays

> [!TIP]
>
> - ✔️ SHOULD: Use an array whenever you hold more than one value, especially command line flags
> - ✔️ SHOULD: Declare arrays explicitly: `local -a names=()` inside a function, `declare -a NAMES=()` at file scope
> - ✔️ SHOULD: Append with `names+=("${value}")`
> - ✔️ SHOULD: Expand with `"${names[@]}"`, and take the length with `"${#names[@]}"`
> - ✔️ SHOULD: Expand an array that may be empty as `${names[@]+"${names[@]}"}` when the script supports Bash 4.3 under `set -u` `BSG049`
> - ✔️ SHOULD: Iterate the indexes an array really has with `"${!names[@]}"`
> - ✔️ SHOULD: Replace an array with `names=("${value}")`, and empty it with `names=()`
> - ❌ AVOID: Do not keep several values in one string separated by spaces
> - ❌ AVOID: Do not walk `0` to `${#names[@]} - 1` over an array the function did not build itself `BSG085`
> - ❌ AVOID: Do not assign a plain value to an array, `names="${value}"`: it replaces element 0 and keeps all the others `BSG113`

A space-separated string is only an array as long as no element contains a space. An array stays correct whatever the elements are, and `"${names[@]}"` passes exactly as many arguments as there are elements, including none.

Before Bash 4.4, `set -u` treats an empty array as unset, so `"${names[@]}"` on an empty array stops the script with `unbound variable`. `${names[@]+"${names[@]}"}` expands to nothing when the array is empty and to every element otherwise, on every version.

**Recommended**

```sh
BUILD_ARGS=()
SECRETS=()
SECRETS+=(--secret "id=age_passphrases,env=AGE_PASSPHRASES")
BUILD_ARGS+=(--build-arg IDENTITIES="personal")
dybatpho::dry_run docker build "${BUILD_ARGS[@]}" "${SECRETS[@]}" .

# May be empty, and the script still runs on Bash 4.3
local -a extra=()
docker run ${extra[@]+"${extra[@]}"} "${image}"
```

**Discouraged**

```sh
# Breaks as soon as a value contains a space, and quoting cannot fix it
BUILD_ARGS="--build-arg IDENTITIES=personal"
docker build $BUILD_ARGS .

# `unbound variable` on Bash 4.3 under `set -u` when no option was added
local -a extra=()
docker run "${extra[@]}" "${image}"
```

An array can be sparse: after `unset 'names[1]'` the indexes are `0` and `2`, and `${#names[@]}` is `2`. A counting loop then reads the missing index — empty, or `unbound variable` under `set -u` — and never reaches the last element.

**Recommended**

```sh
local index
for index in "${!names[@]}"; do
  printf '%s=%s\n' "${index}" "${names[index]}"
done
```

**Discouraged**

```sh
# Misses the last element of a sparse array, and stops on the gap under set -u
for ((index = 0; index < ${#names[@]}; index++)); do
  printf '%s\n' "${names[index]}"
done
```

A plain assignment to an array name writes element 0. After `files=(a b c)` and `files=x`, the array is `(x b c)`: code that meant to start over still finds the old entries, and `files+=x` appends to the first string instead of adding an element.

**Recommended**

```sh
files=("${only_file}")
files+=("${another_file}")
files=()
```

**Discouraged**

```sh
# Leaves files[1] and files[2] in place
files="${only_file}"
# Appends to the text of files[0]
files+="${another_file}"
```

### Associative Arrays

> [!TIP]
>
> - ✔️ SHOULD: Declare a map explicitly, `local -A name=()` or `declare -A NAME=()`: without `-A` the keys are evaluated as arithmetic `BSG103`
> - ✔️ SHOULD: Quote a key that comes from a variable: `"${map["${key}"]}"`
> - ✔️ SHOULD: Test whether a key exists with `[[ -v map["${key}"] ]]`, which tells a missing key from an empty value
> - ✔️ SHOULD: Sort the keys before using their order: `"${!map[@]}"` comes out in no particular order
> - ❌ AVOID: Do not rely on the order of `"${!map[@]}"`, and do not use `[[ -n "${map[key]}" ]]` as an existence test

Without `-A`, `versions[jq]=1` assigns to an indexed array: `jq` is read as an arithmetic variable, worth `0`, so every key lands on index `0` and overwrites the last one. The keys of a map come out in hash order, which changes with the keys and between Bash versions, so output built from it is not reproducible until it is sorted.

**Recommended**

```sh
local -A versions=()
versions["jq"]="1.7.1"
versions["yq"]="4.44.3"

# Present, even when the value is empty
if [[ -v versions["${tool}"] ]]; then
  printf '%s\n' "${versions["${tool}"]}"
fi

# A stable order
local -a tools=()
mapfile -t tools < <(printf '%s\n' "${!versions[@]}" | LC_ALL=C sort)
```

**Discouraged**

```sh
# No `declare -A`: this sets index 0 of an indexed array
versions[jq]="1.7.1"

# Empty and missing look the same, and the loop order changes between runs
[[ -n "${versions[${tool}]}" ]] && install "${tool}"
for tool in "${!versions[@]}"; do
  printf '%s\n' "${tool}"
done
```

### Pipes to While

> [!TIP]
>
> - ✔️ SHOULD: Feed a `while read` loop with process substitution: `while read -r line; do ...; done < <(command)`
> - ✔️ SHOULD: Use `readarray -t` or `mapfile -t` when the whole output is wanted as an array
> - ✔️ SHOULD: Use `read -r`, and `mapfile -d ''` with `-print0` when the values may contain newlines
> - ✔️ SHOULD: Read every line, including a last one without a newline: `while IFS= read -r line || [[ -n "${line}" ]]` `BSG094`
> - ❌ AVOID: Do not pipe into a `while` loop `BSG041`
> - ❌ AVOID: Do not rely on `while read -r line` alone for input that may not end with a newline

The right-hand side of a pipe runs in a subshell, so every variable the loop sets is discarded when the loop ends. Process substitution keeps the loop in the current shell.

**Recommended**

```sh
local -a files=()
mapfile -d '' -t files < <(command find "${root}" -type f -print0 | sort -z)

local -a tools=()
readarray -t tools < <(dytoy::get_yaml "${name}" "tools")

local count=0 path
while IFS= read -r -d '' path; do
  count=$((count + 1))
done < <(command find "${root}" -type f -print0)
printf '%s\n' "${count}"
```

**Discouraged**

```sh
# count is always 0 here: the loop ran in a subshell
local count=0
command find "${root}" -type f | while read -r line; do
  count=$((count + 1))
done
printf '%s\n' "${count}"
```

`read` returns non-zero when it hits the end of input before a newline, even though it has filled the variable. A file whose last line has no newline — common for hand-edited configs and `printf '%s'` output — loses that line. `IFS=` also keeps leading and trailing blanks.

**Recommended**

```sh
local line
while IFS= read -r line || [[ -n "${line}" ]]; do
  process "${line}"
done < "${file}"
```

**Discouraged**

```sh
# The last line is dropped when the file does not end with a newline
while read -r line; do
  process "${line}"
done < "${file}"
```

### Process Substitution

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Capture the output of a producer that can fail into a variable first, check its status, then read the variable: `listing="$(cmd)" || return $?` `BSG048`
> - ✔️ SHOULD: Validate what a producer is given before reading it through `< <(...)`, when only bad input can make it fail
> - ✔️ SHOULD: Turn on `pipefail` when the left side of a pipe can fail and the result depends on it
> - ❌ AVOID: Do not read `< <(cmd)` or `<(cmd)` from a command whose failure has to stop the work

Nothing waits for the command inside `<(...)`: `mapfile`, `while read` and the function around them succeed whether it failed or not, so a failing producer reads as empty input. A corrupt archive then lists no entries and passes a safety check, and two documents that do not parse compare as identical. The left side of a pipe is lost the same way without `pipefail`. [Pipes to While](#pipes-to-while) is about keeping variables; this is about keeping the failure.

**Recommended**

```sh
local listing
listing="$(tar -tzf "${archive}")" || dybatpho::die "Cannot list ${archive}"
local -a entries=()
[[ -z "${listing}" ]] || mapfile -t entries <<< "${listing}"
```

**Discouraged**

```sh
# A corrupt archive lists nothing, and the loop finds nothing unsafe
local -a entries=()
mapfile -t entries < <(tar -tzf "${archive}")
```

### For Loops

> [!TIP]
>
> - ✔️ SHOULD: Iterate over an array with `for item in "${items[@]}"`
> - ✔️ SHOULD: Read command output into an array first, then loop over it
> - ✔️ SHOULD: Count with brace expansion, `for i in {1..5}`, when both bounds are literal, and with `for ((i = start; i <= end; i++))` when one is a variable
> - ❌ AVOID: Do not write `for item in $(command)` when the output may contain spaces `BSG042`
> - ❌ AVOID: Do not generate a sequence with `seq` `BSG124`

`for item in $(command)` splits on every space, tab and newline, and then globs the result. It is correct only for output you control completely.

**Recommended**

```sh
local -a dependencies=()
readarray -t dependencies < <(dytoy::get_yaml "${name}" "dependencies")
local dependency
for dependency in "${dependencies[@]}"; do
  dybatpho::dry_run dytoy "${method}" -i -t "${dependency}"
done
```

**Discouraged**

```sh
# A dependency name containing a space becomes two iterations
for dependency in $(dytoy::get_yaml "$name" "dependencies"); do
  dytoy "${method}" -i -t "$dependency"
done
```

`seq` is an external command, so every loop over it starts a process, and its output goes through the word splitting of `$(...)`. Brace expansion makes a fixed range in the shell, but it happens before variables are expanded, so `{1..${count}}` stays a literal word; an arithmetic `for` takes variables.

**Recommended**

```sh
local attempt
for attempt in {1..3}; do
  printf 'Attempt %d\n' "${attempt}"
done

local -i index
for ((index = 1; index <= count; index++)); do
  printf 'Worker %d\n' "${index}"
done
```

**Discouraged**

```sh
# A process for the sequence, and word splitting on its output
for index in $(seq 1 "${count}"); do
  printf 'Worker %d\n' "${index}"
done

# Not a range: brace expansion runs before ${count} is expanded
for index in {1..${count}}; do
  printf 'Worker %d\n' "${index}"
done
```

### Local Variables

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Declare `local` every variable a function assigns: loop variables, the targets of `read`, `mapfile`, `readarray` and `printf -v`, and plain assignments `BSG016`
> - ✔️ SHOULD: Document a deliberate global with `@set` in the function comment, and name it in `UPPERCASE`
> - ❌ AVOID: Do not let a loop variable or a `read` target leak out of a function

A variable a function assigns without declaring it is global. It outlives the function, and it overwrites a variable of the same name in every caller: a helper that loops with `for i` silently moves the caller's own `i` loop. [Variable Names](#variable-names) asks for `local`; these are the assignments that are easiest to forget.

**Recommended**

```sh
function fs::count_lines {
  local file total=0 line
  for file in "$@"; do
    while IFS= read -r line || [[ -n "${line}" ]]; do
      total=$((total + 1))
    done < "${file}"
  done
  local summary
  printf -v summary '%d lines' "${total}"
  printf '%s\n' "${summary}"
}
```

**Discouraged**

```sh
function fs::count_lines {
  local total=0
  # `file`, `line` and `summary` are globals now, and clobber the caller's
  for file in "$@"; do
    while IFS= read -r line || [[ -n "${line}" ]]; do
      total=$((total + 1))
    done < "${file}"
  done
  printf -v summary '%d lines' "${total}"
  printf '%s\n' "${summary}"
}
```

### Arithmetic

> [!TIP]
>
> - ✔️ SHOULD: Use `(( ... ))` for arithmetic conditions and `$(( ... ))` for arithmetic values
> - ✔️ SHOULD: Omit the `$` on variables inside `(( ... ))`
> - ✔️ SHOULD: Declare counters with `local -i` when the variable only ever holds an integer
> - ✔️ SHOULD: Validate a number from input with a regular expression, and force base 10 in arithmetic: `$((10#${count}))`
> - ✔️ SHOULD: Increment with `((count += 1))` or `count=$((count + 1))`
> - ✔️ SHOULD: Compute with fractions in `awk`, passing the values with `-v`: Bash arithmetic is integer only
> - ❌ AVOID: Do not use `let`, `expr` or the deprecated `$[ ... ]`
> - ❌ AVOID: Do not feed a number read from input, a file name or a date straight into `(( ))`: a leading zero makes it octal `BSG087`
> - ❌ AVOID: Do not write `((count++))` or `((count--))` as a statement under `set -e` `BSG088`
> - ⚠️ CONSIDER: Be careful with a bare `(( ... ))` under `set -e`: an expression whose value is `0` has exit status `1` and stops the script
> - ❌ AVOID: Do not compare decimal numbers with `[[ < ]]` or feed them to `(( ))`: the first compares text, the second refuses the dot

`(( ... ))` is a builtin, so it is faster than `expr` and does not need a subprocess, and it treats its operands as numbers rather than strings.

**Recommended**

```sh
if ((${#MAIN_ARGS[@]} > 0)); then
  exec "${BATS_CMD}" "${MAIN_ARGS[@]}"
fi

local -i retries=0
retries=$((retries + 1))

# Never 0 after the increment, so the line never fails under set -e
((count += 1))
```

**Discouraged**

```sh
# External process for something the shell can do
retries=$(expr "$retries" + 1)

# Deprecated syntax
retries=$[retries + 1]

# Under set -e this stops the script the first time count goes from 0 to 1
((count++))
```

Bash reads `010` as eight, and refuses `08` and `09` outright with `value too great for base`. Numbers with leading zeros are everywhere in input — dates, times, zero-padded counters, file suffixes — so arithmetic on them works in testing and fails on the eighth of the month.

**Recommended**

```sh
[[ "${minute}" =~ ^[0-9]+$ ]] || dybatpho::die "Not a minute: ${minute}"
if ((10#${minute} >= 30)); then
  half=second
fi
```

**Discouraged**

```sh
minute="$(date +%M)"
# At eight past the hour: `08: value too great for base`
if ((minute >= 30)); then
  half=second
fi
```

`(( ))` returns the status of its value, and `count++` evaluates to the value *before* the increment. When that value is `0`, the statement returns 1 and `set -e` ends the script — on the very first pass of a loop that counts from zero.

**Recommended**

```sh
local count=0
((count += 1))
count=$((count + 1))
```

**Discouraged**

```sh
local count=0
# Evaluates to 0, returns 1, and set -e ends the script here
((count++))
```

`$((10 / 3))` is `3`, and `((1.5 > 1))` stops with a syntax error. A load average, a percentage or a duration with a fraction belongs to `awk`, which also answers a comparison with its exit status.

**Recommended**

```sh
ratio="$(awk -v used="${used}" -v total="${total}" 'BEGIN { printf "%.2f", used / total }')"
if awk -v value="${load}" 'BEGIN { exit !(value > 1.5) }'; then
  dybatpho::warn "Load is ${load}"
fi
```

**Discouraged**

```sh
# Text comparison: "10.0" < "9.5"
[[ "${load}" > "1.5" ]]
# syntax error: invalid arithmetic operator
((load > 1.5))
```

### Portability

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Probe for a feature before using a GNU-only flag, and keep a portable branch: `date -d`, `sed -i`, `readlink -f`, `stat -c`, `find -printf`, `grep -P`, `xargs -r`, `mktemp --suffix` `BSG083`
> - ✔️ SHOULD: Detect a feature by trying the flag, not by the name of the tool or its `--version`
> - ❌ AVOID: Do not assume GNU coreutils when the script runs on macOS, BSD or BusyBox
> - ⚠️ CONSIDER: Prefer a Bash builtin or a POSIX form when one does the job: `printf '%(%s)T'`, parameter expansion

macOS ships BSD tools and Alpine ships BusyBox, and the same flag means something else, or nothing, on each: `sed -i` wants a backup suffix on BSD, `stat -c` is `stat -f` there, and `date -d` does not exist. `date --version` failing does not make a system BSD — BusyBox fails it too — so test the behaviour itself, once, and keep the answer.

**Recommended**

<!-- lint: allow BSG083 -->
```sh
function __date_from_epoch {
  local epoch format
  dybatpho::expect_args epoch format -- "$@"
  if date -d @0 +%s &> /dev/null; then
    date -d "@${epoch}" "+${format}"
  else
    date -r "${epoch}" "+${format}"
  fi
}

# A portable in-place edit: write a copy, then move it over the file
local staging
staging="$(mktemp "$(dirname -- "${file}")/.staging.XXXXXXXX")"
sed 's/old/new/' "${file}" > "${staging}" && mv -- "${staging}" "${file}"
```

**Discouraged**

```sh
# GNU only: fails on macOS and on BusyBox
date -d "@${epoch}" +%F
sed -i 's/old/new/' "${file}"
target="$(readlink -f "${link}")"
```

### Comparing Versions

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Compare versions with a semantic-version helper
> - ⚠️ CONSIDER: Use `sort -V` only for plain dotted numbers such as `1.10.2`, where it is available
> - ❌ AVOID: Do not compare versions with string `<` or `>`, or with arithmetic on dotted strings `BSG097`
> - ❌ AVOID: Do not order versions that may carry a pre-release suffix with `sort -V`: it puts `2.0.0-rc1` after `2.0.0`

String comparison is character by character, so `1.10.0` sorts before `1.9.0`, and `2.0.0-rc1` after `2.0.0`. Arithmetic does not work on dotted strings at all. A version check that gets this wrong upgrades a newer install, or refuses one that is new enough.

`sort -V` fixes the numbers but not the suffix: it reads `-rc1` as more characters after `2.0.0`, so a release candidate comes out newer than the release it precedes.

**Recommended**

```sh
if dybatpho::semver_satisfies "${installed}" ">=1.10.0"; then
  use_new_flag=true
fi

newest="$(dybatpho::semver_max "${a}" "${b}")"

# Without a library: sort -V, for versions that are only dotted numbers
[[ "${a}" =~ ^[0-9]+(\.[0-9]+)*$ && "${b}" =~ ^[0-9]+(\.[0-9]+)*$ ]] \
  || dybatpho::die "Not a plain version: ${a} ${b}"
newest="$(printf '%s\n' "${a}" "${b}" | sort -V | tail -n 1)"
```

**Discouraged**

```sh
# "1.10.0" < "1.9.0" as strings, so a newer version looks older
if [[ "${installed}" < "1.9.0" ]]; then
  upgrade
fi

# Prints 2.0.0-rc1: the release candidate looks newer than the release
newest="$(printf '%s\n' 2.0.0-rc1 2.0.0 | sort -V | tail -n 1)"
```

## Calling Commands

### Checking Return Values

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Let `set -euo pipefail`, or `dybatpho::register_common_handlers`, stop the script on an unhandled failure. (dybatpho)
> - ✔️ SHOULD: Test a command directly: `if ! command; then ... fi`
> - ✔️ SHOULD: Append `|| true` to a command whose failure is genuinely expected, and say in a comment why
> - ✔️ SHOULD: Exit with a meaningful status: `0` on success, non-zero on failure
> - ✔️ SHOULD: End a function, or a script, with a statement whose status is the result: write `if cond; then action; fi` or `cond || return 0`, not a bare `cond && action`
> - ✔️ SHOULD: Silence the one command whose failure is expected, not the function or loop around it
> - ❌ AVOID: Do not inspect `$?` in a separate statement `BSG044`
> - ❌ AVOID: Do not rely on `PIPESTATUS` `BSG044`
> - ❌ AVOID: Do not end a function with `[[ ... ]] && action` or `((flag)) && action`: when the test is false, the function returns 1 and `set -e` stops the caller `BSG110`
> - ❌ AVOID: Do not redirect a whole block to `/dev/null`, as in `} 2> /dev/null` or `done 2> /dev/null`: it hides every error in it, not only the expected one `BSG120`

Reading `$?` on the next line only works if nothing else ran in between, which is a condition nobody can keep while the script grows. Testing the command itself cannot go stale. An explicit `|| true` is also a marker: it tells the next reader that the failure was considered, rather than forgotten.

**Recommended**

```sh
if ! command -v sudo &> /dev/null; then
  dybatpho::die "sudo is required"
fi

# grep exits 1 when it matches nothing, which is a valid outcome here
expected_hash=$(grep -E "[[:space:]]\*?${asset_name}\$" "${sha256_file}" | awk '{print $1}') || true

# The submodule may already be present, do not fail the run over it
git -C "${DYBATPHO_DIR}" submodule update --init --recursive 2> /dev/null || true
```

**Discouraged**

```sh
# Fragile: any added line between the two breaks the check
curl -fsSL "$url" -o "$file"
if [[ $? -ne 0 ]]; then
  echo "download failed"
fi
```

The status of a function is the status of its last statement, and `set -e` only spares the left side of `&&`. A function that ends with `[[ -n "${verbose}" ]] && log "done"` therefore returns 1 whenever `verbose` is empty, and the caller stops on a function that did everything it was asked. The same holds for the last line of a script, which becomes its exit status.

**Recommended**

```sh
function report::summary {
  local verbose
  dybatpho::expect_args verbose -- "$@"
  if dybatpho::is true "${verbose}"; then
    dybatpho::info "Summary written"
  fi
}

# Only the probe that may fail is silenced
rmdir -- "${maybe_empty}" 2> /dev/null || true # still populated: another job owns it
```

**Discouraged**

```sh
function report::summary {
  # Returns 1 when verbose is false, and set -e stops the caller
  [[ "$1" == true ]] && dybatpho::info "Summary written"
}

# Every error of every command in the function is gone
function sync::all {
  cp -- "${src}" "${dst}"
  rmdir -- "${maybe_empty}"
} 2> /dev/null
```

### Errexit in Conditions

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Turn on `shopt -s inherit_errexit` next to `set -euo pipefail`, so a failure inside `$(...)` stops the substitution. (custom) `BSG104`
> - ✔️ SHOULD: End each step with `|| return $?` in a function that may be called from `if`, `while`, `!`, `&&` or `||`
> - ❌ AVOID: Do not rely on `set -e` inside a function whose caller tests its status: errexit is off for everything that function runs
> - ❌ AVOID: Do not expect `set -e` to stop at a failing command in the middle of `$(a; b)` without `inherit_errexit`

`set -e` is suspended for the whole command tested by `if`, `while`, `until`, `!`, `&&` or `||`, and that includes every line of a function called there. A function that relies on errexit therefore stops at its first failure when called on its own, and carries on to the end when the caller writes `if fn`. Its status is then the status of its last line, which may well be `0`. Inside `$(...)` errexit is off as well, until `inherit_errexit` (Bash 4.4) passes it down.

dybatpho turns on the strict mode when it is sourced; `inherit_errexit` is still the script's to set. (dybatpho)

**Recommended**

```sh
shopt -s inherit_errexit

# Each step returns its own failure, whoever calls the function
function deploy::upload {
  local archive
  dybatpho::expect_args archive -- "$@"
  tar -czf "${archive}" -C "${BUILD_DIR}" . || return $?
  scp -o ConnectTimeout=10 -- "${archive}" "${HOST}:" || return $?
}

if ! deploy::upload "${archive}"; then
  dybatpho::die "Upload of ${archive} failed"
fi
```

**Discouraged**

```sh
function deploy::upload {
  tar -czf "$1" -C "${BUILD_DIR}" .
  # Uploads a broken archive when tar failed: errexit is off inside a function called by `if`
  scp -o ConnectTimeout=10 -- "$1" "${HOST}:"
}

if ! deploy::upload "${archive}"; then
  dybatpho::die "Upload of ${archive} failed"
fi
```

### Error Handling

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Handle an error in the function where it happens, not in the caller
> - ✔️ SHOULD: Stop with `dybatpho::die` when the script cannot continue, and `return 1` when the caller can. (dybatpho)
> - ✔️ SHOULD: Say what failed and what the user can do about it, in a message on `STDERR`
> - ✔️ SHOULD: Install the common handlers once, at the top of an entrypoint, with `dybatpho::register_common_handlers`. (dybatpho) `BSG053`
> - ✔️ SHOULD: Name the function the caller called in an error message: `FUNCNAME[1]` from a helper that function calls directly, a name it passes in, or the first public function on the stack
> - ✔️ SHOULD: Show a value that came from outside — a file name, an argument, a line of input — with `${value@Q}` in a message
> - ❌ AVOID: Do not return a bare non-zero status with no message
> - ❌ AVOID: Do not reach a fixed deeper level such as `FUNCNAME[2]`, which names another function as soon as the call depth changes `BSG054`

The function that fails is the only place that still knows the file name, the URL and the option that produced the failure. A caller that receives only `1` can either report nothing useful or invent context.

The message also has to name the call the script made. `FUNCNAME[2]` is right only for as long as the helper sits exactly two calls below the public function; called directly, or through one more layer, it names the script's own caller or a test runner instead, and points away from the call at fault.

**Recommended**

```sh
if [[ ! -x "${BATS_CMD}" ]]; then
  dybatpho::die "Bats not found. Install bats, or run: git -C ${DYBATPHO_DIR} submodule update --init --recursive"
fi

function get_dir {
  local config_dir
  dybatpho::expect_args config_dir -- "$@"
  if [[ ! -e "${config_dir}" ]]; then
    dybatpho::error "Configuration directory ${config_dir} does not exist"
    return 1
  fi
  printf '%s\n' "${config_dir}"
}

# The caller passes its own name, so the message names it at any depth
function __csv_require_text {
  local caller text
  dybatpho::expect_args caller text -- "$@"
  [[ "${text}" != *$'\x1f'* ]] || dybatpho::die "${caller}: The input contains the unit separator"
}

function csv::read {
  local input
  dybatpho::expect_args input -- "$@"
  __csv_require_text "${FUNCNAME[0]}" "${input}"
}
```

**Discouraged**

```sh
# The caller has no way to tell what went wrong
function get_dir {
  [[ -e "$1" ]] || return 1
  echo "$1"
}

# Names csv::read's caller, not csv::read, when csv::read calls this directly
function __csv_require_text {
  [[ "$1" != *$'\x1f'* ]] || dybatpho::die "${FUNCNAME[2]}: The input contains the unit separator"
}
```

A file name may hold a newline, a tab or a terminal escape sequence. Printed as it is, it splits one log record in two, forges a line that looks like another message, or rewrites the terminal. `${value@Q}` (Bash 4.4) quotes the value the way the shell would read it back, so every character is visible and nothing is interpreted.

**Recommended**

```sh
dybatpho::die "File not found: ${path@Q}"
# File not found: $'report\n2026 INFO all checks passed'
```

**Discouraged**

```sh
# A name holding a newline prints a second, forged log line
dybatpho::die "File not found: ${path}"
```

### Exit Codes

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Exit with `0` on success, `1` on a general failure, and `2` on wrong usage, such as a missing or unknown option. (custom)
> - ✔️ SHOULD: Document every other status a function or script returns with `@exitcode`, and keep its meaning stable
> - ✔️ SHOULD: Exit with `128 + n` after a handler for signal `n` that ends the script: `130` for `INT`, `143` for `TERM`
> - ❌ AVOID: Do not use `126`, `127` or anything above `128` for your own meaning: the shell reports "not executable", "not found" and signals with them `BSG105`
> - ❌ AVOID: Do not exit with a status outside `0`–`255`: it is taken modulo 256, so `256` is success `BSG105`

A caller can only act on a status it understands. `2` for usage is what Bash builtins and most tools already use, `126` and `127` are what the shell sets when a command cannot run, and anything above `128` reads as "killed by a signal". A status of your own that collides with them sends the caller down the wrong branch, and an undocumented one cannot be handled at all.

**Recommended**

```sh
#######################################
# @description Download a release asset
# @arg $1 string Name of the asset
# @exitcode 0 Downloaded
# @exitcode 1 The download failed
# @exitcode 2 Wrong usage: no asset name
# @exitcode 3 The asset is not published for this platform
#######################################
function release::fetch {
  (($# == 1)) || return 2
  ...
}

# Ctrl-C: the status a parent shell expects
trap 'exit 130' INT
```

**Discouraged**

```sh
# Reads as "command not found", as 44, and as 255
exit 127
exit 300
exit -1

# A status nobody documented, borrowed from another tool
curl --fail -sS "${url}" || return 22
```

### Builtin Commands vs External Commands

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Prefer a builtin to an external command for the same job: parameter expansion over `sed`, `(( ... ))` over `expr`, `[[ ... ]]` over `test`
> - ✔️ SHOULD: Use an external tool such as `sed`, `awk` or `yq` when it makes the code clearly shorter and clearer
> - ✔️ SHOULD: Call an external tool through `command <tool>` when an alias or a function of the same name may be in scope. (custom)
> - ✔️ SHOULD: Read a whole file with `$(< file)`, not `$(cat file)` `BSG108`
> - ✔️ SHOULD: End `find -exec` with `+`, which runs the command once for many files, unless the command takes exactly one `BSG119`
> - ✔️ SHOULD: Split a string into fields with `read`, `IFS=: read -r user _ uid _ <<< "${record}"`, naming each field you discard `_` `BSG126`
> - ✔️ SHOULD: Give a file to the command by name, `grep foo "${file}"`, or with `< "${file}"`. `useless-use-of-cat` in [`.shellcheckrc`](.shellcheckrc) checks it
> - ⚠️ CONSIDER: Split on a delimiter of several characters, or keep an empty last field, with `dybatpho::split` into an array: `mapfile -t parts < <(dybatpho::split "${entry}" ' :: ')`. (dybatpho)
> - ⚠️ CONSIDER: Move an external command out of a loop over many items: one `sed` over the whole input instead of one per line
> - ❌ AVOID: Do not build a parameter expansion so intricate that the reader has to test it to know what it does
> - ❌ AVOID: Do not pipe a string into `cut` or `awk '{print $2}'` to take one field of it
> - ❌ AVOID: Do not write `cat file | command` for a command that reads a file or standard input

Builtins do not fork, so they are faster in a loop, and they behave the same on every machine. The exception is text transformation over many lines, where `sed` or `awk` say in one line what parameter expansion needs a loop for.

**Recommended**

```sh
# Builtin expansion for simple slicing
local asset_name="${url##*/}"
local base_url="${url%/*}"

# External tool where it is genuinely clearer
function misc::replace_version {
  local version
  dybatpho::expect_args version -- "$@"
  sed -e "s/%v/${version}/g" -e "s/%1v/${version:1}/g"
}

# The real binary, not a user alias or a wrapper function
mapfile -d '' -t files < <(command find "${root}" -type f -print0)

# No process for reading a file
version="$(< "${version_file}")"
```

**Discouraged**

```sh
# A process per line to do what ${url##*/} does
asset_name="$(echo "$url" | rev | cut -d/ -f1 | rev)"

# Unreadable, and it does the same as a two-line sed
result="${input//${a}\/${b}/${c}${d//x/y}}"

# A process per line, for what one sed does once
while IFS= read -r line; do
  printf '%s\n' "$(echo "${line}" | sed 's/old/new/')"
done < "${file}"
```

`-exec cmd {} \;` starts one process per match, which over a tree of thousands of files is most of the run time. `-exec cmd {} +` passes as many paths as fit on one command line.

**Recommended**

```sh
command find "${root}" -name '*.log' -mtime +7 -exec gzip -- {} +
```

**Discouraged**

```sh
# One gzip per file
command find "${root}" -name '*.log' -mtime +7 -exec gzip -- {} \;
```

`read` splits a string on the characters of `IFS` and puts each field in a name, so a record is taken apart in the shell, and every field gets a name the code below can read. `_` takes a field that is not needed, and the last name takes the rest of the line.

**Recommended**

```sh
local user uid home
IFS=: read -r user _ uid _ _ home _ <<< "${record}"
```

**Discouraged**

```sh
# Three processes, and each field read from a separate pass
user="$(echo "${record}" | cut -d: -f1)"
uid="$(echo "${record}" | cut -d: -f3)"
home="$(echo "${record}" | awk -F: '{print $6}')"
```

`IFS` is a set of single characters, so `IFS=' :: '` splits on every space and every colon, and `read -a` drops an empty last field: `a:b:` gives two fields, not three. `dybatpho::split` takes the delimiter as one literal string, and keeps every field, the empty ones included. (dybatpho)

**Recommended**

```sh
local -a parts=()
mapfile -t parts < <(dybatpho::split "${entry}" ' :: ')
```

**Discouraged**

```sh
# Splits on every space and every colon, not on " :: "
IFS=' :: ' read -r -a parts <<< "${entry}"
```

`cat` in front of a command that can open the file itself is one more process and one more pipe, and it hides the file name from the error messages of the command.

**Recommended**

```sh
grep -c -- "${pattern}" "${file}"
```

**Discouraged**

```sh
# A process and a pipe for nothing, and grep no longer knows the file name
cat "${file}" | grep -c -- "${pattern}"
```

### Signal Handlers

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Compose a handler with the handlers already installed (`dybatpho::trap`) rather than replacing them. (dybatpho)
> - ✔️ SHOULD: Save the caller's handlers before a scoped call and restore them after it
> - ✔️ SHOULD: Run the cleanup of a scoped call before a caller's handler that exits, then re-raise the signal, so that handler and the default action still happen
> - ✔️ SHOULD: Write a trap command in single quotes, so its variables expand when the trap runs, not when it is installed
> - ✔️ SHOULD: Let an `EXIT` handler keep the script's status: read `$?` first and end with `exit "${status}"`, or end without `exit`
> - ❌ AVOID: Do not install a library handler with a plain `trap '…' SIG`, and do not clear one with `trap - EXIT` `BSG055`
> - ❌ AVOID: Do not end an `EXIT` handler with `exit 0` or any fixed status: a script that failed reports success `BSG111`

A library shares the trap table with the script that sourced it. `trap '…' INT` in a library silently removes the script's own Ctrl-C handling, and `trap - EXIT` removes cleanup someone else registered. Order matters as much: a caller's handler that calls `exit` ends the shell before a handler appended after it runs, so a lock is never released and child jobs keep running. A scoped call therefore installs its handler alone, puts the saved ones back when it ends, and re-raises the signal it caught.

**Recommended**

<!-- lint: allow BSG040 -->
```sh
function lib::with_lock {
  local __lib_saved __lib_caught=""
  __lib_saved="$(trap -p INT TERM)"
  trap '__lib_caught=INT' INT
  trap '__lib_caught=TERM' TERM
  "$@" || true
  lib::release
  # Put back what the caller had, then let its handler and the default run
  trap - INT TERM
  eval "${__lib_saved}"
  [[ -z "${__lib_caught}" ]] || kill -s "${__lib_caught}" "${BASHPID}"
}
```

**Discouraged**

```sh
function lib::with_lock {
  # Replaces the caller's handlers for the rest of the script
  trap 'lib::release; exit 1' INT TERM
  "$@"
  lib::release
  trap - EXIT INT TERM
}
```

A trap command in double quotes is expanded once, when `trap` runs: `trap "rm -f ${temp_file}" EXIT` removes the file that was named at that moment, not the one the variable names when the script ends, and a path holding a quote breaks the handler. An `EXIT` handler also decides the exit status when it calls `exit`, so `exit 0` there turns every failure into success for the caller.

**Recommended**

```sh
trap 'rm -f -- "${temp_file}"' EXIT

function _on_exit {
  local status=$?
  rm -rf -- "${work_dir:?}"
  exit "${status}"
}
trap _on_exit EXIT
```

**Discouraged**

```sh
# Expanded now: later changes to temp_file are ignored, and a quote in it breaks the handler
trap "rm -f ${temp_file}" EXIT

# A failed run exits 0
trap 'rm -rf -- "${work_dir}"; exit 0' EXIT
```

### Child Processes

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Start each background job in its own process group, and signal the group, so grandchildren stop too
> - ✔️ SHOULD: Repeat the signal until the group is empty, within a bounded grace period, then send `KILL`
> - ✔️ SHOULD: End every job a function started before it returns, also when it returns because of a signal
> - ✔️ SHOULD: Keep the pid of every background job, and wait for each of them, counting the failures: `wait "${pid}" || failed=$((failed + 1))`
> - ❌ AVOID: Do not signal only the pid of a job, and do not assume one `TERM` is enough
> - ❌ AVOID: Do not `wait` for jobs one after another under `set -e` without checking the status: the first failure stops the script and the other jobs are left behind `BSG112`

The pid of a job is often a subshell whose real work runs in a grandchild that a signal to the pid never reaches. Even a signal to the group can miss a process that has forked and not yet called `exec`: it still runs the parent shell's handlers, and a handler that catches `TERM` swallows the signal before `exec` resets it. Signalling until the group is empty, with `KILL` as the last step, is the only way to know nothing was left behind.

**Recommended**

```sh
set -m
worker "${item}" &
local pgid=$!
set +m
...
local tries=0
while kill -0 -- "-${pgid}" 2> /dev/null; do
  tries=$((tries + 1))
  if ((tries <= 50)); then
    kill -TERM -- "-${pgid}" 2> /dev/null
  else
    kill -KILL -- "-${pgid}" 2> /dev/null
  fi
  sleep 0.1
done
```

**Discouraged**

```sh
worker "${item}" &
local pid=$!
...
# The worker's own children keep running
kill "${pid}"
```

`wait "${pid}"` returns the status of that job, so under `set -e` a loop of bare `wait` calls stops at the first job that failed. The jobs after it are never waited for, their failures are never reported, and they keep running after the script has gone.

**Recommended**

```sh
local -a pids=()
local host pid failed=0
for host in "${hosts[@]}"; do
  deploy::host "${host}" &
  pids+=("$!")
done
for pid in "${pids[@]}"; do
  wait "${pid}" || failed=$((failed + 1))
done
((failed == 0)) || dybatpho::die "${failed} of ${#pids[@]} deployments failed"
```

**Discouraged**

```sh
for host in "${hosts[@]}"; do
  deploy::host "${host}" &
done
# Stops at the first failure: the other jobs are neither waited for nor reported
for pid in $(jobs -p); do
  wait "${pid}"
done
```

### End of Options

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Put `--` before operands that come from variables: `rm -- "${file}"`, `grep -- "${pattern}" "${file}"`
> - ❌ AVOID: Do not pass a variable as the first operand of a command without `--` when its value may start with `-` `BSG057`

A command reads every argument that starts with `-` as an option until it sees `--`. A file called `-rf`, a pattern like `-v`, or a path a user typed is then taken as a flag: the command fails, or does something else. BSD tools on macOS are stricter about the order than GNU ones, which is where a missing `--` usually shows.

**Recommended**

```sh
rm -f -- "${file}"
grep -- "${pattern}" "${file}"
chmod 600 -- "${path}"
```

**Discouraged**

```sh
# A file named -rf, or a pattern starting with -, is read as an option
rm -f "${file}"
grep "${pattern}" "${file}"
```

### Network Requests

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Use `curl --fail` (or check the HTTP status) before using a response `BSG056`
> - ✔️ SHOULD: Download to a file, verify it against a checksum or signature, then run it
> - ✔️ SHOULD: Bound every network call: `curl --connect-timeout` and `--max-time`, or `timeout` around a tool that has no limit of its own `BSG107`
> - ✔️ SHOULD: Retry only what may succeed on a second try, a bounded number of times: `curl --retry 3` retries timeouts and 5xx answers, not a 404
> - ✔️ SHOULD: Wait longer between each retry, with a random part and a cap: `delay=$((2 ** attempt + RANDOM % 3))` `BSG117`
> - ✔️ SHOULD: Bound `ssh` too, `-o ConnectTimeout=10 -o BatchMode=yes` under `timeout`, and tell a timeout (status 124) from a failure `BSG118`
> - ❌ AVOID: Do not pipe a download into a shell: `curl ... | bash`, `wget -O- ... | sh` `BSG058`
> - ❌ AVOID: Do not retry in a tight loop, `until curl ...; do :; done`, or forever

Without `--fail`, curl exits 0 on a 404 or a 500 and hands over the error page as if it were the content. Piped into `bash`, that page — or a download cut off halfway, or whatever an attacker served — runs line by line before anything checked it, and a partial line can do something no complete script would.

A request with no time limit waits as long as the server keeps the connection open: a CI job then hangs until the runner kills it, with no message saying which call stalled. A retry loop around a request that fails for good — a wrong URL, a missing permission — only makes the failure slower.

**Recommended**

```sh
local installer
dybatpho::create_temp installer ".sh"
curl --fail -sSL --connect-timeout 10 --max-time 300 --retry 3 "${url}" -o "${installer}"
dybatpho::verify_checksum "${installer}" "sha256:${expected_sha256}"
bash "${installer}"
```

**Discouraged**

```sh
# A 404 page, or a truncated script, runs as it arrives
curl -sSL "${url}" | bash
```

A failing service gets a retry from every client at once. Retrying without a pause, or after the same fixed delay everywhere, keeps it down; doubling the wait and adding a random part spreads the clients out, and a limit on the attempts turns an outage into an error instead of a hang. `ssh` waits for a host that drops packets as long as the kernel does, and for a password prompt forever, unless it is told otherwise.

**Recommended**

```sh
local attempt=1 delay
until curl --fail -sS --connect-timeout 10 --max-time 60 "${url}" -o "${target}"; do
  ((attempt < 5)) || dybatpho::die "Gave up on ${url} after ${attempt} attempts"
  # Doubling, with a random part so that clients do not retry together
  delay=$((2 ** attempt + RANDOM % 3))
  ((delay <= 60)) || delay=60
  sleep "${delay}"
  attempt=$((attempt + 1))
done

local status=0
timeout 300 ssh -o ConnectTimeout=10 -o BatchMode=yes -- "${host}" 'systemctl is-active app' || status=$?
case "${status}" in
  0) ;;
  124) dybatpho::die "${host} did not answer within 5 minutes" ;;
  *) dybatpho::die "${host}: the check failed with status ${status}" ;;
esac
```

**Discouraged**

```sh
# Hammers a service that is already failing, and never stops
until curl --fail -sS "${url}" -o "${target}"; do :; done
# Waits for a password, or for an unreachable host, with no limit
ssh "${host}" 'systemctl is-active app'
```

### Remote Commands

> [!TIP]
>
> - ✔️ SHOULD: Run a local function on a remote host by sending its definition, printed by `declare -f`, and then the call to `bash -s` on standard input
> - ✔️ SHOULD: Quote every local value that goes into a remote command with `${value@Q}`, or `printf %q` `BSG128`
> - ✔️ SHOULD: Send every function the remote side calls, and use only commands the remote host has
> - ❌ AVOID: Do not pass a remote command as separate words, as in `ssh "${host}" du -sh -- "${dir}"`: ssh joins them with spaces, and the remote shell splits them again
> - ❌ AVOID: Do not copy the body of a function into a command string by hand

`ssh` does not hand its arguments to the remote command one by one. It joins them with spaces into one string, and the login shell of the remote user splits that string again, so a value with a space, a `;` or a `$(...)` becomes more words, or a command, on the other side, even when it was quoted locally. A command string written by hand has the same problem, and drifts from the function it was copied from.

Send a script instead. `declare -f` prints a function as it is loaded, so the remote host runs the code the script tested, and `${value@Q}` writes each argument in a form that Bash reads back as the same value. Only `bash -s` goes through the remote login shell, so it does not matter whether that shell is Bash, `sh` or fish.

`declare -f` sends only the functions it is named. List every function the remote side calls, and do not call a library, such as dybatpho, that the remote host does not have. The script arrives on standard input, so the remote side cannot read from the user: pass what it needs as arguments.

**Recommended**

```sh
#######################################
# @description Print the disk usage of a directory
# @arg $1 string Directory
#######################################
function report::disk_usage {
  local dir="$1"
  du -sh -- "${dir}"
}

{
  declare -f report::disk_usage
  printf 'report::disk_usage %s\n' "${dir@Q}"
} | timeout 300 ssh -o ConnectTimeout=10 -o BatchMode=yes -- "${host}" bash -s
```

**Discouraged**

```sh
# "/srv/my app" reaches the remote shell as two words
timeout 300 ssh -o ConnectTimeout=10 -o BatchMode=yes -- "${host}" du -sh -- "${dir}"
# A copy of the function that the next change to it will miss
timeout 300 ssh -o ConnectTimeout=10 -o BatchMode=yes -- "${host}" "du -sh -- ${dir}"
```

### Deprecated Commands

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Use the current replacement: `signed-by` keyrings for apt, `grep -E` and `grep -F`, `command -v`, `ip`, `mktemp` `BSG059`
> - ❌ AVOID: Do not use `apt-key`, `egrep`, `fgrep`, `which`, `ifconfig` or `tempfile`

These commands are deprecated, missing from minimal images, or behave differently between systems. `apt-key` trusts a key for every repository; `egrep` and `fgrep` print a warning on current grep; `which` is an external program whose output and exit status vary, while `command -v` is a builtin; `ifconfig` and `tempfile` are absent from many distributions.

**Recommended**

```sh
# The vendor key, checked against the fingerprint the vendor publishes
local key keys
dybatpho::create_temp key ".asc"
dybatpho::curl_download "${key_url}" "${key}"
keys="$(gpg --show-keys --with-colons -- "${key}")"
[[ "${keys}" == *"fpr:::::::::${VENDOR_FINGERPRINT}:"* ]] \
  || dybatpho::die "Unexpected signing key from ${key_url}"
# Atomic writes, which honour DRY_RUN
gpg --dearmor < "${key}" | dybatpho::file_write_atomic /etc/apt/keyrings/vendor.gpg
printf 'deb [signed-by=/etc/apt/keyrings/vendor.gpg] %s stable main\n' "${repo}" \
  | dybatpho::file_write_atomic /etc/apt/sources.list.d/vendor.list

grep -E -- "${pattern}" "${file}"
command -v jq > /dev/null
ip -brief address
dybatpho::create_temp staging ".txt"
```

**Discouraged**

```sh
curl -sSL "${key_url}" | apt-key add -
egrep "${pattern}" "${file}"
which jq > /dev/null
ifconfig
staging="$(tempfile)"
```

## Script Stabilization

### Writing Rerunnable Scripts

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Make a script idempotent: running it twice with the same arguments leaves the same result
> - ✔️ SHOULD: Check whether the work is already done before doing it
> - ✔️ SHOULD: Prefer a command that is idempotent by nature, such as `chezmoi apply`, `pacman -S --needed` or `kubectl apply`, over one that fails on the second run
> - ❌ AVOID: Do not assume the previous run finished

Setup scripts are interrupted: a network drops, a package mirror fails, the user hits Ctrl-C. If the second run has to start from a clean machine, nobody can recover a half-installed one, and the script gets replaced by manual steps.

**Recommended**

```sh
# Installs only if it is not already there
dybatpho::is command "${name}" || dybatpho::dry_run dytoy -t "${name}"

# Fetches the submodule only when it is missing
if [[ ! -f "${SCRIPT_DIR}/lib/dybatpho/init.sh" ]]; then
  git -C "${REPO_DIR}" submodule update --init "${SCRIPT_DIR}/lib/dybatpho"
fi
```

**Discouraged**

```sh
# Fails on the second run because the tool is already installed
dytoy -t "$name"

# Fails on the second run because the directory already exists
mkdir "${config_dir}"
```

### Check State Before Changing

> [!TIP]
>
> - ✔️ SHOULD: Check that the inputs of a state-changing command are what you expect before running it
> - ✔️ SHOULD: Check that a required tool is present with `dybatpho::require` before using it. (dybatpho)
> - ✔️ SHOULD: Verify what you downloaded before installing it
> - ❌ AVOID: Do not pipe a value into a destructive command without checking that it is not empty

Under `set -u` an unset variable is caught, but an empty one is not. `rm -rf "${prefix}/${name}"` with an empty `name` deletes the prefix, and the command reports success.

**Recommended**

```sh
dybatpho::require "rbw"

if dybatpho::string_is_blank "${profile_dir}"; then
  dybatpho::die "Profile directory is empty, refusing to remove"
fi
dybatpho::dry_run rm -rf -- "${profile_dir}"

# Check the download before it is put in place
binary::verify_sha256 "${name}" "${temp_file}" "${url}" "${sha256_asset}"
dybatpho::dry_run mv -- "${temp_file}" "${output_path}"
```

**Discouraged**

```sh
# An empty profile_dir makes this delete the parent
rm -rf "${profile_dir}"

# Installs whatever came back, including an error page from a proxy
curl -fsSL "$url" -o "$output_path"
chmod +x "$output_path"
```

### Safely Creating Temporary Files

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Create temporary files with `dybatpho::create_temp <var> <suffix>` and directories with `dybatpho::create_temp_dir <var>`, which register their own cleanup. (dybatpho) `BSG046`
> - ✔️ SHOULD: Use `mktemp` when the library is not available, and remove the file with `trap 'rm -f "${temp_file}"' EXIT`
> - ✔️ SHOULD: Give the temporary file the suffix the content needs, so tools that dispatch on extension still work
> - ✔️ SHOULD: Derive a staging file next to its destination only from a path checked to be non-empty and not a directory, and create it exclusively: `set -C`, or `mktemp` in the destination's directory
> - ✔️ SHOULD: Create a file in a shared directory with `mktemp`, or by hand with a random suffix under noclobber (`set -C`), so a name that already exists is refused
> - ❌ AVOID: Do not build a temporary path yourself from `$$`, a timestamp or a fixed name `BSG045`
> - ❌ AVOID: Do not leave cleanup to the last line of the script, which an error never reaches
> - ❌ AVOID: Do not trap `INT` or `TERM` with a cleanup that does not exit: the script carries on after Ctrl-C `BSG106`
> - ❌ AVOID: Do not let an empty or failed path turn a staging file into one in the working directory
> - ❌ AVOID: Do not open a name in a shared directory with a plain `>`: it follows a symlink planted there, even when the name carries `$$` or `$BASHPID` `BSG082`

A predictable name in a world-writable directory is both a collision and a symlink attack. Registering the cleanup at creation time is the only way to have it run on the paths that matter: the error path and the interrupt.

A staging file built as `"$(dirname "${path}")/.staging.$$"` lands in the working directory when `path` is empty or came out of a substitution that failed, and a `>` onto a name someone planted follows their symlink. Check the destination first, then create the staging file so that an existing name is refused.

**Recommended**

```sh
dybatpho::create_temp sha256_file ".txt"
dybatpho::curl_download "${sha256_url}" "${sha256_file}"

dybatpho::create_temp_dir temp_dir
tar -xf "${archive}" -C "${temp_dir}"

# Without the library; `--suffix` is GNU only, so the name has no extension
temp_file="$(mktemp)"
# EXIT alone: Bash runs it on Ctrl-C and TERM too, then exits with 130 or 143
trap 'rm -f "${temp_file}"' EXIT

# A staging file for an atomic rewrite: checked destination, exclusive creation
[[ -n "${path}" && ! -d "${path}" ]] || dybatpho::die "Not a file path: ${path}"
staging="$(mktemp "$(dirname -- "${path}")/.staging.XXXXXXXX")"
```

**Discouraged**

```sh
# Predictable, collides between two runs, and is never cleaned up on error
temp_file="/tmp/download-$$.tar.gz"
curl -fsSL "$url" -o "$temp_file"
...
rm -f "$temp_file"

# An empty path stages into the working directory, and `>` follows a planted link
staging="$(dirname "${path}")/.staging.$$"
printf '%s\n' "${content}" > "${staging}"

# Ctrl-C runs the cleanup and the script carries on, then cleans up a second time
trap 'rm -f "${temp_file}"' EXIT INT TERM
```

A handler on `INT` or `TERM` replaces the default action, which is to exit. A cleanup that only removes files therefore turns Ctrl-C into "delete my temporary file and keep going": the script runs on without it, and exits with status 0. The `EXIT` trap already runs when Bash dies of `INT` or `TERM`; a handler for the signal itself is only needed when it ends with `exit`, as in [Signal Handlers](#signal-handlers).

`$$` and `$BASHPID` are visible to every user and easy to guess before the script runs, so a name built from them can be taken in advance — as a symlink to a file the script is allowed to write. `>` follows that link. `mktemp` creates the file exclusively, under a random name; where a name has to be chosen by hand, noclobber makes `>` refuse a name that exists, link or not.

**Recommended**

```sh
local report
report="$(mktemp "${TMPDIR:-/tmp}/report.XXXXXXXX")"

# By hand: a random suffix, and noclobber refuses a name that already exists
local name="${dir}/.part.${RANDOM}${RANDOM}"
if (set -C && : > "${name}") 2> /dev/null; then
  write_report > "${name}"
fi
```

**Discouraged**

```sh
# Guessable before the script runs, and `>` follows a link planted at the name
printf '%s\n' "${report}" > "${TMPDIR:-/tmp}/report.${BASHPID}"
```

### Locks

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Claim a lock in one atomic call that also records the holder: `ln -s "<pid>:<host>" "${lock}"`
> - ✔️ SHOULD: Reclaim a stale lock by renaming it aside and checking that the moved copy is the holder you judged dead
> - ✔️ SHOULD: Judge the holder you read, not whatever holds the name by the time the check runs
> - ❌ AVOID: Do not delete a stale lock and then take it: two processes can both do so and both hold it
> - ❌ AVOID: Do not create a lock first and write its owner afterwards

Every gap between two steps is a race. A lock created with `mkdir` and given its pid afterwards is ownerless for a moment, and another process reads it as stale; deleting a stale lock and then claiming it lets a second reclaimer delete the fresh claim. A symbolic link carries its owner in the same system call that creates it, and `rename()` succeeds for exactly one reclaimer.

**Recommended**

```sh
if ln -s "$$:$(hostname)" "${lock}" 2> /dev/null; then
  holding=true
fi

# Reclaim: move it into a private directory, then check that what moved is the holder judged dead
local aside moved
aside="$(mktemp -d "${lock}.stale.XXXXXXXX")"
if mv -- "${lock}" "${aside}/lock" 2> /dev/null; then
  moved="$(readlink -- "${aside}/lock")"
  # Someone else's live claim moved with it: put that claim back
  [[ "${moved}" == "${dead_holder}" ]] || ln -s "${moved}" "${lock}" 2> /dev/null || true
fi
rm -rf -- "${aside:?}"
```

**Discouraged**

```sh
# Ownerless between mkdir and the write: another process reclaims it
mkdir "${lock}" && echo "$$" > "${lock}/pid"

# Two reclaimers both delete, and both take the lock
if ! kill -0 "$(cat "${lock}/pid")"; then
  rm -rf -- "${lock}"
  mkdir "${lock}"
fi
```

### Atomic Writes

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Write new content to a staging file in the destination's directory, then `mv` it onto the destination
> - ✔️ SHOULD: Publish the files that describe a file — a checksum sidecar, an index — before the file itself
> - ✔️ SHOULD: Give the staging file the mode, and where possible the owner, of the file it replaces: `cp -p` the old file onto it before writing, or use `dybatpho::file_write_atomic`. (dybatpho)
> - ❌ AVOID: Do not rewrite a file in place with `>` or `>>` while other processes may read it
> - ❌ AVOID: Do not stage in another directory: `mv` across filesystems is a copy, not a rename
> - ❌ AVOID: Do not move a fresh `mktemp` file over a file other users or services read: it is created `0600`

A reader that opens a file being rewritten with `>` sees it empty or half written, and a crash leaves it that way. `rename()` within one filesystem replaces the name in one step, so a reader sees the old file or the new one. Order matters across files too: a backup moved into place before its checksum is written is, for a moment or for good, a backup that fails verification.

The rename replaces the inode too, and with it the mode and the owner. `mktemp` creates its file `0600` and owned by the script's user, so a config that was `0644` and read by a service is, after the rewrite, a file the service can no longer open.

**Recommended**

```sh
local staging
staging="$(mktemp "$(dirname -- "${path}")/.staging.XXXXXXXX")"
# Take over the mode, and the owner when allowed, of the file being replaced
[[ ! -e "${path}" ]] || cp -p -- "${path}" "${staging}"
render_config > "${staging}"
mv -f -- "${staging}" "${path}"

# The sidecar first, then the archive it describes
local digest sidecar
digest="$(sha256sum < "${partial}")"
sidecar="$(mktemp "$(dirname -- "${archive}")/.staging.XXXXXXXX")"
# Name the archive, not the staging file, so `sha256sum -c` finds it
printf '%s  %s\n' "${digest%% *}" "${archive##*/}" > "${sidecar}"
mv -- "${sidecar}" "${archive}.sha256"
mv -- "${partial}" "${archive}"
```

**Discouraged**

```sh
# Readers see an empty file until this finishes, and for good if it fails
render_config > "${path}"

# Visible with no sidecar until the next line runs
mv -- "${partial}" "${archive}"
sha256sum "${archive}" > "${archive}.sha256"
```

### Destructive Commands

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Expand a variable that builds the path of a destructive command with `${var:?}`, or check first that it is non-empty and inside an allowed root
> - ✔️ SHOULD: Resolve the root and the target with `cd -P` before comparing them, and stop when the root is empty
> - ✔️ SHOULD: Prefer a guarded helper that validates the path and confirms before it acts. (dybatpho)
> - ❌ AVOID: Do not run `rm -r`, `find ... -delete`, `chmod -R`, `chown -R` or `mv` onto an existing target with a path built from variables that were never checked `BSG089`
> - ❌ AVOID: Do not check that a path is inside a root by comparing the strings as typed

An unset or empty variable turns `rm -rf "${BUILD_DIR}/cache"` into `rm -rf /cache`, and `rm -rf "${prefix}"*` into the working directory. `${var:?}` stops the script when the variable is unset or empty, before the command runs; a root check stops a value that is set but wrong.

A root check on the strings as typed is weaker than it looks. With an empty root, `"${target}" == "${WORK_ROOT}"/*` becomes `== /*`, which every absolute path matches; and `${WORK_ROOT}/../etc` or a symbolic link inside the root passes the comparison while naming a directory outside it.

**Recommended**

```sh
rm -rf -- "${BUILD_DIR:?}/cache"

# Resolve both sides first: `..` and symbolic links are gone from what is compared
local root resolved
root="$(CDPATH='' cd -P -- "${WORK_ROOT:?}" && pwd)" || return 1
resolved="$(CDPATH='' cd -P -- "${target:?}" && pwd)" || return 1
[[ "${resolved}" == "${root}"/* ]] \
  || dybatpho::die "Refusing to delete outside ${root}: ${target}"
dybatpho::safe_rm "${resolved}"
```

**Discouraged**

```sh
# BUILD_DIR unset: this removes /cache
rm -rf "${BUILD_DIR}/cache"

# target empty: chown walks the working directory
chown -R "${owner}" "${target}"

# WORK_ROOT empty matches any absolute path, and work/../etc matches too
[[ "${target}" == "${WORK_ROOT}"/* ]] && rm -rf -- "${target}"
```

## Testing

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Give every library a matching test file, `scripts/test/<area>.bats` next to `scripts/lib/<area>.sh`, written with [bats](https://github.com/bats-core/bats-core). (custom) `BSG060`
> - ✔️ SHOULD: Add the test for a new function in the same commit as the function. (custom)
> - ✔️ SHOULD: Put the shared setup of the suite in one helper, loaded by every file
> - ✔️ SHOULD: Expose the whole suite behind one entrypoint, so that running the tests takes no arguments to remember
> - ✔️ SHOULD: Run the linter and the formatter, `shellcheck` and `shfmt`, from the same place as the tests
> - ❌ AVOID: Do not test a function by running the script that calls it

A library function is only testable if it has no side effects of its own: it takes its arguments through `dybatpho::expect_args`, writes its result to `STDOUT` and its diagnostics to `STDERR`, and performs state changes through `dybatpho::dry_run`. Writing the test at the same time as the function is what keeps that shape honest.

**Recommended**

```sh
# scripts/test/chezmoi_attrs.bats
function setup {
  load test_helper
  setup_dotfiles_test_env
  . "${DOTFILES_DIR}/scripts/lib/chezmoi_attrs.sh"
}

@test "chezmoi_attrs::source_path maps a home path to the home source tree" {
  run run_source_path "${HOME}/.config/foo/bar.txt" ""
  assert_success
  assert_output "home/private_dot_config/foo/bar.txt"
}
```

```sh
bash ./scripts/test.sh --all
```

**Discouraged**

```sh
# Tests the entrypoint, the option parsing and the filesystem all at once,
# and cannot say which of them broke
run bash ./scripts/setup.sh --all
assert_success
```

### Strict Output Assertions

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Pass `-` when an assertion reads its expected value from a here-document: `assert_output - << EOF` `BSG061`
> - ❌ AVOID: Do not write `assert_output << EOF`, `refute_output << EOF`, `assert_stderr << EOF` or `refute_stderr << EOF` without `-`

bats-assert reads standard input only when the expected value is `-`. Without it the here-document is ignored, and `assert_output` with no argument only checks that there was some output, so the test passes whatever the output says. A suite that ran green for years can hold dozens of these, each one hiding a stale expectation or a real bug.

**Recommended**

```sh
@test "table::print aligns the columns" {
  run table::print "name,count" "apples,3"
  assert_output - << 'EOF'
name    count
apples  3
EOF
}
```

**Discouraged**

```sh
@test "table::print aligns the columns" {
  run table::print "name,count" "apples,3"
  # Passes for any non-empty output: the here-document is never read
  assert_output << 'EOF'
name    count
apples  3
EOF
}
```

### Test Isolation

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Clear the ambient state a suite could act on, in the shared test helper: `GIT_DIR`, `GIT_INDEX_FILE`, `GIT_WORK_TREE`, `FORCE_COLOR`, `NO_COLOR` `BSG062`
> - ✔️ SHOULD: Create every fixture under the test's own temporary directory (`BATS_TEST_TMPDIR`)
> - ✔️ SHOULD: Start a child shell from a script file rather than with `bash -c` when coverage is measured `BSG062`
> - ❌ AVOID: Do not let a test act on the repository, the home directory or any path outside its temporary directory

A suite inherits the environment of whatever runs it. A git hook exports `GIT_DIR` and `GIT_INDEX_FILE`, so a test that runs `git init` and `git commit` in a temporary directory writes into the real repository instead — one such run turned a repository bare and replaced its remote. A coverage tool that traces through `BASH_SOURCE` also sees nothing in a `bash -c` child, whose `BASH_SOURCE` is empty.

**Recommended**

```sh
# test/test_helper.bash
unset GIT_DIR GIT_INDEX_FILE GIT_WORK_TREE GIT_COMMON_DIR FORCE_COLOR

@test "release reads the tags of a repository" {
  local repo="${BATS_TEST_TMPDIR}/repo" script="${BATS_TEST_TMPDIR}/run.sh"
  git init -q "${repo}"
  printf '. %q\nrelease::latest %q\n' "${LIB}" "${repo}" > "${script}"
  run bash "${script}"
}
```

**Discouraged**

```sh
@test "release reads the tags of a repository" {
  # Inside a git hook, GIT_DIR points at the real repository
  git init -q "${BATS_TEST_TMPDIR}/repo"
  git -C "${BATS_TEST_TMPDIR}/repo" tag v1.0.0
  run bash -c ". ${LIB}; release::latest ${BATS_TEST_TMPDIR}/repo"
}
```

## References

Most rules here come with their reason; these pages go deeper into the behaviour behind them.

- [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html) and [icy/bash-coding-style](https://github.com/icy/bash-coding-style), the guides this one is based on
- [BashGuide](https://mywiki.wooledge.org/BashGuide) of the Wooledge wiki, a tutorial that teaches the safe forms first
- [BashPitfalls](https://mywiki.wooledge.org/BashPitfalls), the common mistakes, each with its fix
- [BashFAQ](https://mywiki.wooledge.org/BashFAQ), in particular [Why not `set -e`](https://mywiki.wooledge.org/BashFAQ/105), [the location of a script](https://mywiki.wooledge.org/BashFAQ/028) and [Why not parse `ls`](https://mywiki.wooledge.org/ParsingLs)
- [ShellCheck wiki](https://www.shellcheck.net/wiki/), one page per `SCxxxx` code
- [Bash Reference Manual](https://www.gnu.org/software/bash/manual/bash.html)
