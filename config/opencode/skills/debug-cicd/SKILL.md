---
name: debug-cicd
description: CI/CD pipeline debugging - runner issues, caching, secrets, artifacts, stage failures
license: MIT
compatibility: opencode
metadata:
  audience: developers
  workflow: ci-cd
---

## Purpose

Systematic debugging of CI/CD pipeline failures for GitLab CI and GitHub Actions.

## Triage Order

1. **Which stage/job failed?** — Read the error message first
2. **Is it flaky or consistent?** — Retry once, check history
3. **What changed?** — Recent commits, config changes, dependency updates
4. **Environment or code?** — Same failure locally?

## Common Failures

### Runner/Environment Issues
**Symptoms**: Job stuck, timeout, "no runner available"
```yaml
# GitLab: Check runner tags match
job:
  tags: [docker, linux]  # Must match registered runner tags

# GitHub Actions: Check runner labels
runs-on: ubuntu-latest   # Or self-hosted runner labels
```
- Check runner health/registration
- Disk space on self-hosted runners
- Docker socket availability for DinD

### Dependency/Cache Issues
**Symptoms**: "module not found", intermittent failures, slow builds
```yaml
# GitLab CI cache
cache:
  key: "${CI_COMMIT_REF_SLUG}"  # Branch-scoped
  paths: [node_modules/, .pip/]
  policy: pull-push              # Or pull for downstream jobs

# GitHub Actions cache
- uses: actions/cache@v4
  with:
    path: ~/.npm
    key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
    restore-keys: ${{ runner.os }}-node-
```
- Clear cache and retry: stale cache is the #1 flaky cause
- Pin dependency versions to avoid surprise updates
- Check lockfile is committed

### Secrets/Authentication
**Symptoms**: 401/403 errors, "permission denied", empty variables
```yaml
# GitLab: Check variable scope
# Settings > CI/CD > Variables
# Protected? Only on protected branches
# Masked? Won't appear in logs

# GitHub: Check secret scope
# Repo settings > Secrets and variables > Actions
# Environment secrets only available in that environment
```
- Secrets not available in forks (PRs from forks)
- Masked variables silently empty if format invalid
- OIDC preferred over long-lived tokens

### Docker Build Failures
**Symptoms**: Build context too large, layer cache miss, multi-platform issues
- Check `.dockerignore` — missing = huge context upload
- BuildKit cache: `--cache-from` / `--cache-to` for CI
- Platform mismatch: building arm64 on amd64 runner needs QEMU/buildx

### Artifact Issues
**Symptoms**: "artifact not found", wrong files, expired
```yaml
# GitLab: artifacts between stages
artifacts:
  paths: [build/]
  expire_in: 1 hour
  when: on_success     # or always, on_failure

# GitHub: upload/download
- uses: actions/upload-artifact@v4
  with:
    name: build-output
    path: build/
    retention-days: 1
```
- Artifacts only passed to downstream stages/jobs
- Check `needs:` / `dependencies:` for correct job graph
- Path patterns must match actual output

### Timeout Failures
- Identify which step is slow (timestamps in logs)
- Common: dependency install, Docker build, test suite
- Fix: caching, parallelism, test sharding, smaller images

## Debugging Techniques

1. **Add debug output**: `set -x` in shell steps, `--verbose` flags
2. **SSH into runner** (if self-hosted): inspect environment directly
3. **Run locally**: `act` for GitHub Actions, `gitlab-runner exec` for GitLab
4. **Check pipeline graph**: dependency/ordering issues
5. **Compare with last green run**: diff pipeline config + code changes

## When to Use

- Pipeline failure investigation
- Flaky test/build diagnosis
- Pipeline performance optimization
- Setting up new CI/CD pipelines
