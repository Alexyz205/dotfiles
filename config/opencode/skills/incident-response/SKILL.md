---
name: incident-response
description: Structured incident triage - assess severity, mitigate, communicate, and run RCA
license: MIT
compatibility: opencode
metadata:
  audience: on-call-engineers
  workflow: operations
---

## Purpose

Provide a structured framework for incident handling from detection to post-mortem.

## Triage Framework

### 1. Assess
- **What** is the user-facing impact? (service down, degraded, data loss)
- **Who** is affected? (all users, subset, internal only)
- **When** did it start? (correlate with recent deployments/changes)
- **Severity**: SEV1 (total outage) → SEV4 (minor, no user impact)

### 2. Mitigate
- Rollback recent changes if timing correlates
- Scale up / failover if capacity-related
- Feature flag toggle if feature-specific
- **Goal**: Restore service first, root-cause later

### 3. Communicate
- Notify stakeholders with: impact, ETA, who's working on it
- Update status page if public-facing
- Keep a timeline of actions taken (who did what, when)

### 4. Root Cause Analysis
- Gather: logs, metrics, traces, deployment history
- Use the 5 Whys or fault tree analysis
- Identify contributing factors (not just trigger)
- Document: timeline, root cause, mitigation, action items

### 5. Follow-up
- Create action items with owners and deadlines
- Classify: prevent recurrence, improve detection, improve response
- Share post-mortem (blameless)

## Diagnostic Commands

```bash
# Recent deployments
kubectl rollout history deployment/<name>
git log --oneline --since="2 hours ago"

# Service health
kubectl get pods -o wide | grep -v Running
kubectl top pods --sort-by=memory

# Logs
kubectl logs -l app=<name> --since=1h --tail=500
journalctl -u <service> --since "1 hour ago"
```

## When to Use

- Active incident or outage
- Post-incident review / writing post-mortems
- Preparing runbooks for on-call
