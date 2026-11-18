---
name: bash-coding-style
description: Use when writing, changing or reviewing a Bash script held to the bash-coding-style guide, or when dyshellint reports a BSG rule code - looks up the tip behind each code and the rules of each chapter (naming, comments, formatting, error handling, temporary files, testing) without the full guide.
---

# Bash coding style

[bash-coding-style](https://github.com/dynamotn/bash-coding-style) is a style
guide for Bash scripts, checked by
[dyshellint](https://gitlab.com/dynamo-tools/dyshellint). Every tip is marked
✔️ SHOULD, ❌ AVOID or ⚠️ CONSIDER; a tip the linter checks ends with its rule
code, such as `<kbd>BSG010</kbd>`. A tip marked `(dybatpho)` is already taken
care of when the script uses the [dybatpho](https://github.com/dynamotn/dybatpho)
library; the `dybatpho` skill covers its functions.

## The loop

1. Write the script with the rules below in mind.
2. Run `dyshellint <path>...` and fix every finding. ✔️ and ❌ rules are
   errors, ⚠️ rules are warnings.
3. For a code you do not understand, find its tip: `rg BSG010 references/`.
   The heading above the tip links to the section of the guide, with the
   reasons and the recommended and discouraged examples.
4. Silence a finding only when it is a deliberate choice, with
   `# dyshellint disable=BSG### # <reason>` (or
   `# shellcheck disable=SC#### # <reason>`) on the line above it.

## The rules that matter most

- Start with `#!/usr/bin/env bash` and `set -euo pipefail`, unless the
  script sources dybatpho, which sets it.
- Give the file an sh-docs header (`@file`, `@brief`, `@description`) and
  every function a comment block (`@description`, `@arg`, `@stdout`,
  `@exitcode`).
- Declare functions as `function name {`, never with `()`. Name them in
  `snake_case`, namespaced after their library file (`net::fetch`); prefix a
  function private to a library with `__<namespace>_`, and one private to an
  entrypoint script with `_`.
- Declare every variable in a function with `local`. Never declare and
  assign from `$(...)` on one line: the status of the command is lost.
- Use `UPPERCASE` only for what the caller sets: options, exported variables
  and constants, made `readonly` at the top of the file.
- Quote every expansion and write it with braces: `"${var}"`. Test with
  `[[ ]]`, compute with `(( ))`, and capture with `$(...)`.
- Keep lists in arrays and expand them with `"${list[@]}"`; never build a
  command in a string, and never use `eval`.
- Send errors, logs and progress to STDERR; keep STDOUT for the data the
  script returns.
- Parse options from a spec (`dybatpho::opts::*`), not by hand, and never
  prompt when there is no terminal.
- Indent with two spaces, keep lines at 120 characters or fewer, and let
  `shfmt` format the file.
- Pass `--` before arguments that come from outside, so a value that starts
  with `-` is never read as an option.
- Make temporary files with `dybatpho::create_temp`, or with `mktemp` and
  an `EXIT` trap that removes them; write a file atomically through a
  staging file next to it and `mv`.
- Make a script safe to run twice: check the state before changing it.

## References

The tips of every chapter, generated from the guide by
`scripts/build_skill_rules.sh`:

- [Background](references/background.md): which shell, Bash version, when to use shell
- [Shell Files and Interpreter Invocation](references/shell-files-and-interpreter-invocation.md): file extensions, SUID/SGID
- [Environment](references/environment.md): invocation, arguments, completion, dry-run, output streams, configuration, input, cron, containers
- [Naming Conventions](references/naming-conventions.md): functions, variables, nameref locals
- [Comments](references/comments.md): file header, function comments, TODO
- [Formatting](references/formatting.md): indentation, line length, pipelines, control flow, quoting
- [Features and Bugs](references/features-and-bugs.md): substitution, tests, globs, eval, secrets, arrays, loops, arithmetic, portability
- [Calling Commands](references/calling-commands.md): return values, errors, exit codes, signals, child processes, network, remote commands
- [Script Stabilization](references/script-stabilization.md): rerunnable scripts, temporary files, locks, atomic writes, destructive commands
- [Testing](references/testing.md): bats assertions, isolation, mocks, version matrix, coverage

The full guide, with the reasons and examples:
<https://github.com/dynamotn/bash-coding-style/blob/main/README.md>.
