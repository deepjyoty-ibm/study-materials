# Configuration and Environment

> **Category:** Basics · **Status:** 📝 Draft note · **Applies to:** .NET isolated worker

## What it is

<!-- Explain that app settings become environment variables, how IConfiguration reads them, and how "__" maps to ":" for nested keys. -->

<ENTER-DEFINITION>

## Why it is used

<!-- Separate configuration from code; different values per environment; secrets kept out of source control. -->

- <ENTER-REASON>

## How it works

<!-- Describe the configuration sources and their precedence: local.settings.json (local), app settings (Azure), Key Vault references, App Configuration. -->

1. <ENTER-STEP>

## Important components

| Source | Where it applies | Notes |
| --- | --- | --- |
| `local.settings.json` → `Values` | Local only | <ENTER-NOTE> |
| App settings | Azure | <ENTER-NOTE> |
| Key Vault references `@Microsoft.KeyVault(...)` | Azure | <ENTER-NOTE> |
| Azure App Configuration | Both (optional) | <ENTER-NOTE> |

## Simple example

<!-- Show the Options pattern: a settings class, binding in Program.cs with ValidateDataAnnotations + ValidateOnStart, and injection with IOptions<T>. -->

**Simplified example**

```csharp
// <ENTER-CODE>
```

```json
{
  "IsEncrypted": false,
  "Values": {
    "<ENTER-SETTING>": "<YOUR-APPLICATION-SETTING>"
  }
}
```

## Common mistakes

- ❌ <ENTER-MISTAKE — e.g. using ":" in Linux app setting names instead of "__">

## Quick summary

📌 <ENTER-SUMMARY>

## Related notes

- [Configuration Cheatsheet](../08-Quick-Reference/Configuration-Cheatsheet.md)
- [Configuration Issues](../06-Debugging-Troubleshooting/Configuration-Issues.md)

---

[⬅️ Previous: Project Structure](Project-Structure.md) · [Index](index.md) · [Next: Local vs Azure Execution ➡️](Local-vs-Azure-Execution.md)
