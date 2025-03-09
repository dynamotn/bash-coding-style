# bash-coding-style

[English](README.md) | [Tiếng Việt](README.vi.md)

The style guide is not absolute, break it if necessary. The aim of this style guide is to reduce the psychological barriers to writing Bash scripts and to provide answers to common problems encountered when writing Bash scripts. Bash scripts are often delicate, difficult to maintain, and can easily become disliked. However, writing Bash scripts is sometimes necessary, so this style guide has been prepared.

When in doubt, prioritize consistency. By using a single style consistently throughout the codebase, you can focus on other (more important) issues. Consistency also allows for automation. In many cases, the rule of `maintain consistency` means `choose one option and stop worrying about it`. The potential value of allowing flexibility on these points is outweighed by the cost of people debating them. However, there are limits to consistency. Consistency is a good factor for making decisions when there is no clear technical argument or long-term direction. On the other hand, consistency should not be used to justify continuing with an outdated style when there are clear advantages to a new one.

## Table of Contents

<!-- toc -->

- [Introduction](#introduction)
  - [Supported library](#supported-library)
- [Background](#background)
  - [Which Shell to Use](#which-shell-to-use)
  - [When to Use Shell](#when-to-use-shell)
- [Shell Files and Interpreter Invocation](#shell-files-and-interpreter-invocation)
  - [File Extensions](#file-extensions)
  - [SUID/SGID](#suidsgid)
- [Environment](#environment)
  - [STDOUT and STDERR](#stdout-and-stderr)
  - [Common Function Scripts](#common-function-scripts)
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
- [Features and Bugs](#features-and-bugs)
  - [Use ShellCheck](#use-shellcheck)

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

## Comments

### File Header

> [!NOTE]
Custom rule

> [!TIP]
>
> - ✔️ SHOULD: Include a comment at the beginning of the file that concisely explains the purpose or content of the file. However, do not include comments before the shebang line
> - ✔️ SHOULD: Use [shdoc](https://github.com/reconquest/shdoc) format includes: `@file`, `@brief`, `@description` to explain the file. (custom)

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
> - ✔️ SHOULD: Use [shdoc](https://github.com/reconquest/shdoc) format to explain the function. (custom)

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
if [[ nantoka ]]; then
  ;;
else
  ;;
fi

for i in $(seq 1 10); do
  echo $i
done
```

**Discouraged**

```sh
if [[ nantoka ]];
then
  ;;
fi

for i in $(seq 1 10)
do
  echo $i
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
> - ❌ AVOID: Avoid bracing shell special variables/positional parameters unless explicitly necessary or to avoid serious confusion

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
