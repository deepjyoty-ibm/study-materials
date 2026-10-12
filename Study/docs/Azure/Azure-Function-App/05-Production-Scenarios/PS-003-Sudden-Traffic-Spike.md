# PS-003: A Sudden Traffic Spike Degrades the System

> **Category:** Production Scenario · **Severity:** <ENTER-SEVERITY> · **Status:** 📝 Draft note

## 1. Symptom

<!-- Describe the production symptom here. e.g. "During a marketing campaign, request volume rose 8× in 5 minutes. Function executions and cost rose sharply, the database returned throttling errors, and the downstream API returned 429." -->

<ENTER-PROBLEM>

## 2. Impact

<ENTER-IMPACT>

## 3. Possible causes

| # | Possible cause | How to confirm or rule out |
| --- | --- | --- |
| 1 | Unbounded scale-out multiplying downstream load | <ENTER-CHECK — instance count vs dependency failures> |
| 2 | No inbound rate limiting per client | <ENTER-CHECK> |
| 3 | Retry storm amplifying load | <ENTER-CHECK> |
| 4 | Legitimate traffic exceeding provisioned database throughput | <ENTER-CHECK> |
| 5 | Bot or abusive traffic | <ENTER-CHECK> |

## 4. Most likely cause

<ENTER-MOST-LIKELY-CAUSE>

## 5. Diagnostic steps

1. 🔍 <ENTER-STEP>

## 6. Logs and metrics to inspect

```kusto
// <ENTER-QUERY>
```

## 7. Immediate mitigation

<!-- e.g. lower maximum scale-out, enable APIM rate limit, temporarily raise database throughput. -->

<ENTER-MITIGATION>

## 8. Permanent solution

<!-- Link to AP-001 if the cause is downstream throttling. -->

<ENTER-SOLUTION>

## 9. C# or configuration fix

**<ENTER-EXAMPLE-LABEL>**

```json
{
  "<ENTER-SETTING>": "<YOUR-APPLICATION-SETTING>"
}
```

## 10. Validation steps

- [ ] <ENTER-VALIDATION-STEP — load test at expected peak>

## 11. Prevention strategy

- <ENTER-PREVENTION>

## 12. Production checklist

- [ ] <ENTER-CHECK>

## 13. Lessons learned

📌 <ENTER-LESSON>

## Related notes

- [AP-001 Downstream API Throttling](../03-Architecture-Problems/AP-001-Downstream-API-Throttling.md)
- [How do Azure Functions scale?](../02-Question-Answer/Function-Scaling-Questions.md)

---

[⬅️ Previous: PS-002 Intermittent Timeouts](PS-002-Intermittent-Timeouts.md) · [Index](index.md) · [Next: PS-004 Service Bus Message Failures ➡️](PS-004-Service-Bus-Message-Failures.md)
