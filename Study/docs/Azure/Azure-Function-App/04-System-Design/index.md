# 04 — System Design

Complete solution designs in which Azure Function App is an important component. Each design follows a 30-part structure from requirements through failure-mode analysis.

| ID | Design | Main components | Status |
| --- | --- | --- | --- |
| SD-001 | [Order Processing System](SD-001-Order-Processing-System.md) | APIM, Functions, Service Bus, Cosmos DB, Key Vault | ✅ |
| SD-002 | [Payment Processing System](SD-002-Payment-Processing-System.md) | Idempotency, external payment provider, auditing | 📝 |
| SD-003 | [Notification System](SD-003-Notification-System.md) | Fan-out, topics, channel providers | 📝 |
| SD-004 | [File Processing Pipeline](SD-004-File-Processing-Pipeline.md) | Blob Storage, Event Grid, large-file handling | 📝 |
| SD-005 | [High-Volume Event Processing](SD-005-High-Volume-Event-Processing.md) | Event Hubs, partitions, checkpointing | 📝 |

> 💡 To add a new design, copy `templates/System-Design-Template.md` from the repository root.

---

[Back to Azure Function App](../index.md)
