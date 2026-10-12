# Dependency Injection Issues — Troubleshooting

> **Category:** Debugging and Troubleshooting · **Status:** 📝 Draft note

## When to use this checklist

<!-- Symptoms: host fails to start, "Unable to resolve service for type ...", ObjectDisposedException, unexpected shared state between invocations, socket exhaustion. -->

<ENTER-PROBLEM>

## Quick triage

1. <ENTER-STEP — read the full startup exception in host logs>

## What to check locally

- [ ] <ENTER-CHECK — enable ValidateScopes / ValidateOnBuild in Development to catch lifetime errors early>

## What to check in Azure

- [ ] <ENTER-CHECK>

## Authentication checks

- [ ] <ENTER-CHECK — credential registered once and shared>

## Configuration checks

- [ ] <ENTER-CHECK — options bound before services that depend on them>

## Networking checks

- [ ] <ENTER-CHECK — HttpClient created via IHttpClientFactory>

## Runtime checks

- [ ] <ENTER-CHECK>

## Dependency Injection checks

| Lifetime | Safe to inject into | Typical use |
| --- | --- | --- |
| Singleton | <ENTER-DETAIL> | <ENTER-DETAIL> |
| Scoped | <ENTER-DETAIL> | <ENTER-DETAIL> |
| Transient | <ENTER-DETAIL> | <ENTER-DETAIL> |

- [ ] <ENTER-CHECK — no captive dependencies>

## Application Insights checks

```kusto
// <ENTER-QUERY>
```

## Scaling checks

- [ ] <ENTER-CHECK>

## Deployment checks

- [ ] <ENTER-CHECK>

## Common fixes

| Finding | Fix |
| --- | --- |
| <ENTER-FINDING> | <ENTER-SOLUTION> |

## Related notes

- [Dependency Injection in Isolated Worker](../02-Question-Answer/Dependency-Injection-in-Isolated-Worker.md)

---

[⬅️ Previous: Authentication Issues](Authentication-Issues.md) · [Index](index.md) · [Next: Configuration Issues ➡️](Configuration-Issues.md)
