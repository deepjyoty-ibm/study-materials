# Deployment Issues — Troubleshooting

> **Category:** Debugging and Troubleshooting · **Status:** 📝 Draft note

## When to use this checklist

<!-- Symptoms: deployment succeeds but no functions listed, old code still running, "Function host is not running", slot swap breaks the app. -->

<ENTER-PROBLEM>

## Quick triage

1. <ENTER-STEP — confirm what is actually deployed (Kudu file listing / package URL)>

## What to check locally

- [ ] <ENTER-CHECK — dotnet publish output contains functions.metadata and worker assemblies>

## What to check in Azure

- [ ] <ENTER-CHECK — deployment logs in Deployment Center>

## Authentication checks

- [ ] <ENTER-CHECK — pipeline service connection permissions; identity access to package storage>

## Configuration checks

- [ ] <ENTER-CHECK — WEBSITE_RUN_FROM_PACKAGE, FUNCTIONS_WORKER_RUNTIME, .NET version>

## Networking checks

- [ ] <ENTER-CHECK — SCM site access restrictions blocking the deployment agent>

## Runtime checks

- [ ] <ENTER-CHECK>

## Dependency Injection checks

- [ ] <ENTER-CHECK>

## Application Insights checks

```kusto
// <ENTER-QUERY — traces mentioning "Host started" around the deployment time>
```

## Scaling checks

- [ ] <ENTER-CHECK — all instances picked up the new package?>

## Deployment checks

- [ ] <ENTER-CHECK — slot swap with sticky settings; warm-up before swap>

## Common fixes

| Finding | Fix |
| --- | --- |
| <ENTER-FINDING> | <ENTER-SOLUTION> |

## Related notes

- [PS-001 Works Locally, Fails in Azure](../05-Production-Scenarios/PS-001-Works-Locally-Fails-in-Azure.md)
- [CLI Commands](../08-Quick-Reference/CLI-Commands.md)

---

[⬅️ Previous: Performance Issues](Performance-Issues.md) · [Index](index.md) · [Next section: Interview and Revision ➡️](../07-Interview-Revision/index.md)
