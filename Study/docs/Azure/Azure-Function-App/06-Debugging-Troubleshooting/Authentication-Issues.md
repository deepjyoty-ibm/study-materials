# Authentication Issues — Troubleshooting

> **Category:** Debugging and Troubleshooting · **Status:** 📝 Draft note

## When to use this checklist

<!-- Symptoms that lead here: 401/403 from Azure resources, CredentialUnavailableException, AuthenticationFailedException, 401 from the function endpoint itself. -->

<ENTER-PROBLEM>

## Quick triage

1. <ENTER-STEP — Is the failure on the inbound call (caller → function) or the outbound call (function → resource)?>

## What to check locally

- [ ] <ENTER-CHECK — which developer credential is DefaultAzureCredential using?>

## What to check in Azure

- [ ] <ENTER-CHECK — managed identity status, principal ID>

## Authentication checks

- [ ] <ENTER-CHECK — data-plane role assignment and scope>

## Configuration checks

- [ ] <ENTER-CHECK — AZURE_CLIENT_ID, <Prefix>__credential, <Prefix>__clientId>

## Networking checks

- [ ] <ENTER-CHECK — can the app reach login.microsoftonline.com and the identity endpoint?>

## Runtime checks

- [ ] <ENTER-CHECK>

## Dependency Injection checks

- [ ] <ENTER-CHECK — single shared credential instance?>

## Application Insights checks

```kusto
// <ENTER-QUERY — dependencies where resultCode in ("401","403")>
```

## Scaling checks

- [ ] <ENTER-CHECK — token endpoint throttling when many instances start at once?>

## Deployment checks

- [ ] <ENTER-CHECK — identity enabled on the deployment slot as well?>

## Common fixes

| Finding | Fix |
| --- | --- |
| <ENTER-FINDING> | <ENTER-SOLUTION> |

## Related notes

- [DefaultAzureCredential: Local vs Azure](../02-Question-Answer/DefaultAzureCredential-Local-vs-Azure.md)
- [PS-005 Authentication Failure](../05-Production-Scenarios/PS-005-Authentication-Failure.md)

---

[⬅️ Previous: Troubleshooting Checklist](Troubleshooting-Checklist.md) · [Index](index.md) · [Next: Dependency Injection Issues ➡️](Dependency-Injection-Issues.md)
