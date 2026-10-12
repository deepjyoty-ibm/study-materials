# Local vs Azure Execution

> **Category:** Basics · **Status:** 📝 Draft note

## What it is

<!-- Explain that Core Tools emulates the host locally, but identity, networking, configuration and scaling differ in Azure. -->

<ENTER-DEFINITION>

## Why it is used

<!-- Knowing the differences prevents "works on my machine" incidents. Link to PS-001. -->

- <ENTER-REASON>

## How it works

| Concern | Local (Core Tools) | Azure |
| --- | --- | --- |
| Configuration source | <ENTER-DETAIL> | <ENTER-DETAIL> |
| Identity used by `DefaultAzureCredential` | <ENTER-DETAIL> | <ENTER-DETAIL> |
| Network path to dependencies | <ENTER-DETAIL> | <ENTER-DETAIL> |
| Storage for host (`AzureWebJobsStorage`) | <ENTER-DETAIL> | <ENTER-DETAIL> |
| Number of instances | <ENTER-DETAIL> | <ENTER-DETAIL> |
| HTTP auth level enforcement | <ENTER-DETAIL> | <ENTER-DETAIL> |
| Logging destination | <ENTER-DETAIL> | <ENTER-DETAIL> |

## Important components

- Azure Functions Core Tools
- Azurite (local storage emulator)
- <ENTER-COMPONENT>

## Simple example

**Simplified example**

```bash
# <ENTER-CODE — e.g. start Azurite, then func start>
```

## Common mistakes

- ❌ <ENTER-MISTAKE>

## Quick summary

📌 <ENTER-SUMMARY>

## Related notes

- [PS-001 Works Locally, Fails in Azure](../05-Production-Scenarios/PS-001-Works-Locally-Fails-in-Azure.md)
- [DefaultAzureCredential: Local vs Azure](../02-Question-Answer/DefaultAzureCredential-Local-vs-Azure.md)

---

[⬅️ Previous: Configuration and Environment](Configuration-and-Environment.md) · [Index](index.md) · [Next section: Question and Answer ➡️](../02-Question-Answer/index.md)
