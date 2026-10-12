# Trigger Selection Guide

> **Category:** Quick Reference · **Status:** 📝 Draft note

<!-- For each workload, state which trigger fits and why. Link to the messaging section of the Decision Matrix rather than repeating it. -->

## Workload → trigger

| Workload | Recommended trigger | Why | Avoid |
| --- | --- | --- | --- |
| Synchronous API | HTTP | <ENTER-REASON> | <ENTER-AVOID> |
| Background command processing | <ENTER-TRIGGER> | <ENTER-REASON> | <ENTER-AVOID> |
| Scheduled job | Timer | <ENTER-REASON> | <ENTER-AVOID> |
| React to file upload | <ENTER-TRIGGER — Blob vs Event Grid> | <ENTER-REASON> | <ENTER-AVOID> |
| High-volume telemetry | <ENTER-TRIGGER> | <ENTER-REASON> | <ENTER-AVOID> |
| React to database changes | <ENTER-TRIGGER> | <ENTER-REASON> | <ENTER-AVOID> |

## Trigger behaviour notes

| Trigger | Retry behaviour | Scaling signal | Notes |
| --- | --- | --- | --- |
| <ENTER-TRIGGER> | <ENTER-DETAIL> | <ENTER-DETAIL> | <ENTER-NOTE> |

## Related

- [Triggers and Bindings](../01-Basics/Triggers-and-Bindings.md)
- [Decision Matrix — Messaging service](Decision-Matrix.md#2-messaging-service)

---

[⬅️ Previous: Hosting Plan Comparison](Hosting-Plan-Comparison.md) · [Index](index.md) · [Next: Decision Matrix ➡️](Decision-Matrix.md)
