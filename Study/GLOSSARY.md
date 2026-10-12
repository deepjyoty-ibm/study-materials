# Glossary

Short definitions of terms used across the knowledge base. Definitions are intentionally simplified; follow the linked notes for depth.

| Term | Definition |
| --- | --- |
| **API Management (APIM)** | Azure gateway service placed in front of APIs. Provides policies such as authentication, rate limiting, quotas, transformation and caching. |
| **Application Insights** | Azure Monitor feature that collects requests, dependencies, traces, exceptions and custom metrics from applications. |
| **Binding** | A declarative connection from a function to another service (input or output) that reduces boilerplate code. |
| **Circuit breaker** | A resilience pattern that stops calling a failing dependency for a period of time so it can recover and so callers fail fast. |
| **Cold start** | Extra latency when a function app instance must be started before it can handle a request. Most visible on consumption-style plans. |
| **Consumption plan** | Serverless hosting plan where instances are added and removed automatically and billing is per execution. |
| **Correlation ID** | An identifier passed through every component of a request so logs from different services can be joined. |
| **Dead-letter queue (DLQ)** | A sub-queue holding messages that could not be processed successfully after the allowed attempts. |
| **DefaultAzureCredential** | Azure.Identity credential that tries several authentication sources in order (environment, managed identity, developer tools, and others). |
| **Dependency Injection (DI)** | Providing an object's dependencies from outside (a container) instead of creating them inside the object. |
| **Durable Functions** | Extension of Azure Functions for stateful orchestrations written in code. |
| **Elastic Premium plan** | Hosting plan with pre-warmed instances, VNet integration and longer execution limits. |
| **Exponential backoff** | A retry strategy where the wait time grows after each failed attempt (for example 1 s, 2 s, 4 s). |
| **Flex Consumption plan** | A newer serverless plan with configurable instance memory, VNet support and per-function scaling. Verify current capabilities in official documentation. |
| **Host (functions host)** | The Azure Functions runtime process that manages triggers, scaling hooks and the worker process. |
| **host.json** | Configuration file for runtime-wide settings such as logging, extension behaviour and timeouts. |
| **HTTP 429** | "Too Many Requests" — the server is rejecting calls because a rate limit was exceeded. |
| **Idempotency** | The property that processing the same request or message more than once has the same effect as processing it once. |
| **Isolated worker model** | Execution model where function code runs in a separate .NET process from the functions host. |
| **Jitter** | Random variation added to retry delays so many clients do not retry at the same moment. |
| **Key Vault** | Azure service for storing secrets, keys and certificates. |
| **local.settings.json** | Local-only file holding app settings during development. It is not deployed to Azure. |
| **Managed Identity** | An identity in Microsoft Entra ID managed by Azure for a resource, allowing it to obtain tokens without stored credentials. |
| **Options pattern** | .NET pattern that binds configuration sections to strongly typed classes (`IOptions<T>`). |
| **Peek-lock** | Service Bus receive mode where a message is locked, processed, and then completed or abandoned. |
| **Queue-based load leveling** | Placing a queue between producers and a consumer so the consumer processes at a controlled rate. |
| **Rate limiting** | Restricting how many operations are allowed in a time window. |
| **Scale controller** | Azure component that decides how many function app instances to run based on trigger load. |
| **Service Bus** | Azure enterprise message broker supporting queues, topics, sessions, duplicate detection and dead-lettering. |
| **Token bucket** | A rate-limiting algorithm where tokens refill at a fixed rate and each request consumes a token. |
| **Trigger** | The event that causes a function to run (HTTP request, queue message, timer, and others). |
| **User-assigned managed identity** | A managed identity created as a standalone resource and assigned to one or more resources. |
| **VNet integration** | Allowing a function app to make outbound calls into a virtual network. |

> 💡 Missing a term? Add it here in alphabetical order and link to the note where it is explained.
