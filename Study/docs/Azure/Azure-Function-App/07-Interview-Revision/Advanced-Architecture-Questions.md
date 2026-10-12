# Advanced Architecture Questions — Interview Questions

> **Category:** Interview and Revision · **Level:** Advanced, architecture and scenario based · **Status:** Complete sample note

These questions test whether you can **reason under constraints**, not just recall features. Strong answers state assumptions, compare options and explain trade-offs.

> ⚠️ Limits and feature availability depend on hosting plan, tier and runtime version. In an interview, say so explicitly — it is a sign of experience, not uncertainty.

## Contents

1. [A scaled-out function gets HTTP 429 from a downstream API. What do you do?](#q1-a-scaled-out-function-gets-http-429-from-a-downstream-api-what-do-you-do)
2. [How do you achieve exactly-once processing with Service Bus and Functions?](#q2-how-do-you-achieve-exactly-once-processing-with-service-bus-and-functions)
3. [When would you choose Durable Functions over Service Bus choreography?](#q3-when-would-you-choose-durable-functions-over-service-bus-choreography)
4. [How do you design a secretless Function App?](#q4-how-do-you-design-a-secretless-function-app)
5. [An HTTP function must do 10 minutes of work. How do you design it?](#q5-an-http-function-must-do-10-minutes-of-work-how-do-you-design-it)
6. [How do you choose a hosting plan for a new workload?](#q6-how-do-you-choose-a-hosting-plan-for-a-new-workload)
7. [How do you guarantee ordering when processing messages?](#q7-how-do-you-guarantee-ordering-when-processing-messages)
8. [How do you make a Function-based system observable end to end?](#q8-how-do-you-make-a-function-based-system-observable-end-to-end)

---

## Q1. A scaled-out function gets HTTP 429 from a downstream API. What do you do?

**Direct answer**

Separate the inbound rate from the outbound rate. Buffer work in a queue and process it with a consumer whose concurrency is capped below the downstream limit. Add retry with backoff and jitter, a circuit breaker and idempotency. Use a distributed rate limiter only if a concurrency cap is not precise enough.

**Detailed answer**

- **Root cause:** each instance calls the API independently; outbound rate ≈ per-instance rate × instance count. Scaling out makes it worse.
- **Immediate mitigation:** cap maximum scale-out, honour `Retry-After`, add jitter to retries.
- **Long-term:** queue-based load leveling (Service Bus), a worker with bounded concurrency (instances × concurrent calls), HTTP 202 to clients, idempotency keys and a DLQ.
- **Per-instance rate limiter** is insufficient when the limit is global.
- **APIM** protects inbound traffic; it does not control calls your function makes, unless you route outbound calls through it.
- **Redis token bucket** gives a precise global limit across all callers but adds a dependency and failure mode.

**Real-world example**

A shipping-label provider allows 50 requests/second. During a sale, the function scaled to 20 instances, each making ~10 calls/second. Moving to a Service Bus queue with a worker capped at 2 instances × 8 concurrent calls kept the rate near 40/s, and the backlog drained within minutes after the peak.

**Common wrong answer**

❌ "Add a rate limiter in the function" or "scale out more" — both ignore that the limit is global and that more instances mean more calls.

**Follow-up question**

What changes if the client requires a synchronous response within 5 seconds?

**One-line revision answer**

📌 Decouple with a queue, cap consumer concurrency below the global limit, retry with backoff and jitter, and make processing idempotent.

→ Deep dive: [AP-001 Downstream API Throttling](../03-Architecture-Problems/AP-001-Downstream-API-Throttling.md)

---

## Q2. How do you achieve exactly-once processing with Service Bus and Functions?

**Direct answer**

You do not get exactly-once **delivery**. You get at-least-once delivery and design for **exactly-once effect** through idempotent processing.

**Detailed answer**

- Peek-lock delivery means a message can be delivered again if the lock expires, the function crashes, or settlement fails.
- **Service Bus duplicate detection** drops duplicate **sends** with the same `MessageId` within a time window; it does not prevent **redelivery** of the same message.
- Exactly-once effect requires:
  1. A stable **idempotency key** (business ID or message ID).
  2. A **record** of processed keys, written atomically with (or before a safe point of) the side effect.
  3. **Idempotent downstream calls** where possible (provider idempotency keys, upserts, conditional writes).
- The **outbox pattern** prevents "state saved but event not published" inconsistencies on the producer side.

**Real-world example**

A worker credits loyalty points. It inserts `(messageId)` into a processed-messages table with a unique constraint **in the same database transaction** as the points update. A redelivered message fails the unique insert and is completed without crediting again.

**Common wrong answer**

❌ "Enable duplicate detection and set max delivery count to 1." Duplicate detection does not cover redelivery, and a max delivery count of 1 dead-letters messages on any transient failure.

**Follow-up question**

The side effect is an external API without idempotency support. How do you minimise duplicates?

**One-line revision answer**

📌 Service Bus is at-least-once; achieve exactly-once **effect** with idempotency keys, atomic processed-key records and idempotent side effects.

→ Deep dive: [AP-002 Duplicate Message Processing](../03-Architecture-Problems/AP-002-Duplicate-Message-Processing.md)

---

## Q3. When would you choose Durable Functions over Service Bus choreography?

**Direct answer**

Choose Durable Functions when the workflow needs **central visibility and control** — sequencing, timeouts, human approval, fan-out/fan-in or compensation logic in one place. Choose choreography when steps are **owned by different teams**, change independently and need loose coupling.

**Detailed answer**

| Aspect | Durable Functions (orchestration) | Service Bus (choreography) |
| --- | --- | --- |
| Workflow definition | In one orchestrator function | Spread across consumers |
| Visibility | Instance status and history built in | Requires correlation and custom tracking |
| Coupling | Orchestrator knows all steps | Steps only know events |
| Timeouts / waiting | Durable timers, external events | Scheduled messages, custom logic |
| Constraints | Orchestrator code must be deterministic; versioning needs care | Eventual consistency; harder to see the whole flow |
| Scaling | Depends on storage provider and task hub configuration | Independent per consumer |

**Real-world example**

A loan approval flow waits up to 3 days for a human decision, with reminders and escalation. Durable Functions with an external event and a durable timer expresses this clearly. An order fulfilment flow where warehouse, billing and notifications are owned by separate teams is better served by events on a Service Bus topic.

**Common wrong answer**

❌ "Durable Functions is always better because it has retries." Both approaches support retries; the real difference is coupling and visibility.

**Follow-up question**

How do you deploy a breaking change to an orchestrator that has thousands of running instances?

**One-line revision answer**

📌 Orchestrate (Durable) when you need central control and visibility; choreograph (Service Bus) when you need loose coupling between independently owned steps.

---

## Q4. How do you design a secretless Function App?

**Direct answer**

Use **managed identity** with **RBAC data-plane roles** for every Azure dependency, use **identity-based connections** for triggers and bindings (including host storage), and keep any unavoidable third-party secrets in **Key Vault**, accessed via Key Vault references by the managed identity.

**Detailed answer**

- **Identity choice:** system-assigned for single-app simplicity; user-assigned when several apps share access or the identity must survive app recreation.
- **Triggers/bindings:** configure `<Prefix>__fullyQualifiedNamespace` (Service Bus/Event Hubs), `<Prefix>__serviceUri` or `__accountName` (Storage), with `__credential` and `__clientId` for user-assigned identity. Verify setting names for each extension.
- **Host storage:** `AzureWebJobsStorage__accountName` with appropriate Storage data roles (verify plan support).
- **SDK clients:** `AddAzureClients` with one shared `TokenCredential`.
- **Disable** shared-key / local auth on resources where supported, so secrets cannot be used even if leaked.
- **Network:** private endpoints and VNet integration reduce exposure further (plan-dependent).
- **Residual secrets:** third-party API keys in Key Vault, rotated, never logged.

**Real-world example**

A team removed seven connection strings from app settings, assigned four data-plane roles to a user-assigned identity, and disabled shared-key access on the storage account. A later security review found zero stored Azure credentials.

**Common wrong answer**

❌ "Put all connection strings in Key Vault." That moves the secret but does not remove it; identities remove the need for the secret altogether.

**Follow-up question**

What are the deployment ordering issues with role assignments and how do you handle propagation delay?

**One-line revision answer**

📌 Managed identity + data-plane RBAC + identity-based trigger connections; Key Vault only for secrets that cannot be eliminated.

→ Deep dive: [AP-005 Secure Secretless Architecture](../03-Architecture-Problems/AP-005-Secure-Secretless-Architecture.md)

---

## Q5. An HTTP function must do 10 minutes of work. How do you design it?

**Direct answer**

Do not hold the HTTP request open. Use the **asynchronous request-reply** pattern: accept the request, start background work (queue + worker or a Durable orchestration), return **202 Accepted** with a status URL, and let the client poll or receive a callback.

**Detailed answer**

- HTTP requests are subject to load balancer and gateway timeouts, independently of the function timeout. Verify current limits.
- Function execution limits differ by hosting plan.
- **Durable Functions** has built-in HTTP status endpoints for this pattern.
- **Queue + worker** is simpler if the work is a single step.
- Break the work into **checkpointed steps** so a recycled instance does not restart everything.
- Protect the status endpoint so callers only see their own jobs.

**Real-world example**

A report generator moved from a synchronous 4-minute HTTP call (often timing out at the gateway) to a Durable orchestration with fan-out over data partitions. Clients polled the status URL and downloaded the report from Blob Storage via a short-lived SAS or authorised endpoint.

**Common wrong answer**

❌ "Increase `functionTimeout`." It does not change HTTP gateway timeouts and makes failures more expensive.

**Follow-up question**

How would you notify a browser client when the job is done without polling?

**One-line revision answer**

📌 Return 202 with a status URL and run the work asynchronously (queue worker or Durable Functions); never hold HTTP open for long work.

→ Deep dive: [AP-003 Long-Running Operation](../03-Architecture-Problems/AP-003-Long-Running-Operation.md)

---

## Q6. How do you choose a hosting plan for a new workload?

**Direct answer**

Choose based on **requirements**, in order: networking needs, execution duration, cold-start tolerance, scale pattern and cost model. There is no universally best plan.

**Detailed answer**

Ask:

1. Do you need **VNet integration / private endpoints**? This rules out some plans.
2. What is the **maximum execution time**?
3. Can you tolerate **cold start**? If not, you need always-ready or pre-warmed instances.
4. Is traffic **spiky or steady**? Spiky favours consumption-style billing; steady may favour dedicated capacity.
5. Do you already have **App Service capacity** to reuse?
6. Do you need **containers** or co-location with other container workloads?

Then map to Consumption, Flex Consumption, Elastic Premium, Dedicated or Container Apps hosting, **verifying current capabilities** for each.

**Real-world example**

An internal API needing private endpoints to SQL and sub-second latency at 8 a.m. moved from Consumption to a plan with VNet integration and always-ready instances. Cost rose, but the cold-start incidents stopped.

**Common wrong answer**

❌ "Always use Consumption because it is cheapest." It may be cheapest per execution, but not if it cannot meet networking or latency requirements.

**Follow-up question**

How does the choice of plan change your approach to downstream rate limiting?

**One-line revision answer**

📌 Pick the plan from networking, duration, cold-start and traffic-shape requirements; verify current plan capabilities.

→ Reference: [Hosting Plan Comparison](../08-Quick-Reference/Hosting-Plan-Comparison.md)

---

## Q7. How do you guarantee ordering when processing messages?

**Direct answer**

Guarantee ordering only **where the business needs it**, usually per entity (per order, per customer). Use **Service Bus sessions** with `SessionId` = entity ID, or **Event Hubs partitions** with a partition key, and process each session or partition sequentially.

**Detailed answer**

- Global ordering limits throughput to one consumer at a time; per-entity ordering keeps parallelism across entities.
- **Service Bus sessions:** one session is locked to one receiver at a time; messages in a session are delivered in order.
- **Event Hubs:** order is guaranteed within a partition; the function processes a partition's events in batches in order.
- Retries and dead-lettering can break perceived order — design consumers to tolerate or detect out-of-order events (sequence numbers, version checks).

**Real-world example**

Account balance updates must apply in order per account. Using `SessionId = accountId` kept per-account order while thousands of accounts were processed in parallel.

**Common wrong answer**

❌ "Service Bus queues are FIFO, so order is guaranteed." Without sessions, concurrent receivers and redelivery can process messages out of order.

**Follow-up question**

What happens to the remaining messages in a session when one message is dead-lettered?

**One-line revision answer**

📌 Order per entity, not globally: Service Bus sessions or Event Hubs partition keys, plus consumers that tolerate out-of-order edge cases.

---

## Q8. How do you make a Function-based system observable end to end?

**Direct answer**

Send all components to **Application Insights** with consistent **correlation**, add **business identifiers** to log scopes, monitor **queue depth and DLQ** as first-class health signals, and alert on symptoms users feel (latency, failure rate, stuck work).

**Detailed answer**

- **Distributed tracing:** W3C trace context flows through HTTP and Azure SDK calls; for messages, propagate correlation through message properties.
- **Structured logging:** `ILogger` with message templates and scopes (`OrderId`, `CorrelationId`), not string concatenation.
- **Metrics:** request rate, failure rate, latency percentiles, dependency failures, queue active and dead-letter counts, instance count.
- **Business signals:** orders stuck in a non-terminal state, end-to-end completion time.
- **Alerting:** on symptoms and SLO burn rate, not every exception.
- **Cost control:** sampling and retention; avoid logging payloads.

**Real-world example**

An incident took hours to diagnose because worker logs had no order ID. After adding log scopes and a "stuck orders" query, a similar incident was traced in minutes from a customer's order number.

**Common wrong answer**

❌ "Turn on Application Insights and you're done." Without correlation, business IDs and queue metrics, you see components but not flows.

**Follow-up question**

How do you trace a request across a Service Bus hop where the consumer runs minutes later?

**One-line revision answer**

📌 Application Insights everywhere, correlation IDs through HTTP and messages, business IDs in log scopes, and alerts on latency, failures, backlog and DLQ.

---

[⬅️ Previous: Intermediate Questions](Intermediate-Questions.md) · [Index](index.md) · [Next: Rapid Revision ➡️](Rapid-Revision.md)
