---
name: debug-k8s
description: Kubernetes debugging - pod crashes, OOM, networking, DNS, probe failures, resource issues
license: MIT
compatibility: opencode
metadata:
  audience: on-call-engineers
  workflow: kubernetes
---

## Purpose

Systematic Kubernetes troubleshooting guide with diagnostic commands and common failure patterns.

## Triage Order

1. **Pod status** — is it running?
2. **Events** — what happened recently?
3. **Logs** — what does the application say?
4. **Resources** — is it starved?
5. **Networking** — can it communicate?

## Common Failures

### CrashLoopBackOff
```bash
kubectl describe pod <pod>           # Check events, exit codes
kubectl logs <pod> --previous        # Logs from crashed container
kubectl get pod <pod> -o jsonpath='{.status.containerStatuses[0].lastState.terminated}'
```
- Exit 1: app error — check logs
- Exit 137: OOMKilled — increase memory limits
- Exit 143: SIGTERM — graceful shutdown issue

### ImagePullBackOff
```bash
kubectl describe pod <pod> | grep -A5 Events
kubectl get pod <pod> -o jsonpath='{.spec.containers[0].image}'
```
- Check: image exists, tag correct, registry auth (imagePullSecrets), network to registry

### OOMKilled
```bash
kubectl top pod <pod> --containers
kubectl describe pod <pod> | grep -A3 "Last State"
kubectl get pod <pod> -o jsonpath='{.spec.containers[0].resources}'
```
- Compare actual usage vs limits
- Profile memory in staging before setting limits
- Consider: memory leak vs insufficient limit

### Probe Failures (Liveness/Readiness)
```bash
kubectl describe pod <pod> | grep -A10 "Liveness\|Readiness"
kubectl exec <pod> -- curl -s localhost:<port>/healthz
```
- Check: endpoint exists, correct port, initialDelaySeconds sufficient
- Liveness failure = restart, Readiness failure = removed from service

### Pending Pods
```bash
kubectl describe pod <pod>           # Check events for scheduling failures
kubectl get nodes -o wide
kubectl describe node <node> | grep -A5 "Allocated resources"
```
- Insufficient CPU/memory, node affinity/taints, PVC not bound

### DNS Issues
```bash
kubectl exec <pod> -- nslookup <service>
kubectl exec <pod> -- nslookup <service>.<namespace>.svc.cluster.local
kubectl get svc -n kube-system | grep dns
kubectl logs -n kube-system -l k8s-app=kube-dns --tail=50
```

### Service Connectivity
```bash
kubectl get endpoints <service>      # Are pods registered?
kubectl get svc <service> -o wide    # Selector matches?
kubectl exec <pod> -- curl -v <service>:<port>
```

## Resource Diagnostics
```bash
kubectl top nodes
kubectl top pods --sort-by=memory
kubectl get events --sort-by='.lastTimestamp' | tail -20
kubectl get pods --field-selector=status.phase!=Running
```

## Methodology

1. Start with `kubectl get pods -o wide` — see the big picture
2. `kubectl describe pod` — events tell the story
3. `kubectl logs` (and `--previous`) — app-level errors
4. `kubectl exec` — test from inside the pod
5. Check node health if pod-level looks fine

## When to Use

- Pod not starting or crashing
- Service unreachable or intermittent failures
- Performance degradation in cluster
- Post-deployment issues
