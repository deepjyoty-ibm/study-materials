# Triggers and Bindings

> **Category:** Basics · **Status:** 📝 Draft note · **Applies to:** .NET isolated worker

## What it is

<!-- Define trigger (what starts a function, exactly one per function) and binding (optional declarative input/output connection). -->

<ENTER-DEFINITION>

## Why it is used

<!-- Explain the value: less SDK plumbing, consistent configuration. Also note when using the SDK directly is preferable (more control, batching, custom retry). -->

- <ENTER-REASON>

## How it works

<!-- Explain how trigger extensions are installed as NuGet packages, how attributes configure them, and how the "Connection" property maps to app settings. -->

1. <ENTER-STEP>

## Important components

| Trigger / binding | Direction | Package (verify current name) | Notes |
| --- | --- | --- | --- |
| HTTP | Trigger | <ENTER-PACKAGE> | <ENTER-NOTE> |
| Timer | Trigger | <ENTER-PACKAGE> | <ENTER-NOTE> |
| Service Bus | Trigger / Output | <ENTER-PACKAGE> | <ENTER-NOTE> |
| Storage Queue | Trigger / Output | <ENTER-PACKAGE> | <ENTER-NOTE> |
| Blob | Trigger / Input / Output | <ENTER-PACKAGE> | <ENTER-NOTE> |
| Event Hubs | Trigger / Output | <ENTER-PACKAGE> | <ENTER-NOTE> |
| Cosmos DB | Trigger / Input / Output | <ENTER-PACKAGE> | <ENTER-NOTE> |

## Simple example

<!-- Show a Service Bus trigger with an identity-based connection (Connection = "ServiceBusConnection" + ServiceBusConnection__fullyQualifiedNamespace). -->

**Simplified example**

```csharp
// <ENTER-CODE>
```

## Common mistakes

- ❌ <ENTER-MISTAKE — e.g. connection setting name mismatch between attribute and app settings>

## Quick summary

📌 <ENTER-SUMMARY>

## Related notes

- [Trigger Selection Guide](../08-Quick-Reference/Trigger-Selection-Guide.md)
- [Managed Identity Connection Management](../02-Question-Answer/Managed-Identity-Connection-Management.md)

---

[⬅️ Previous: Hosting Plans](Hosting-Plans.md) · [Index](index.md) · [Next: In-Process vs Isolated Worker ➡️](In-Process-vs-Isolated-Worker.md)
