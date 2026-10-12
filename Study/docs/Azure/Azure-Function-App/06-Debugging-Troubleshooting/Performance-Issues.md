# Performance Issues — Troubleshooting

> **Category:** Debugging and Troubleshooting · **Status:** 📝 Draft note

## When to use this checklist

<!-- Symptoms: high latency, high CPU or memory, execution count rising unexpectedly, cold starts, throttling from dependencies, increasing cost. -->

<ENTER-PROBLEM>

## Quick triage

1. <ENTER-STEP — is the time spent in your code, in dependencies, or before your code runs (cold start)?>

## What to check locally

- [ ] <ENTER-CHECK — profile with dotnet-counters / dotnet-trace>

## What to check in Azure

- [ ] <ENTER-CHECK — instance count, memory working set, CPU per instance>

## Authentication checks

- [ ] <ENTER-CHECK — token acquisition per call instead of cached credential>

## Configuration checks

- [ ] <ENTER-CHECK — host.json concurrency and batch settings>

## Networking checks

- [ ] <ENTER-CHECK — SNAT port exhaustion; connection reuse>

## Runtime checks

- [ ] <ENTER-CHECK — sync-over-async, thread-pool starvation, large allocations>

## Dependency Injection checks

- [ ] <ENTER-CHECK — expensive services registered as transient>

## Application Insights checks

```kusto
// <ENTER-QUERY — requests | summarize percentiles(duration, 50, 95, 99) by operation_Name>
```

## Scaling checks

- [ ] <ENTER-CHECK — scale-out lag; maximum instance limit; always-ready instances>

## Deployment checks

- [ ] <ENTER-CHECK — Release build, ReadyToRun (verify applicability)>

## Common fixes

| Finding | Fix |
| --- | --- |
| <ENTER-FINDING> | <ENTER-SOLUTION> |

## Related notes

- [PS-002 Intermittent Timeouts](../05-Production-Scenarios/PS-002-Intermittent-Timeouts.md)
- [AP-004 High-Traffic HTTP Function](../03-Architecture-Problems/AP-004-High-Traffic-HTTP-Function.md)

---

[⬅️ Previous: Configuration Issues](Configuration-Issues.md) · [Index](index.md) · [Next: Deployment Issues ➡️](Deployment-Issues.md)
