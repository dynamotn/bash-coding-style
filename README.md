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

```shell
#!/usr/bin/env bash
set -euo pipefail
# If not used dybatpho

#!/usr/bin/env bash
DYBATPHO_DIR=<path to dybatpho>
. "$DYBATPHO_DIR/init.sh"
# If used dybatpho
```

**Discouraged**

```shell
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
> - ✔️ SHOULD: Do not use extensions for scripts that are source internal only.  `chmod -x` for them (custom)

Executable files should either have a `.sh` extension (strongly recommended) or no extension. Scripts called from outside must have a `.sh` extension and should not be made executable.

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

```shell
# Use sudo when calling (Except in CI)
sudo ./foo.sh
```

**Discouraged**

```shell
# Switching to su or root user inside the script
```
