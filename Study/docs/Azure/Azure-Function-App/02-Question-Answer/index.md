# 02 — Question and Answer

Each note answers **one** practical question with a consistent 12-part structure: short answer, detailed explanation, local vs Azure behaviour, an isolated-worker example and a one-line revision answer.

| Question | Topics involved | Status |
| --- | --- | --- |
| [How do I use Dependency Injection in the isolated worker?](Dependency-Injection-in-Isolated-Worker.md) | DI, `Program.cs`, lifetimes | 📝 |
| [When do I need CORS, and when does API Management replace it?](CORS-vs-API-Management.md) | CORS, APIM, browsers | 📝 |
| [What is the difference between a rate limiter and a load balancer?](Rate-Limiter-vs-Load-Balancer.md) | Rate limiting, load balancing, APIM, scaling | ✅ |
| [How does DefaultAzureCredential behave locally vs in Azure?](DefaultAzureCredential-Local-vs-Azure.md) | Azure.Identity, Managed Identity, RBAC | ✅ |
| [How should connections be managed with Managed Identity?](Managed-Identity-Connection-Management.md) | SDK clients, identity-based connections | 📝 |
| [How do Azure Functions scale?](Function-Scaling-Questions.md) | Scale controller, hosting plans, concurrency | 📝 |

---

[Back to Azure Function App](../index.md)
