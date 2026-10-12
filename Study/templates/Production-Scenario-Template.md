# PS-<ENTER-NUMBER>: <ENTER-SYMPTOM-AS-TITLE>

> **Category:** Production Scenario · **Severity:** <ENTER-SEVERITY> · **Status:** Draft note · **Last reviewed:** <ENTER-DATE>

<!-- Start from what was actually observed in production, not from the cause. -->

## 1. Symptom

<!-- Describe the production symptom here. Include error messages, status codes and timing. -->

<ENTER-PROBLEM>

## 2. Impact

<!-- Who is affected, how badly, and since when. -->

<ENTER-IMPACT>

## 3. Possible causes

| # | Possible cause | How to confirm or rule out |
| --- | --- | --- |
| 1 | <ENTER-CAUSE> | <ENTER-CHECK> |

## 4. Most likely cause

<!-- Explain why this is the most likely cause given the evidence. -->

<ENTER-MOST-LIKELY-CAUSE>

## 5. Diagnostic steps

1. 🔍 <ENTER-STEP>

## 6. Logs and metrics to inspect

<!-- Include Kusto (KQL) queries where useful. -->

```kusto
// <ENTER-QUERY>
```

## 7. Immediate mitigation

<!-- What restores service fastest, even if temporary. -->

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

[⬅️ Previous](<ENTER-PREVIOUS-NOTE>) · [Index](index.md) · [Next ➡️](<ENTER-NEXT-NOTE>)
