# CLI Commands

> **Category:** Quick Reference · **Status:** 📝 Draft note

> ⚠️ Command flags change between tool versions. Run `func --help` and `az functionapp --help` to confirm, and verify against current official documentation.

<!-- Group commands by task. Use placeholders for every resource name. Never include real subscription or tenant IDs. -->

## Azure Functions Core Tools

| Task | Command |
| --- | --- |
| Create isolated project | `func init <ENTER-PROJECT-NAME> --worker-runtime dotnet-isolated` |
| Add a function | `func new --name <ENTER-FUNCTION-NAME> --template "<ENTER-TEMPLATE>"` |
| Run locally | `func start` |
| Fetch app settings to local file | `func azure functionapp fetch-app-settings <YOUR-FUNCTION-APP>` |
| Publish | `func azure functionapp publish <YOUR-FUNCTION-APP>` |

## Local storage emulator

```bash
# <ENTER-CODE — start Azurite>
```

## Azure CLI — Function App

```bash
# <ENTER-CODE — create function app>
# <ENTER-CODE — list / set app settings>
# <ENTER-CODE — enable managed identity>
# <ENTER-CODE — restart app>
```

## Azure CLI — identity and RBAC

```bash
# <ENTER-CODE — az role assignment create ...>
```

## Azure CLI — diagnostics

```bash
# <ENTER-CODE — stream logs>
```

## PowerShell equivalents

```powershell
# <ENTER-CODE>
```

---

[Index](index.md) · [Next: Configuration Cheatsheet ➡️](Configuration-Cheatsheet.md)
