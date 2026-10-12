# Project Structure

> **Category:** Basics · **Status:** 📝 Draft note · **Applies to:** .NET isolated worker

## What it is

<!-- Describe the files created by `func init --worker-runtime dotnet-isolated` and what each one is for. -->

<ENTER-DEFINITION>

## Why it is used

<!-- Why knowing the layout matters: debugging startup errors, knowing what is deployed and what is local-only. -->

- <ENTER-REASON>

## How it works

```text
<ENTER-PROJECT-TREE>
MyFunctionApp/
├── Program.cs
├── host.json
├── local.settings.json      # local only, not deployed
├── MyFunctionApp.csproj
└── Functions/
    └── <ENTER-FUNCTION-FILE>.cs
```

## Important components

| File | Purpose | Deployed? |
| --- | --- | --- |
| `Program.cs` | <ENTER-PURPOSE> | Yes (compiled) |
| `host.json` | <ENTER-PURPOSE> | Yes |
| `local.settings.json` | <ENTER-PURPOSE> | No |
| `*.csproj` | <ENTER-PURPOSE> | Yes (compiled) |

## Simple example

<!-- Show a minimal .csproj with the key worker packages and the AzureFunctionsVersion property. Verify package versions. -->

**Simplified example**

```xml
<!-- <ENTER-CODE> -->
```

## Common mistakes

- ❌ <ENTER-MISTAKE — e.g. committing local.settings.json with secrets>

## Quick summary

📌 <ENTER-SUMMARY>

## Related notes

- [Configuration and Environment](Configuration-and-Environment.md)
- [In-Process vs Isolated Worker](In-Process-vs-Isolated-Worker.md)

---

[⬅️ Previous: In-Process vs Isolated Worker](In-Process-vs-Isolated-Worker.md) · [Index](index.md) · [Next: Configuration and Environment ➡️](Configuration-and-Environment.md)
