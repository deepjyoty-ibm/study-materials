# PS-002: Requests Intermittently Time Out

> **Category:** Production Scenario · **Severity:** <ENTER-SEVERITY> · **Status:** 📝 Draft note

## 1. Symptom

<!-- Describe the production symptom here. e.g. "5–10% of HTTP requests take > 30 s and fail with 504 or TaskCanceledException, mostly during business hours. Off-peak requests succeed." -->

<ENTER-PROBLEM>

## 2. Impact

<ENTER-IMPACT>

## 3. Possible causes

<!-- Candidates to evaluate (confirm before writing conclusions): -->

| # | Possible cause | How to confirm or rule out |
| --- | --- | --- |
| 1 | Slow downstream dependency | <ENTER-CHECK — dependency duration percentiles in Application Insights> |
| 2 | Socket / SNAT port exhaustion from creating `HttpClient` per call | <ENTER-CHECK> |
| 3 | Cold start on scale-out | <ENTER-CHECK> |
| 4 | Thread-pool starvation from sync-over-async (`.Result`, `.Wait()`) | <ENTER-CHECK> |
| 5 | Database connection pool exhaustion | <ENTER-CHECK> |
| 6 | <ENTER-CAUSE> | <ENTER-CHECK> |

## 4. Most likely cause

<ENTER-MOST-LIKELY-CAUSE>

## 5. Diagnostic steps

1. 🔍 <ENTER-STEP>

## 6. Logs and metrics to inspect

```kusto
// <ENTER-QUERY — e.g. requests | summarize percentiles(duration, 50, 95, 99) by bin(timestamp, 5m)>
```

## 7. Immediate mitigation

<ENTER-MITIGATION>

## 8. Permanent solution

<ENTER-SOLUTION>

## 9. C# or configuration fix

**<ENTER-EXAMPLE-LABEL>**

```csharp
// <ENTER-CODE>
```

## 10. Validation steps

- [ ] <ENTER-VALIDATION-STEP>

## 11. Prevention strategy

- <ENTER-PREVENTION>

## 12. Production checklist

- [ ] <ENTER-CHECK>

## 13. Lessons learned

📌 <ENTER-LESSON>

---

[⬅️ Previous: PS-001 Works Locally, Fails in Azure](PS-001-Works-Locally-Fails-in-Azure.md) · [Index](index.md) · [Next: PS-003 Sudden Traffic Spike ➡️](PS-003-Sudden-Traffic-Spike.md)
