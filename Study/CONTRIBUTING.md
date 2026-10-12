# Contributing and Writing Conventions

This file describes how to add and maintain notes so the knowledge base stays consistent, navigable and printable.

## 1. Where does a new note go?

| If the note is about… | Put it in… | Template |
| --- | --- | --- |
| A foundational concept | `01-Basics/` | [Basic-Note-Template.md](templates/Basic-Note-Template.md) |
| One practical question | `02-Question-Answer/` | [Question-Answer-Template.md](templates/Question-Answer-Template.md) |
| A constraint-driven problem | `03-Architecture-Problems/` | [Architecture-Problem-Template.md](templates/Architecture-Problem-Template.md) |
| A complete solution design | `04-System-Design/` | [System-Design-Template.md](templates/System-Design-Template.md) |
| A real production symptom | `05-Production-Scenarios/` | [Production-Scenario-Template.md](templates/Production-Scenario-Template.md) |
| A troubleshooting checklist | `06-Debugging-Troubleshooting/` | [Troubleshooting-Template.md](templates/Troubleshooting-Template.md) |
| Interview questions | `07-Interview-Revision/` | [Interview-Question-Template.md](templates/Interview-Question-Template.md) |
| Cheat sheets and tables | `08-Quick-Reference/` | — |

## 2. File naming

- Use `Title-Case-With-Hyphens.md`.
- Use descriptive names. Avoid `Q001.md` or `notes.md`.
- Numbered series use a prefix:
  - `AP-NNN-` for architecture problems
  - `SD-NNN-` for system design
  - `PS-NNN-` for production scenarios
- Every folder has an `index.md` that acts as its table of contents.

## 3. Adding a note — checklist

1. Copy the matching template from `templates/`.
2. Replace every `<ENTER-…>` placeholder and delete the HTML guidance comments.
3. Add the note to the folder `index.md`.
4. Add the note to `nav:` in `mkdocs.yml`.
5. Update Previous / Index / Next links in the neighbouring notes.
6. Run `scripts/validate-links.ps1`.

## 4. Writing style

- Simple, professional English. Short paragraphs.
- Define a term before using it deeply.
- Explain **why**, not only **what**.
- Separate **facts**, **assumptions**, **alternatives** and **recommendations**.
- Do not present architecture choices as universal rules.
- When behaviour depends on hosting plan, runtime version or configuration, say so.
- Add *"Verify against current official documentation"* for version-sensitive details.

## 5. Icon set

Use only these icons, and only where they add meaning:

| Icon | Meaning |
| --- | --- |
| 💡 | Important insight |
| ⚠️ | Warning |
| ✅ | Recommended |
| ❌ | Avoid |
| 🔍 | Investigation |
| 🧩 | Architecture |
| 🛠️ | Implementation |
| 📌 | Summary |

## 6. Code examples

- Azure Functions C# examples target the **.NET isolated worker model**.
- Label every code block as **Simplified example**, **Conceptual example** or **Production-oriented example**.
- Never include real secrets, connection strings, tenant IDs, subscription IDs or endpoints.
- Use placeholders such as `<YOUR-KEY-VAULT-URL>`, `<YOUR-SERVICE-BUS-NAMESPACE>`, `<YOUR-APPLICATION-SETTING>`, `<YOUR-API-ENDPOINT>`.

## 7. Diagrams

- Use Mermaid (`flowchart`, `sequenceDiagram`, `stateDiagram-v2`).
- Prefer top-to-bottom (`flowchart TB`) layouts so diagrams fit an A4 page.
- Keep node labels short and readable.
- Store reusable diagrams under `docs/Azure/Azure-Function-App/assets/diagrams/` as `.mmd` files.

## 8. Admonitions

MkDocs Material admonitions are supported:

```markdown
!!! warning "Version-sensitive"
    Verify against current official documentation.
```

Because admonitions render as indented text in plain Markdown viewers, prefer blockquotes for short notes that must look good everywhere:

```markdown
> ⚠️ **Warning:** Verify against current official documentation.
```
