# PS-004: Service Bus Messages Repeatedly Reach the Dead-Letter Queue

> **Category:** Production Scenario · **Severity:** <ENTER-SEVERITY> · **Status:** 📝 Draft note

## 1. Symptom

<!-- Describe the production symptom here. e.g. "The dead-letter count on queue 'orders' grows by hundreds per hour. DeadLetterReason is MaxDeliveryCountExceeded. Function logs show MessageLockLostException." -->

<ENTER-PROBLEM>

## 2. Impact

<ENTER-IMPACT>

## 3. Possible causes

| # | Possible cause | How to confirm or rule out |
| --- | --- | --- |
| 1 | Processing time exceeds lock duration (lock lost → redelivery) | <ENTER-CHECK — compare function duration with LockDuration and maxAutoLockRenewalDuration> |
| 2 | Poison message (invalid payload) failing every attempt | <ENTER-CHECK — inspect DeadLetterErrorDescription and body> |
| 3 | Downstream dependency failing persistently | <ENTER-CHECK> |
| 4 | Deserialisation / schema mismatch after a producer change | <ENTER-CHECK> |
| 5 | Prefetch too high, messages expire or locks lapse before processing | <ENTER-CHECK> |
| 6 | Unhandled exception from a bug introduced in the last release | <ENTER-CHECK> |

## 4. Most likely cause

<ENTER-MOST-LIKELY-CAUSE>

## 5. Diagnostic steps

1. 🔍 <ENTER-STEP — peek DLQ messages with Service Bus Explorer and group by DeadLetterReason>

## 6. Logs and metrics to inspect

```kusto
// <ENTER-QUERY>
```

## 7. Immediate mitigation

<ENTER-MITIGATION>

## 8. Permanent solution

<ENTER-SOLUTION>

## 9. C# or configuration fix

**<ENTER-EXAMPLE-LABEL>**

```json
{
  "version": "2.0",
  "extensions": {
    "serviceBus": {
      "<ENTER-SETTING>": "<ENTER-VALUE>"
    }
  }
}
```

## 10. Validation steps

- [ ] <ENTER-VALIDATION-STEP>

## 11. Prevention strategy

- <ENTER-PREVENTION>

## 12. Production checklist

- [ ] <ENTER-CHECK>

## 13. Lessons learned

📌 <ENTER-LESSON>

## Related notes

- [AP-002 Duplicate Message Processing](../03-Architecture-Problems/AP-002-Duplicate-Message-Processing.md)

---

[⬅️ Previous: PS-003 Sudden Traffic Spike](PS-003-Sudden-Traffic-Spike.md) · [Index](index.md) · [Next: PS-005 Authentication Failure ➡️](PS-005-Authentication-Failure.md)
