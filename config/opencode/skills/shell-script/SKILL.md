---
name: shell-script
description: Production shell script standards - error handling, logging, argument parsing, cleanup
license: MIT
compatibility: opencode
metadata:
  audience: developers
  workflow: automation
---

## Purpose

Enforce production-grade standards when writing or reviewing shell scripts.

## Required Patterns

### Header

```bash
#!/usr/bin/env bash
set -euo pipefail
```

### Error Handling

- `set -e` — exit on error
- `set -u` — error on undefined variables
- `set -o pipefail` — catch pipe failures
- Trap cleanup: `trap cleanup EXIT ERR INT TERM`

### Logging

- Prefix with severity: `[INFO]`, `[WARN]`, `[ERROR]`
- Log to stderr: `echo "[ERROR] msg" >&2`
- Include timestamps in long-running scripts
- Use colors only when `stdout` is a terminal

### Arguments

- Validate required args with clear usage messages
- Support `--help` / `-h` flag
- Use `getopts` or manual `case` parsing for options
- Quote all variable expansions: `"${var}"`

### Cleanup

- Use trap for temporary files: `trap 'rm -f "$tmpfile"' EXIT`
- Release locks, restore state on exit
- Return meaningful exit codes (0=success, 1=general error, 2=usage error)

### Portability

- Prefer POSIX builtins over external commands where possible
- Test on target platforms (Ubuntu, Alpine, macOS)
- Avoid bashisms if targeting `/bin/sh`

### Validation

- Run `shellcheck` before committing — zero warnings policy
- Test with `bash -n script.sh` for syntax check

## Anti-patterns

- `cd dir && command` — use subshells or pushd/popd
- Unquoted `$variables` — word splitting bugs
- `cat file | grep` — useless use of cat
- `eval` with user input — injection risk
- Missing error handling on critical operations

## When to Use

- Writing new automation scripts
- Reviewing scripts for production readiness
- Refactoring existing scripts to meet standards
