# PS-005: Managed Identity Authentication Fails

> **Category:** Production Scenario · **Severity:** <ENTER-SEVERITY> · **Status:** 📝 Draft note

## 1. Symptom

<!-- Describe the production symptom here. e.g. "After moving from connection strings to Managed Identity, the function logs 'ManagedIdentityCredential authentication failed' or receives 403 AuthorizationFailed from Key Vault." -->

<ENTER-PROBLEM>

## 2. Impact

<ENTER-IMPACT>

## 3. Possible causes

| # | Possible cause | How to confirm or rule out |
| --- | --- | --- |
| 1 | Managed identity not enabled on the Function App (or slot) | <ENTER-CHECK> |
| 2 | Role assigned to the wrong principal or at the wrong scope | <ENTER-CHECK> |
| 3 | Management-plane role assigned instead of data-plane role | <ENTER-CHECK> |
| 4 | User-assigned identity attached but client ID not configured | <ENTER-CHECK> |
| 5 | Role assignment not yet propagated | <ENTER-CHECK> |
| 6 | Key Vault uses access policies, not RBAC (or vice versa) | <ENTER-CHECK> |
| 7 | Wrong token audience/scope for a custom API | <ENTER-CHECK> |

## 4. Most likely cause

<ENTER-MOST-LIKELY-CAUSE>

## 5. Diagnostic steps

1. 🔍 <ENTER-STEP>

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

## Related notes

- [DefaultAzureCredential: Local vs Azure](../02-Question-Answer/DefaultAzureCredential-Local-vs-Azure.md)
- [Authentication Issues checklist](../06-Debugging-Troubleshooting/Authentication-Issues.md)

---

[⬅️ Previous: PS-004 Service Bus Message Failures](PS-004-Service-Bus-Message-Failures.md) · [Index](index.md) · [Next section: Debugging and Troubleshooting ➡️](../06-Debugging-Troubleshooting/index.md)
