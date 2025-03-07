# bash-coding-style

[English](README.md) | [Tiếng Việt](README.vi.md)

The style guide is not absolute, break it if necessary. The aim of this style guide is to reduce the psychological barriers to writing Bash scripts and to provide answers to common problems encountered when writing Bash scripts. Bash scripts are often delicate, difficult to maintain, and can easily become disliked. However, writing Bash scripts is sometimes necessary, so this style guide has been prepared.

When in doubt, prioritize consistency. By using a single style consistently throughout the codebase, you can focus on other (more important) issues. Consistency also allows for automation. In many cases, the rule of "maintain consistency" means "choose one option and stop worrying about it." The potential value of allowing flexibility on these points is outweighed by the cost of people debating them. However, there are limits to consistency. Consistency is a good factor for making decisions when there is no clear technical argument or long-term direction. On the other hand, consistency should not be used to justify continuing with an outdated style when there are clear advantages to a new one.

## Table of Contents

<!-- toc -->

- [Introduction](#introduction)
- [Background](#background)
  - [Which Shell to Use](#which-shell-to-use)

<!-- tocstop -->

## Introduction

This style guide provides guidelines for writing Bash scripts. It is based on the [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html) and [icy/bash-coding-style](https://github.com/icy/bash-coding-style), with some custom rules. Items that are intentionally made custom are explicitly marked as `(custom)`.

The following symbols are used:

| Symbol | Meaning |
| ------ | ------- |
| ✔️ SHOULD | Recommended. |
| ❌ AVOID | Not recommended. Make an effort to avoid it. |
| ⚠️ CONSIDER | Consider if possible. It may be applied depending on the situation. |

## Background

### Which Shell to Use

> ![NOTE]
> Custom rule

- ✔️ SHOULD: Use Bash for all scripts
- ✔️ SHOULD: Write `#!/usr/bin/env bash` at the top of the script. (custom)
- ✔️ SHOULD: Use `set -euo pipefail` for shell option settings. (custom)
- ⚠️ CONSIDER: If using other shells, explain the reason in comments. (custom)

Use Bash. Restricting all executable shell scripts to `bash` ensures a consistent shell installed on all machines.

Executable files should start with `#!/usr/bin/env bash` and minimal flags. Using `#!/usr/bin/env bash` provides several notable advantages: works across environments (like Fedora or Termux), although slight performance hit from invoking env to search PATH.

Using `set` for shell option settings ensures that even if the script is called with `bash script_name`, its functionality is not impaired. `set -euo pipefail` automatically detects errors early and terminates the script if an error occurs. `set -e` terminates the script if an error occurs. `set -u` triggers an error when referencing undefined variables. `set -o pipefail` terminates the script if an error occurs in the middle of a pipeline.

**Recommended**

```shell
#!/usr/bin/env bash
set -euo pipefail
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
