# How do Azure Functions scale?

> **Category:** Question and Answer · **Status:** 📝 Draft note

> ⚠️ Scaling behaviour depends heavily on the hosting plan, trigger type and runtime version. Verify all limits against current official documentation.

## 1. Question

<!-- e.g. What decides how many instances run, how fast does scale-out happen, and how do I limit it to protect downstream systems? -->

<ENTER-QUESTION>

## 2. Short answer

<ENTER-SHORT-ANSWER>

## 3. Detailed explanation

<!-- Cover: scale controller, target-based scaling for supported triggers, per-instance concurrency (host.json), maximum instance limits, scale-in behaviour. -->

<ENTER-DETAILED-EXPLANATION>

### Sub-questions to answer

1. <ENTER-QUESTION — How is scaling different for HTTP vs queue triggers?>
2. <ENTER-QUESTION — How do I cap the maximum number of instances?>
3. <ENTER-QUESTION — What is per-instance concurrency and where is it configured?>
4. <ENTER-QUESTION — Why does scaling out increase pressure on downstream services?>

## 4. How it works

```mermaid
flowchart TB
    A[<ENTER-DIAGRAM — trigger source metrics>] --> B[<ENTER-DIAGRAM — scale controller>]
```

## 5. Local development behavior

<ENTER-LOCAL-BEHAVIOR — single instance; no scale controller>

## 6. Azure production behavior

| Plan | Scale-out behaviour | Max instance setting |
| --- | --- | --- |
| <ENTER-PLAN> | <ENTER-DETAIL> | <ENTER-DETAIL> |

## 7. C# isolated-worker example

<!-- Scaling is mostly configuration. Show host.json concurrency settings for Service Bus instead of code. -->

**Conceptual example**

```json
{
  "version": "2.0",
  "extensions": {
    "<ENTER-EXTENSION>": {}
  }
}
```

## 8. Common misunderstanding

- ❌ <ENTER-MISUNDERSTANDING>
- ✅ <ENTER-CORRECTION>

## 9. Recommended approach

✅ <ENTER-SOLUTION>

## 10. When not to use it

- <ENTER-EXCEPTION>

## 11. Related questions

- [Rate Limiter vs Load Balancer](Rate-Limiter-vs-Load-Balancer.md)
- [Hosting Plans](../01-Basics/Hosting-Plans.md)
- [PS-003 Sudden Traffic Spike](../05-Production-Scenarios/PS-003-Sudden-Traffic-Spike.md)

## 12. Quick revision answer

📌 <ENTER-ONE-LINE-ANSWER>

---

[⬅️ Previous: Managed Identity Connection Management](Managed-Identity-Connection-Management.md) · [Index](index.md) · [Next section: Architecture Problems ➡️](../03-Architecture-Problems/index.md)
