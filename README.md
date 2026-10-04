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
  - [Wildcard Expansion of Filenames](#wildcard-expansion-of-filenames)
  - [Eval is Evil](#eval-is-evil)
  - [Secrets and Credentials](#secrets-and-credentials)
  - [Building Structured Output](#building-structured-output)
  - [Arrays](#arrays)
  - [Pipes to While](#pipes-to-while)
  - [Process Substitution](#process-substitution)
  - [For Loops](#for-loops)
  - [Local Variables](#local-variables)
  - [Arithmetic](#arithmetic)
  - [Portability](#portability)
- [Calling Commands](#calling-commands)
  - [Checking Return Values](#checking-return-values)
  - [Error Handling](#error-handling)
  - [Builtin Commands vs External Commands](#builtin-commands-vs-external-commands)
  - [Signal Handlers](#signal-handlers)
- [Script Stabilization](#script-stabilization)
  - [Writing Rerunnable Scripts](#writing-rerunnable-scripts)
  - [Check State Before Changing](#check-state-before-changing)
  - [Safely Creating Temporary Files](#safely-creating-temporary-files)
- [Testing](#testing)
  - [Strict Output Assertions](#strict-output-assertions)

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
DYBATPHO_DIR=<path to dybatpho>
. "$DYBATPHO_DIR/init.sh"
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

Every rule carries a code: `BSG###` for a rule of this guide, `SC####` for a ShellCheck finding, and `FMT001` for a formatting difference. Any of them can be turned off for a run with `--exclude-rules`, and a ShellCheck finding can be silenced in place with a `# shellcheck disable=SCXXXX` comment that says why.

The [`.shellcheckrc`](.shellcheckrc) and [`.editorconfig`](.editorconfig) of this repository are the configuration this guide asks for, and are meant to be copied into a project. `dyshellint` reads the `.shellcheckrc` of the project it checks, and also ships a [nvim-lint](https://github.com/mfussenegger/nvim-lint) definition for Neovim.

## Background

### Which Shell to Use

> [!NOTE]
> Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Use Bash for all scripts
> - ✔️ SHOULD: Write `#!/usr/bin/env bash` at the top of the script. (custom)
> - ✔️ SHOULD: Use `set -euo pipefail` for shell option settings. (custom)
> - ✔️ SHOULD: After source [dybatpho](https://github.com/dynamotn/dybatpho), can ignore to `set -euo pipefail`. (dybatpho)
> - ⚠️ CONSIDER: If using other shells, explain the reason in comments. (custom)

Use Bash. Restricting all executable shell scripts to `bash` ensures a consistent shell installed on all machines.

Executable files should start with `#!/usr/bin/env bash` and minimal flags. Using `#!/usr/bin/env bash` provides several notable advantages: works across environments (like Fedora or Termux), although slight performance hit from invoking env to search PATH.

Using `set` for shell option settings ensures that even if the script is called with `bash script_name`, its functionality is not impaired. `set -euo pipefail` automatically detects errors early and terminates the script if an error occurs. `set -e` terminates the script if an error occurs. `set -u` triggers an error when referencing undefined variables. `set -o pipefail` terminates the script if an error occurs in the middle of a pipeline.

**Recommended**

```sh
#!/usr/bin/env bash
set -euo pipefail
# If not used dybatpho

#!/usr/bin/env bash
DYBATPHO_DIR=<path to dybatpho>
. "$DYBATPHO_DIR/init.sh"
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

### When to Use Shell

> [!NOTE]
Custom rule

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
Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Use the `.sh` extension for scripts that are library scripts. `chmod -x` for them
> - ✔️ SHOULD: Do not use extensions for scripts that are in PATH. `chmod +x` for them
> - ✔️ SHOULD: Use the `.sh` extension for scripts that aren't in PATH and are able to called from CLI.  `chmod +x` for them (custom)

Executable files should either have a `.sh` extension (strongly recommended) or no extension. Scripts sourced from outside must have a `.sh` extension and should not be made executable.

### SUID/SGID

> [!NOTE]
Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Use `sudo` if you need to elevate privileges
> - ❌ AVOID: SUID and SGID are prohibited
> - ❌ AVOID: `sudo` is also prohibited in CI scripts. (custom)

SUID and SGID are prohibited in shell scripts. Shell has many security issues, making it nearly impossible to ensure sufficient safety to allow SUID/SGID. Although bash makes SUID execution difficult, it is possible on some platforms, so it is explicitly prohibited. If privilege escalation is needed, use `sudo`.

As long as scripts are executed in CI, `sudo`, SUID, and SGID are unnecessary and therefore prohibited.

**Recommended**

```sh
# Use sudo when calling (Except in CI)
sudo ./foo.sh
```

**Discouraged**

```sh
# Switching to su or root user inside the script
```

## Environment

### Script Invocation

> [!NOTE]
Custom rule

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
Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Take every argument as a named option in `--option value` form
> - ✔️ SHOULD: Declare the interface of a script in a `_spec_<entrypoint>` function using `dybatpho::opts::*`, and run it with `dybatpho::generate_from_spec "_spec_<entrypoint>" "$@"`. (dybatpho)
> - ✔️ SHOULD: Name the variable that receives an option in `UPPERCASE`, and give every optional one a default with `init:=`. (custom)
> - ✔️ SHOULD: Collect leftover positional arguments into one array, declared as the argument sink of `dybatpho::opts::setup`
> - ✔️ SHOULD: Declare the arguments of a function with `dybatpho::expect_args name... -- "$@"` instead of reading `$1`, `$2` by hand. (dybatpho)
> - ✔️ SHOULD: Always offer `--help`, through `dybatpho::opts::disp` and `dybatpho::generate_help`. (dybatpho)
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
  dybatpho::is command "$name" || dybatpho::dry_run dytoy -t "$name"
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
Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Let the caller pick the verbosity with a `--log-level` option bound to `LOG_LEVEL`, validated by `dybatpho::validate_log_level`. (dybatpho)
> - ✔️ SHOULD: Turn command tracing on with `dybatpho::start_trace` rather than writing `set -x` inline, and close it with `dybatpho::end_trace`. (dybatpho)
> - ✔️ SHOULD: Run every command that changes state through `dybatpho::dry_run`, so a dry run reports the command instead of running it. (dybatpho)
> - ✔️ SHOULD: Prefer the dry-run mode a tool provides itself, such as `chezmoi diff` or `kubectl --dry-run=server`, over echoing the command
> - ⚠️ CONSIDER: Make dry run the default for a script whose real run is destructive. (custom)

A script that can be asked what it *would* do is a script people are willing to run on a machine they care about. Wrapping the state-changing command, rather than branching around it, keeps the dry-run path and the real path identical up to the last step, so the dry run exercises the same conditions and the same arguments.

**Recommended**

```sh
# The wrapper decides whether to run or to report
dybatpho::dry_run mv "$temp_file" "$output_path"
dybatpho::dry_run chmod +x "$output_path"

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

### STDOUT and STDERR

> [!NOTE]
Custom rule

> [!TIP]
>
> - ✔️ SHOULD: All error and fatal messages should go to `STDERR`
> - ✔️ SHOULD: Use `LOG_LEVEL` variable to control logging level with 6 levels: trace, debug, info, warn, error, fatal. (custom)
> - ✔️ SHOULD: Suppress all unnecessary messages to `/dev/null`. (custom)
> - ✔️ SHOULD: Use logging library from [dybatpho](https://github.com/dynamotn/dybatpho) to output messages for better logging. (dybatpho)

**Recommended**

```sh
# error messages to stderr
echo "Error: Unable to do_something" >&2

# log level default is info
LOG_LEVEL=info

# suppress unnecessary messages
curl -fsSL "$url" 2> /dev/null

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
grep -rn "abc" README.md || echo "Error: README.md not has `abc` word"
```

### Common Function Scripts

> [!NOTE]
New rule

> [!TIP]
>
> - ✔️ SHOULD: Use `.` to invoke common functions
> - ✔️ SHOULD: Put common functions as libraries in `lib` sub-folder

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

## Naming Conventions

### Function Names

> [!NOTE]
Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Use the `function` keyword to declare a function
> - ✔️ SHOULD: Write function names in lowercase, with underscores between words
> - ✔️ SHOULD: Separate the namespace from the function name with `::`, and name the namespace after the library file: `scripts/lib/package_manager.sh` defines `package_manager::install`
> - ✔️ SHOULD: Prefix a function that is private to its library with `__<namespace>_`, and a function that is private to an entrypoint script with `_`. (custom)
> - ❌ AVOID: Do not write `()` after the function name when using the `function` keyword. (custom)
> - ❌ AVOID: Do not use PascalCase or camelCase

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
Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Write local and ordinary variable names in lowercase, with underscores between words
> - ✔️ SHOULD: Declare every variable used inside a function with `local`, and declare array locals with `local -a name=()`
> - ✔️ SHOULD: Use `UPPERCASE` for variables the caller sets: script options, exported environment variables and constants
> - ✔️ SHOULD: Make constants read-only with `readonly` or `declare -r`, and declare them at the top of the file
> - ✔️ SHOULD: Name a loop variable after the collection it walks: `for tool in "${tools[@]}"`
> - ❌ AVOID: Do not declare and assign from a command substitution on the same line

`local name="$(some_command)"` throws away the exit status of `some_command`, because the status of the line is the status of `local`, which always succeeds. Under `set -e` that turns a failing command into a silent empty variable. Splitting the two lines keeps the failure visible.

**Recommended**

```sh
# Constants first, read-only
readonly SCRIPT_DIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"

function dytoy::install {
  local name
  dybatpho::expect_args name -- "$@"

  # Declare, then assign, so a failure is not swallowed
  local version
  version="$(dytoy::get_yaml "$name" "version")"

  local -a dependencies=()
  readarray -t dependencies < <(dytoy::get_yaml "$name" "dependencies")
  local dependency
  for dependency in "${dependencies[@]}"; do
    dytoy::install "$dependency"
  done
}
```

**Discouraged**

```sh
# The exit status of the command substitution is lost
local version="$(dytoy::get_yaml "$name" "version")"

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
Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Prefix every other local of a function that binds `local -n` to a name its caller chose: `__<namespace>_<function>_<name>`
> - ✔️ SHOULD: Prefix the locals of a function that runs caller code — `"$@"`, `eval`, a callback, handler or producer name — when they are live across that call
> - ❌ AVOID: Do not give such a function plain locals like `status`, `name`, `path`, `count` or `result`

Bash scopes variables dynamically. `local -n ref="$1"` resolves the name the caller passed when it is used, so if the function has a local of that name, the nameref binds to the local and the caller's variable is never filled. Code a function runs on its caller's behalf sees the function's locals in the same way, and can read or overwrite them: a command that kept its own `count` once changed how often a retry helper retried.

**Recommended**

```sh
function text::split_into {
  local -n __text_split_ref="$1"
  local __text_split_input="$2"
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
Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Include a comment at the beginning of the file that concisely explains the purpose or content of the file. However, do not include comments before the shebang line
> - ✔️ SHOULD: Use [sh-docs](https://github.com/dynamotn/sh-docs) ([GitLab](https://gitlab.com/dynamo-tools/sh-docs)) format includes: `@file`, `@brief`, `@description` to explain the file. (custom)

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
Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Use [sh-docs](https://github.com/dynamotn/sh-docs) ([GitLab](https://gitlab.com/dynamo-tools/sh-docs)) format to explain the function. (custom)

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
function get_dir() {
  local config_dir=${1:-"$HOME/.config/abc"}
  if [ -e "$config_dir" ]; then
    echo "${config_dir}"
  else
    echo "Not have configuration directory" >&2 && return 1
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
Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Consider using TODO comments
> - ❌ AVOID: Do not include the name of the person who wrote the TODO comment. (custom)

Use TODO comments for temporary, short-term solutions, or code that is good enough but not perfect. TODO comments should include the uppercase string `TODO`. There is no need to include the individual's name, as it can be identified using `git blame`. The purpose of TODO comments is to provide a searchable and consistent `TODO` marker that can be looked up for more details as needed. Since the person referenced in the TODO is not necessarily committed to fixing the issue, it is helpful to include the expected resolution.

**Recommend**

```sh
# TODO: This code needs to be fixed due to insufficient error handling. Add error checks and exit with 1.
```

## Formatting

### Tabs and Spaces

> [!NOTE]
Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Indent with two spaces. Do not use tabs
> - ✔️ SHOULD: Include blank lines between blocks for readability
> - ✔️ SHOULD: Do not include trailing spaces. (custom)

Indentation should be two spaces. Under no circumstances should tabs be used.

Many editors cannot switch between actual indentation and displayed spaces/tabs according to user preference. Another person's editor may not have the same settings as yours. Using spaces ensures that code looks the same in any editor.

### Line Length and Long Strings

> [!NOTE]
Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Maximum line length is 120 characters. (custom)
> - ✔️ SHOULD: Consider using here documents or embedded newlines for excessively long strings. (custom)
> - ⚠️ CONSIDER: Look for ways to shorten string literals

There is no maximum line length, nor a rule to break lines at N characters. However, if you need to write excessively long strings, consider using here documents or embedded newlines if possible. While the presence of string literals that cannot be appropriately divided is allowed, it is strongly recommended to look for ways to shorten them.

**Recommended**

```sh
# Use of here document
cat <<END
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

Shell loops are a bit different, but following the principle of braces when declaring functions, place `; then` and `; do` on the same line as `if/for/while`. `else` should be placed on its own line, and closing constructs should also be on their own lines. They should be vertically aligned with their opening constructs.

**Recommended**

```sh
if [[ -n "${name}" ]]; then
  dybatpho::info "Installing ${name}"
else
  dybatpho::die "No tool name given"
fi

for tool in "${tools[@]}"; do
  echo "${tool}"
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
  echo "${tool}"
done
```

### Case statement

> [!TIP]
>
> - ✔️ SHOULD: Indent cases by two spaces
> - ✔️ SHOULD: For single-line cases, place one space after the closing parenthesis of the pattern and before `;;`
> - ✔️ SHOULD: For long or multiple command cases, split the pattern, action, and `;;` into multiple lines
> - ⚠️ CONSIDER: For short command cases, consider placing the pattern, action, and `;;` on one line if readability is maintained

Indent the conditions one level from `case` and `esac`. For multi-line actions, indent an additional level. There should be no opening parentheses before the pattern expression. Avoid using `;&` or `;;&`.

**Recommended**

```sh
case "${expression}" in
  "--a")
    _VARIABLE_="..."
    ;;
  "--absolute")
    _ACTIONS="relative"
    ;;
  *) shift ;;
esac
```

For simple commands, place the pattern and `;;` on the same line if readability is maintained. If the action does not fit on a single line, place the pattern on its own line, followed by the action on the next line, and then `;;` on its own line. When placing the pattern on the same line as the action, include one space after the closing parenthesis of the pattern and before `;;`.

### Variable Expansion

> [!NOTE]
Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Use consistent variable expansion
> - ✔️ SHOULD: Enclose variable expansions in double quotes. Single quotes do not expand variables
> - ✔️ SHOULD: Read an environment variable that may be unset with a default under `set -u`: `${NO_COLOR-}`, `${TMPDIR:-/tmp}`
> - ❌ AVOID: Avoid bracing shell special variables/positional parameters unless explicitly necessary or to avoid serious confusion
> - ❌ AVOID: Do not read an optional environment variable bare under `set -u`

Variables should be quoted. Use `${var}` instead of `$var`, except variable is entire string in quotes.
This is a strongly recommended guideline but not an absolute regulation. However, even though it is not mandatory, do not disregard it.

All other variables should preferably be enclosed in braces.

**Recommended**

```sh
# Preferred style for 'special' variables:
echo "Positional: $1" "$5" "$3"
echo "Specials: !=$!, -=$-, _=$_. ?=$?, #=$# *=$* @=$@ \$=$$ …"

# Braces necessary:
echo "many parameters: ${10}"

# Braces avoiding confusion:
# Output is "a0b0c0"
set -- a b c
echo "${1}0${2}0${3}0"

# Preferred style for other variables:
echo "PATH=${PATH}, PWD=${PWD}, mine=${some_var}"
echo "$PATH"
while read -r f; do
  echo "file=${f}"
done < <(find /tmp)
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
Custom rule

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
echo "${flag}"

# Use arrays with quoted expansion for lists.
declare -a FLAGS
FLAGS=( --foo --bar='baz' )
readonly FLAGS
mybinary "${FLAGS[@]}"

# It's ok to not quote internal integer variables.
if (( $# > 3 )); then
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

(set -- 1 "2 two" "3 three tres"; echo $#; set -- "$*"; echo "$#, $@")
(set -- 1 "2 two" "3 three tres"; echo $#; set -- "$@"; echo "$#, $@")
```

### Function Declaration

> [!TIP]
>
> - ✔️ SHOULD: Put the shebang and the file header comment first, then constants, then function declarations, then the single line that starts the script
> - ✔️ SHOULD: Keep the call to the entrypoint as the last line of the file
> - ❌ AVOID: Do not place executable code between function declarations

A file that is a list of declarations followed by one call can be read in any order, and sourcing it for a test has no side effects. Code scattered between functions runs at load time, which makes the script impossible to source and hard to reason about when it fails halfway.

**Recommended**

```sh
#!/usr/bin/env bash
# @file test.sh
# @brief Run tests for the dotfiles setup
SCRIPT_DIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
# shellcheck source=lib/dybatpho/init.sh
. "$SCRIPT_DIR/lib/dybatpho/init.sh" --modules cli
dybatpho::register_common_handlers

function _spec_main {
  ...
}

function _main {
  ...
}

dybatpho::generate_from_spec _spec_main "$@"
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
> - ✔️ SHOULD: Put `enable=require-variable-braces` into `.shellcheckrc` file. (custom)
> - ⚠️ CONSIDER: Consider resolving all ShellCheck warnings with a severity level of info or higher. (custom)
> - ⚠️ CONSIDER: If you cannot resolve ShellCheck warnings with a severity level of info, consider adding `# shellcheck disable=SCXXXX` comments to ignore them. (custom)

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

# Ignoring SC1091 warning for unresolved source path is acceptable.
# shellcheck disable=SC1091
. "$(dirname "${BASH_SOURCE[0]}")/lib/functions.sh"
```

### Command Substitution

> [!TIP]
>
> - ✔️ SHOULD: Use `$(command)` for command substitution
> - ❌ AVOID: Do not use backticks

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

### Validation in Command Substitution

> [!NOTE]
Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Return a value that has to be validated through a nameref, with an `*_into` helper, or validate the input before the substitution
> - ✔️ SHOULD: Check the status of a substitution whose function can stop the script: `value="$(fn)" || return $?`
> - ✔️ SHOULD: Call a function that changes state — a global, a cache or memo, a counter, a secret registration — in the caller's shell, and return its value through a nameref
> - ❌ AVOID: Do not call a function that can stop the script, through `dybatpho::die` or `exit`, inside `$(...)` and carry on unconditionally
> - ❌ AVOID: Do not call such a function inside `$(...)`: every change it makes is lost with the subshell

`$(...)` runs in a subshell, so `dybatpho::die` or `exit` inside it ends only that subshell. Under `set -e` the failed assignment still stops the script, but wherever errexit is suspended — inside `if`, after `||`, `&&` or `!`, or under bats' `run` — the caller carries on with an empty value, right after a fatal error that claimed the script was stopping. A helper that validates in the caller's shell stops the script where it should.

**Recommended**

```sh
# Validates in the caller's shell, then sets the variable the caller named
function __net_port_into {
  local -n __net_port_ref="$1"
  [[ "$2" =~ ^[0-9]+$ ]] || dybatpho::die "Not a port: $2"
  __net_port_ref="$2"
}

function net::connect {
  local port
  __net_port_into port "$1"
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
  local -n __date_flavor_ref="$1"
  if [[ -z "${__DATE_FLAVOR-}" ]]; then
    if date --version > /dev/null 2>&1; then __DATE_FLAVOR=gnu; else __DATE_FLAVOR=bsd; fi
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
if [[ ! -f "$SCRIPT_DIR/lib/dybatpho/init.sh" ]]; then
  git -C "$REPO_DIR" submodule update --init "$SCRIPT_DIR/lib/dybatpho"
fi

# A named check reads better than the flag it wraps
dybatpho::is command "$name" || dybatpho::dry_run dytoy -t "$name"
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

Inside `[[ ... ]]` the operators `<` and `>` compare lexicographically, so `[[ 10 < 9 ]]` is true. Numbers belong in `(( ... ))`.

**Recommended**

```sh
if [[ "$identity" == "personal" ]]; then
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

### Wildcard Expansion of Filenames

> [!TIP]
>
> - ✔️ SHOULD: Prefix a glob with `./` when it is expanded into command arguments
> - ⚠️ CONSIDER: Use `compgen -G` when you need the matches as data and an empty result is acceptable. (custom)
> - ❌ AVOID: Do not pass a bare `*` to a command

A file named `-rf` in the directory turns `rm *` into `rm -rf`. `./*` expands to paths that begin with `./`, which no command can mistake for an option.

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

### Eval is Evil

> [!TIP]
>
> - ✔️ SHOULD: Quote every value spliced into a string for `eval`, or for a one-string `dybatpho::dry_run`, with `printf %q`; better, pass an argument list
> - ❌ AVOID: Do not use `eval`
> - ❌ AVOID: Do not build a command string for `eval` or `dybatpho::dry_run "<string>"` from data that is not escaped

`eval` makes it impossible to tell, by reading the script, what will run or which variables will be set. When a value has to be executed, use an array for the command and its arguments, or an indirect reference for the variable.

**Recommended**

```sh
local -a options=() packages=()
options+=(--noconfirm)
packages+=("$name")
dybatpho::dry_run pacman -S "${options[@]}" "${packages[@]}"
```

**Discouraged**

```sh
# The reader cannot tell what this expands to, and a space in $name breaks it
eval "pacman -S ${options} ${packages}"
```

When a string has to be evaluated — generated parser code, a configured command template, a dry-run line — every piece of data spliced into it is code. A path with a space splits into two arguments, and a value holding `$(...)` or `;` runs. `printf %q` escapes a value so the shell reads it back as exactly one word, and an argument list never goes through the parser at all.

**Recommended**

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
Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Pass tokens, passwords and secret URLs to a command through a config file, standard input or the environment: `curl --config`, `-H @file`
> - ✔️ SHOULD: Redact a URL before it reaches a message or a log: keep the scheme and the host, drop the user info, the path and the query
> - ✔️ SHOULD: Register a secret for masking as soon as it is read, in the caller's shell. (dybatpho)
> - ❌ AVOID: Do not put a secret in the arguments of a command, where every user of the host reads it from `ps` and `/proc`
> - ❌ AVOID: Do not log a request URL or body whole when it may carry a token

The arguments of a running process are public on the host, and a log outlives the run that wrote it. A webhook URL is often the credential itself, so printing the URL of a failed request leaks it as surely as printing a token. Secrets therefore travel out of band — a private config file curl reads, standard input, an inherited variable — and a message names a request by its host only.

**Recommended**

```sh
local config
dybatpho::create_temp config ".curl"
printf 'header = "Authorization: Bearer %s"\n' "${TOKEN}" > "${config}"
curl --config "${config}" --fail-with-body "${url}"

# Only the scheme and the host reach the log: https://hooks.slack.com/[redacted]
dybatpho::error "Request to ${redacted_url} failed"
```

**Discouraged**

```sh
# The token is in `ps` for as long as the request runs
curl -H "Authorization: Bearer ${TOKEN}" "${url}"

# The webhook URL is the secret, and now it is in the log
dybatpho::error "Request to ${WEBHOOK_URL} failed"
```

### Building Structured Output

> [!NOTE]
Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Build JSON and YAML with `jq` or `yq` and `--arg`, or through one escaping helper that every module uses
> - ✔️ SHOULD: Write CSV fields through one helper that doubles quotes and quotes a field holding the delimiter, a quote or a line break
> - ❌ AVOID: Do not splice a value into structured text with `printf '{"key":"%s"}'`

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

### Arrays

> [!TIP]
>
> - ✔️ SHOULD: Use an array whenever you hold more than one value, especially command line flags
> - ✔️ SHOULD: Declare arrays explicitly: `local -a names=()` inside a function, `declare -a NAMES=()` at file scope
> - ✔️ SHOULD: Append with `names+=("${value}")`
> - ✔️ SHOULD: Expand with `"${names[@]}"`, and take the length with `"${#names[@]}"`
> - ✔️ SHOULD: Expand an array that may be empty as `${names[@]+"${names[@]}"}` when the script supports Bash 4.3 under `set -u`
> - ✔️ SHOULD: Iterate the indexes an array really has with `"${!names[@]}"`
> - ❌ AVOID: Do not keep several values in one string separated by spaces
> - ❌ AVOID: Do not walk `0` to `${#names[@]} - 1` over an array the function did not build itself

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

### Pipes to While

> [!TIP]
>
> - ✔️ SHOULD: Feed a `while read` loop with process substitution: `while read -r line; do ...; done < <(command)`
> - ✔️ SHOULD: Use `readarray -t` or `mapfile -t` when the whole output is wanted as an array
> - ✔️ SHOULD: Use `read -r`, and `mapfile -d ''` with `-print0` when the values may contain newlines
> - ❌ AVOID: Do not pipe into a `while` loop

The right-hand side of a pipe runs in a subshell, so every variable the loop sets is discarded when the loop ends. Process substitution keeps the loop in the current shell.

**Recommended**

```sh
local -a files=()
mapfile -d '' -t files < <(command find "${root}" -type f -print0 | sort -z)

local -a tools=()
readarray -t tools < <(dytoy::get_yaml "$name" "tools")

local count=0
while read -r line; do
  count=$((count + 1))
done < <(command grep -c "" "${file}")
echo "${count}"
```

**Discouraged**

```sh
# count is always 0 here: the loop ran in a subshell
local count=0
command find "${root}" -type f | while read -r line; do
  count=$((count + 1))
done
echo "${count}"
```

### Process Substitution

> [!NOTE]
Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Capture the output of a producer that can fail into a variable first, check its status, then read the variable: `listing="$(cmd)" || return $?`
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
> - ❌ AVOID: Do not write `for item in $(command)` when the output may contain spaces

`for item in $(command)` splits on every space, tab and newline, and then globs the result. It is correct only for output you control completely.

**Recommended**

```sh
local -a dependencies=()
readarray -t dependencies < <(dytoy::get_yaml "$name" "dependencies")
local dependency
for dependency in "${dependencies[@]}"; do
  dybatpho::dry_run dytoy "${method}" -i -t "$dependency"
done
```

**Discouraged**

```sh
# A dependency name containing a space becomes two iterations
for dependency in $(dytoy::get_yaml "$name" "dependencies"); do
  dytoy "${method}" -i -t "$dependency"
done
```

### Local Variables

> [!NOTE]
Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Declare `local` every variable a function assigns: loop variables, the targets of `read`, `mapfile`, `readarray` and `printf -v`, and plain assignments
> - ✔️ SHOULD: Document a deliberate global with `@set` in the function comment, and name it in `UPPERCASE`
> - ❌ AVOID: Do not let a loop variable or a `read` target leak out of a function

A variable a function assigns without declaring it is global. It outlives the function, and it overwrites a variable of the same name in every caller: a helper that loops with `for i` silently moves the caller's own `i` loop. [Variable Names](#variable-names) asks for `local`; these are the assignments that are easiest to forget.

**Recommended**

```sh
function fs::count_lines {
  local file total=0 line
  for file in "$@"; do
    while IFS= read -r line; do
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
    while IFS= read -r line; do
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
> - ❌ AVOID: Do not use `let`, `expr` or the deprecated `$[ ... ]`
> - ⚠️ CONSIDER: Be careful with a bare `(( ... ))` under `set -e`: an expression whose value is `0` has exit status `1` and stops the script

`(( ... ))` is a builtin, so it is faster than `expr` and does not need a subprocess, and it treats its operands as numbers rather than strings.

**Recommended**

```sh
if ((${#MAIN_ARGS[@]} > 0)); then
  exec "${BATS_CMD}" "${MAIN_ARGS[@]}"
fi

local -i retries=0
retries=$((retries + 1))

# Safe under set -e: the increment never decides the exit status of the line
((count++)) || true
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
### Portability

> [!NOTE]
Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Probe for a feature before using a GNU-only flag, and keep a portable branch: `date -d`, `sed -i`, `readlink -f`, `stat -c`, `find -printf`, `grep -P`, `xargs -r`, `mktemp --suffix`
> - ✔️ SHOULD: Detect a feature by trying the flag, not by the name of the tool or its `--version`
> - ❌ AVOID: Do not assume GNU coreutils when the script runs on macOS, BSD or BusyBox
> - ⚠️ CONSIDER: Prefer a Bash builtin or a POSIX form when one does the job: `printf '%(%s)T'`, parameter expansion

macOS ships BSD tools and Alpine ships BusyBox, and the same flag means something else, or nothing, on each: `sed -i` wants a backup suffix on BSD, `stat -c` is `stat -f` there, and `date -d` does not exist. `date --version` failing does not make a system BSD — BusyBox fails it too — so test the behaviour itself, once, and keep the answer.

**Recommended**

```sh
if date -d @0 +%s > /dev/null 2>&1; then
  __date_from_epoch() { date -d "@$1" "+$2"; }
else
  __date_from_epoch() { date -r "$1" "+$2"; }
fi

# A portable in-place edit: write a copy, then move it over the file
sed 's/old/new/' "${file}" > "${file}.tmp" && mv -- "${file}.tmp" "${file}"
```

**Discouraged**

```sh
# GNU only: fails on macOS and on BusyBox
date -d "@${epoch}" +%F
sed -i 's/old/new/' "${file}"
target="$(readlink -f "${link}")"
```

## Calling Commands

### Checking Return Values

> [!NOTE]
Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Let `set -Eeuo pipefail`, or `dybatpho::register_common_handlers`, stop the script on an unhandled failure. (dybatpho)
> - ✔️ SHOULD: Test a command directly: `if ! command; then ... fi`
> - ✔️ SHOULD: Append `|| true` to a command whose failure is genuinely expected, and say in a comment why
> - ✔️ SHOULD: Exit with a meaningful status: `0` on success, non-zero on failure
> - ❌ AVOID: Do not inspect `$?` in a separate statement
> - ❌ AVOID: Do not rely on `PIPESTATUS`

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

### Error Handling

> [!NOTE]
Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Handle an error in the function where it happens, not in the caller
> - ✔️ SHOULD: Stop with `dybatpho::die` when the script cannot continue, and `return 1` when the caller can. (dybatpho)
> - ✔️ SHOULD: Say what failed and what the user can do about it, in a message on `STDERR`
> - ✔️ SHOULD: Install the common handlers once, at the top of an entrypoint, with `dybatpho::register_common_handlers`. (dybatpho)
> - ✔️ SHOULD: Name the function the caller called in an error message: `FUNCNAME[1]` from a helper that function calls directly, a name it passes in, or the first public function on the stack
> - ❌ AVOID: Do not return a bare non-zero status with no message
> - ❌ AVOID: Do not reach a fixed deeper level such as `FUNCNAME[2]`, which names another function as soon as the call depth changes

The function that fails is the only place that still knows the file name, the URL and the option that produced the failure. A caller that receives only `1` can either report nothing useful or invent context.

The message also has to name the call the script made. `FUNCNAME[2]` is right only for as long as the helper sits exactly two calls below the public function; called directly, or through one more layer, it names the script's own caller or a test runner instead, and points away from the call at fault.

**Recommended**

```sh
if [[ ! -x "${BATS_CMD}" ]]; then
  dybatpho::die "Bats test runner not found. Install bats, or run: git -C ${DYBATPHO_DIR} submodule update --init --recursive"
fi

function get_dir {
  local config_dir
  dybatpho::expect_args config_dir -- "$@"
  if [[ ! -e "$config_dir" ]]; then
    dybatpho::error "Configuration directory ${config_dir} does not exist"
    return 1
  fi
  echo "${config_dir}"
}

# The caller passes its own name, so the message names it at any depth
function __csv_require_text {
  [[ "$2" != *$'\x1f'* ]] || dybatpho::die "$1: The input contains the unit separator"
}

function csv::read {
  __csv_require_text "${FUNCNAME[0]}" "$1"
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

### Builtin Commands vs External Commands

> [!NOTE]
Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Prefer a builtin to an external command for the same job: parameter expansion over `sed`, `(( ... ))` over `expr`, `[[ ... ]]` over `test`
> - ✔️ SHOULD: Use an external tool such as `sed`, `awk` or `yq` when it makes the code clearly shorter and clearer
> - ✔️ SHOULD: Call an external tool through `command <tool>` when an alias or a function of the same name may be in scope. (custom)
> - ❌ AVOID: Do not build a parameter expansion so intricate that the reader has to test it to know what it does

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
```

**Discouraged**

```sh
# A process per line to do what ${url##*/} does
asset_name="$(echo "$url" | rev | cut -d/ -f1 | rev)"

# Unreadable, and it does the same as a two-line sed
result="${input//${a}\/${b}/${c}${d//x/y}}"
```
### Signal Handlers

> [!NOTE]
Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Compose a handler with the handlers already installed (`dybatpho::trap`) rather than replacing them. (dybatpho)
> - ✔️ SHOULD: Save the caller's handlers before a scoped call and restore them after it
> - ✔️ SHOULD: Run the cleanup of a scoped call before a caller's handler that exits, then re-raise the signal, so that handler and the default action still happen
> - ❌ AVOID: Do not install a library handler with a plain `trap '…' SIG`, and do not clear one with `trap - EXIT`

A library shares the trap table with the script that sourced it. `trap '…' INT` in a library silently removes the script's own Ctrl-C handling, and `trap - EXIT` removes cleanup someone else registered. Order matters as much: a caller's handler that calls `exit` ends the shell before a handler appended after it runs, so a lock is never released and child jobs keep running. A scoped call therefore installs its handler alone, puts the saved ones back when it ends, and re-raises the signal it caught.

**Recommended**

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

## Script Stabilization

### Writing Rerunnable Scripts

> [!NOTE]
Custom rule

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
dybatpho::is command "$name" || dybatpho::dry_run dytoy -t "$name"

# Fetches the submodule only when it is missing
if [[ ! -f "$SCRIPT_DIR/lib/dybatpho/init.sh" ]]; then
  git -C "$REPO_DIR" submodule update --init "$SCRIPT_DIR/lib/dybatpho"
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
dybatpho::dry_run rm -rf "${profile_dir}"

# Check the download before it is put in place
binary::verify_sha256 "${name}" "${temp_file}" "${url}" "${sha256_asset}"
dybatpho::dry_run mv "$temp_file" "$output_path"
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
Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Create temporary files with `dybatpho::create_temp <var> <suffix>` and directories with `dybatpho::create_temp_dir <var>`, which register their own cleanup. (dybatpho)
> - ✔️ SHOULD: Use `mktemp` when the library is not available, and remove the file with `trap 'rm -f "${temp_file}"' EXIT`
> - ✔️ SHOULD: Give the temporary file the suffix the content needs, so tools that dispatch on extension still work
> - ✔️ SHOULD: Derive a staging file next to its destination only from a path checked to be non-empty and not a directory, and create it exclusively: `set -C`, or `mktemp` in the destination's directory
> - ✔️ SHOULD: Create a file in a shared directory with `mktemp`, or by hand with a random suffix under noclobber (`set -C`), so a name that already exists is refused
> - ❌ AVOID: Do not build a temporary path yourself from `$$`, a timestamp or a fixed name
> - ❌ AVOID: Do not leave cleanup to the last line of the script, which an error never reaches
> - ❌ AVOID: Do not let an empty or failed path turn a staging file into one in the working directory
> - ❌ AVOID: Do not open a name in a shared directory with a plain `>`: it follows a symlink planted there, even when the name carries `$$` or `$BASHPID`

A predictable name in a world-writable directory is both a collision and a symlink attack. Registering the cleanup at creation time is the only way to have it run on the paths that matter: the error path and the interrupt.

A staging file built as `"$(dirname "${path}")/.staging.$$"` lands in the working directory when `path` is empty or came out of a substitution that failed, and a `>` onto a name someone planted follows their symlink. Check the destination first, then create the staging file so that an existing name is refused.

**Recommended**

```sh
dybatpho::create_temp sha256_file ".txt"
dybatpho::curl_download "${sha256_url}" "${sha256_file}"

dybatpho::create_temp_dir temp_dir
tar -xf "${archive}" -C "${temp_dir}"

# Without the library
temp_file="$(mktemp --suffix=.json)"
trap 'rm -f "${temp_file}"' EXIT INT TERM

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
```

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

## Testing

> [!NOTE]
Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Give every library a matching test file, `scripts/test/<area>.bats` next to `scripts/lib/<area>.sh`, written with [bats](https://github.com/bats-core/bats-core). (custom)
> - ✔️ SHOULD: Add the test for a new function in the same commit as the function. (custom)
> - ✔️ SHOULD: Put the shared setup of the suite in one helper, loaded by every file
> - ✔️ SHOULD: Expose the whole suite behind one entrypoint, so that running the tests takes no arguments to remember
> - ✔️ SHOULD: Run the linter and the formatter, `shellcheck` and `shfmt`, from the same place as the tests
> - ❌ AVOID: Do not test a function by running the script that calls it

A library function is only testable if it has no side effects of its own: it takes its arguments through `dybatpho::expect_args`, writes its result to `STDOUT` and its diagnostics to `STDERR`, and performs state changes through `dybatpho::dry_run`. Writing the test at the same time as the function is what keeps that shape honest.

**Recommended**

```sh
# scripts/test/chezmoi_attrs.bats
setup() {
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
Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Pass `-` when an assertion reads its expected value from a here-document: `assert_output - << EOF`
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
