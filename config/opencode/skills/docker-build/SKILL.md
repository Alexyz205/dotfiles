---
name: docker-build
description: Dockerfile best practices - multi-stage builds, layer optimization, security hardening
license: MIT
compatibility: opencode
metadata:
  audience: developers
  workflow: containers
---

## Purpose

Guide creation and review of production-grade Dockerfiles.

## Standards

### Build Structure
- Multi-stage builds: separate build and runtime stages
- Pin base image digests or specific tags (never `latest` in production)
- Order layers by change frequency (least → most changing)
- Combine RUN commands to reduce layers

### Security
- Run as non-root user (`USER <uid>:<gid>`)
- Use distroless or minimal base images (Alpine, scratch) where possible
- No secrets in build args or layers — use BuildKit secrets
- Scan with `docker scout` or `trivy` before shipping
- Set `HEALTHCHECK` instruction

### Optimization
- Use `.dockerignore` to exclude unnecessary files
- Leverage BuildKit cache mounts for package managers:
  ```dockerfile
  RUN --mount=type=cache,target=/var/cache/apt apt-get install -y ...
  ```
- Copy dependency manifests before source code for better caching
- Minimize final image size — audit with `docker history`

### Linting
- Validate with `hadolint` before committing
- Common issues: missing version pins, `apt-get` without `--no-install-recommends`, `COPY . .` too early

## When to Use

- Writing new Dockerfiles
- Reviewing existing Dockerfiles for production readiness
- Debugging slow or large builds
- Container security hardening
