# Rapid Revision

> **Category:** Interview and Revision · **Level:** All · **Status:** 📝 Draft note

One-line answers for last-minute revision. Each line should link to the note where the topic is explained.

<!-- Add one row per concept. Keep the answer to a single sentence. Fill in only after the source note is complete. -->

## Fundamentals

| Topic | One-line answer | Source |
| --- | --- | --- |
| Function vs Function App | <ENTER-ONE-LINE-ANSWER> | [Overview](../01-Basics/Azure-Functions-Overview.md) |
| Isolated worker | <ENTER-ONE-LINE-ANSWER> | [In-Process vs Isolated](../01-Basics/In-Process-vs-Isolated-Worker.md) |
| Hosting plans | <ENTER-ONE-LINE-ANSWER> | [Hosting Plans](../01-Basics/Hosting-Plans.md) |

## Identity and security

| Topic | One-line answer | Source |
| --- | --- | --- |
| DefaultAzureCredential | Tries credentials in order; locally usually the developer, in Azure usually the managed identity. | [Q&A](../02-Question-Answer/DefaultAzureCredential-Local-vs-Azure.md) |
| Secretless design | <ENTER-ONE-LINE-ANSWER> | [AP-005](../03-Architecture-Problems/AP-005-Secure-Secretless-Architecture.md) |

## Traffic and resilience

| Topic | One-line answer | Source |
| --- | --- | --- |
| Rate limiter vs load balancer | A load balancer decides where a request goes; a rate limiter decides whether it is allowed now. | [Q&A](../02-Question-Answer/Rate-Limiter-vs-Load-Balancer.md) |
| Downstream 429 after scale-out | Queue + concurrency-capped worker + backoff with jitter + idempotency. | [AP-001](../03-Architecture-Problems/AP-001-Downstream-API-Throttling.md) |
| Duplicate processing | <ENTER-ONE-LINE-ANSWER> | [AP-002](../03-Architecture-Problems/AP-002-Duplicate-Message-Processing.md) |
| Long-running work | <ENTER-ONE-LINE-ANSWER> | [AP-003](../03-Architecture-Problems/AP-003-Long-Running-Operation.md) |

## Operations

| Topic | One-line answer | Source |
| --- | --- | --- |
| Works locally, fails in Azure | Check configuration, identity, network, runtime and package — in that order. | [PS-001](../05-Production-Scenarios/PS-001-Works-Locally-Fails-in-Azure.md) |
| <ENTER-TOPIC> | <ENTER-ONE-LINE-ANSWER> | <ENTER-SOURCE-LINK> |

---

[⬅️ Previous: Advanced Architecture Questions](Advanced-Architecture-Questions.md) · [Index](index.md) · [Next section: Quick Reference ➡️](../08-Quick-Reference/index.md)
