# 03 — Architecture Problems

Realistic, constraint-driven problems. Each problem combines only the concepts that are genuinely relevant and ends with trade-offs, a production-readiness checklist and follow-up questions.

| ID | Problem | Difficulty | Main concepts | Status |
| --- | --- | --- | --- | --- |
| AP-001 | [Downstream API Throttling](AP-001-Downstream-API-Throttling.md) | Advanced | Rate limiting, APIM, Service Bus, retry, circuit breaker, idempotency | ✅ |
| AP-002 | [Duplicate Message Processing](AP-002-Duplicate-Message-Processing.md) | Intermediate | At-least-once delivery, idempotency, duplicate detection | 📝 |
| AP-003 | [Long-Running Operation](AP-003-Long-Running-Operation.md) | Intermediate | Timeouts, async request-reply, Durable Functions | 📝 |
| AP-004 | [High-Traffic HTTP Function](AP-004-High-Traffic-HTTP-Function.md) | Advanced | Scaling, cold start, caching, APIM | 📝 |
| AP-005 | [Secure Secretless Architecture](AP-005-Secure-Secretless-Architecture.md) | Intermediate | Managed Identity, Key Vault, RBAC, networking | 📝 |

> 💡 To add a new problem, copy `templates/Architecture-Problem-Template.md` from the repository root (the templates folder is outside `docs/` so it is not published).

---

[Back to Azure Function App](../index.md)
