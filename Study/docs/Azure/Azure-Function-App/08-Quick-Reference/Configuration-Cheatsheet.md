# Configuration Cheatsheet

> **Category:** Quick Reference · **Status:** 📝 Draft note

> ⚠️ Setting names for identity-based connections vary by extension and version. Verify against current official documentation.

## Core app settings

| Setting | Purpose | Example value |
| --- | --- | --- |
| `FUNCTIONS_WORKER_RUNTIME` | Worker language | `dotnet-isolated` |
| `FUNCTIONS_EXTENSION_VERSION` | Runtime major version | `~4` |
| `AzureWebJobsStorage` / `AzureWebJobsStorage__accountName` | Host storage | <ENTER-VALUE> |
| `APPLICATIONINSIGHTS_CONNECTION_STRING` | Telemetry | `<YOUR-APPLICATION-SETTING>` |
| `AZURE_CLIENT_ID` | User-assigned identity for SDK clients | <ENTER-VALUE> |
| <ENTER-SETTING> | <ENTER-PURPOSE> | <ENTER-VALUE> |

## Identity-based connection patterns

| Service | Setting pattern | Notes |
| --- | --- | --- |
| Service Bus | `<Prefix>__fullyQualifiedNamespace` | <ENTER-NOTE> |
| Event Hubs | `<Prefix>__fullyQualifiedNamespace` | <ENTER-NOTE> |
| Storage (blob / queue) | `<Prefix>__serviceUri` or `<Prefix>__accountName` | <ENTER-NOTE> |
| User-assigned identity | `<Prefix>__credential` = `managedidentity`, `<Prefix>__clientId` | <ENTER-NOTE> |

## Key Vault reference syntax

```text
<ENTER-CODE — @Microsoft.KeyVault(SecretUri=<YOUR-KEY-VAULT-URL>/secrets/<name>/)>
```

## host.json essentials

```json
{
  "version": "2.0",
  "logging": {
    "<ENTER-SETTING>": "<ENTER-VALUE>"
  },
  "extensions": {
    "<ENTER-EXTENSION>": {}
  }
}
```

## local.settings.json template

```json
{
  "IsEncrypted": false,
  "Values": {
    "AzureWebJobsStorage": "UseDevelopmentStorage=true",
    "FUNCTIONS_WORKER_RUNTIME": "dotnet-isolated",
    "<ENTER-SETTING>": "<YOUR-APPLICATION-SETTING>"
  }
}
```

## Naming rules

- <ENTER-RULE — "__" maps to ":" in IConfiguration>

---

[⬅️ Previous: CLI Commands](CLI-Commands.md) · [Index](index.md) · [Next: Hosting Plan Comparison ➡️](Hosting-Plan-Comparison.md)
