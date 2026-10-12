# Configuration Issues — Troubleshooting

> **Category:** Debugging and Troubleshooting · **Status:** 📝 Draft note

## When to use this checklist

<!-- Symptoms: null configuration values, OptionsValidationException at startup, Key Vault reference shows an error, different behaviour between slots. -->

<ENTER-PROBLEM>

## Quick triage

1. <ENTER-STEP — list app setting names and compare with expected keys>

## What to check locally

- [ ] <ENTER-CHECK — local.settings.json "Values" vs nested JSON (only flat Values are loaded)>

## What to check in Azure

- [ ] <ENTER-CHECK — Environment variables blade, Key Vault reference status>

## Authentication checks

- [ ] <ENTER-CHECK — identity used for Key Vault references (keyVaultReferenceIdentity)>

## Configuration checks

- [ ] <ENTER-CHECK — "__" vs ":" naming>
- [ ] <ENTER-CHECK — slot settings marked "sticky" as intended>

## Networking checks

- [ ] <ENTER-CHECK — Key Vault firewall allows the Function App path>

## Runtime checks

- [ ] <ENTER-CHECK>

## Dependency Injection checks

- [ ] <ENTER-CHECK — options registered with Bind + ValidateOnStart>

## Application Insights checks

```kusto
// <ENTER-QUERY>
```

## Scaling checks

- [ ] <ENTER-CHECK>

## Deployment checks

- [ ] <ENTER-CHECK — IaC and portal edits not overwriting each other>

## Common fixes

| Finding | Fix |
| --- | --- |
| <ENTER-FINDING> | <ENTER-SOLUTION> |

## Related notes

- [Configuration and Environment](../01-Basics/Configuration-and-Environment.md)
- [Configuration Cheatsheet](../08-Quick-Reference/Configuration-Cheatsheet.md)

---

[⬅️ Previous: Dependency Injection Issues](Dependency-Injection-Issues.md) · [Index](index.md) · [Next: Performance Issues ➡️](Performance-Issues.md)
