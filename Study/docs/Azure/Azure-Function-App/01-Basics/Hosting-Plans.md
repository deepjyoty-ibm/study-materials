# Hosting Plans

> **Category:** Basics · **Status:** 📝 Draft note · **Applies to:** Azure Functions runtime 4.x

> ⚠️ Hosting-plan capabilities and limits change over time. Verify every number in this note against current official documentation before relying on it.

## What it is

<!-- Define "hosting plan" in one or two sentences: the plan decides how instances are allocated, scaled, networked and billed. -->

<ENTER-DEFINITION>

## Why it is used

<!-- Explain why the choice of plan matters: cold start, max execution time, VNet integration, scale limits, cost model. -->

- <ENTER-REASON>

## How it works

<!-- Describe how each plan allocates instances. Keep the comparison table in the Quick Reference section; link to it instead of duplicating it. -->

| Plan | Scaling model | Billing model | Typical use |
| --- | --- | --- | --- |
| Consumption | <ENTER-SCALING-MODEL> | <ENTER-BILLING-MODEL> | <ENTER-USE-CASE> |
| Flex Consumption | <ENTER-SCALING-MODEL> | <ENTER-BILLING-MODEL> | <ENTER-USE-CASE> |
| Elastic Premium | <ENTER-SCALING-MODEL> | <ENTER-BILLING-MODEL> | <ENTER-USE-CASE> |
| Dedicated (App Service) | <ENTER-SCALING-MODEL> | <ENTER-BILLING-MODEL> | <ENTER-USE-CASE> |
| Container Apps hosting | <ENTER-SCALING-MODEL> | <ENTER-BILLING-MODEL> | <ENTER-USE-CASE> |

## Important components

<!-- Pre-warmed instances, always-ready instances, maximum instance count, instance memory size, App Service plan SKU. -->

- <ENTER-COMPONENT>

## Simple example

<!-- An Azure CLI example that creates a function app on a chosen plan. Use placeholders for all resource names. -->

**Simplified example**

```bash
# <ENTER-CODE>
```

## Common mistakes

- ❌ <ENTER-MISTAKE — e.g. choosing a plan without checking VNet or timeout requirements>

## Quick summary

📌 <ENTER-SUMMARY>

## Related notes

- [Hosting Plan Comparison](../08-Quick-Reference/Hosting-Plan-Comparison.md)
- [How do Azure Functions scale?](../02-Question-Answer/Function-Scaling-Questions.md)
- [Azure Functions Overview](Azure-Functions-Overview.md)

---

[⬅️ Previous: Azure Functions Overview](Azure-Functions-Overview.md) · [Index](index.md) · [Next: Triggers and Bindings ➡️](Triggers-and-Bindings.md)
