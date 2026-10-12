# 05 — Production Scenarios

Each scenario starts with an **observed production symptom** and works through diagnosis, mitigation, a permanent fix and prevention.

| ID | Symptom | Likely areas | Status |
| --- | --- | --- | --- |
| PS-001 | [It works locally but fails after Azure deployment](PS-001-Works-Locally-Fails-in-Azure.md) | Configuration, identity, networking, runtime | ✅ |
| PS-002 | [Requests intermittently time out](PS-002-Intermittent-Timeouts.md) | Downstream latency, socket exhaustion, cold start | 📝 |
| PS-003 | [A sudden traffic spike degrades the system](PS-003-Sudden-Traffic-Spike.md) | Scale-out, downstream limits, back-pressure | 📝 |
| PS-004 | [Service Bus messages repeatedly reach the dead-letter queue](PS-004-Service-Bus-Message-Failures.md) | Lock duration, poison messages, max delivery count | 📝 |
| PS-005 | [Managed Identity authentication fails](PS-005-Authentication-Failure.md) | Identity assignment, RBAC, token audience | 📝 |

> 💡 To add a new scenario, copy `templates/Production-Scenario-Template.md` from the repository root.

---

[Back to Azure Function App](../index.md)
