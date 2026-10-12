# Study — Technical Study Knowledge Base

A personal, Markdown-first knowledge base for deep technical learning. The Markdown files in [`docs/`](docs/index.md) are the **single source of truth**. The same files can be:

- read directly in VS Code or GitHub,
- previewed as a local documentation website with **MkDocs Material**,
- converted into a printable **A4 PDF** with Pandoc.

---

## Current learning areas

| Area | Status | Entry point |
| --- | --- | --- |
| Azure → Azure Function App | 🛠️ Active | [Azure Function App index](docs/Azure/Azure-Function-App/index.md) |
| .NET | Planned | [DotNet index](docs/DotNet/index.md) |
| System Design (general) | Planned | [System Design index](docs/System-Design/index.md) |

## How the content is organised

Azure Function App notes follow a **learning journey**, not a list of isolated topics:

1. **Basics** — foundational concepts.
2. **Question and Answer** — one practical question per note.
3. **Architecture Problems** — constraint-driven problems that combine several concepts.
4. **System Design** — complete solutions where Function Apps are a key component.
5. **Production Scenarios** — start from a real symptom and work towards a fix.
6. **Debugging and Troubleshooting** — checklists.
7. **Interview and Revision** — graded questions with one-line answers.
8. **Quick Reference** — commands, cheat sheets and decision matrices.

> 💡 A single architecture problem can involve API Management, Service Bus, Managed Identity, Redis and retry policies together. That is why there is no top-level folder per technical concept.

## Repository layout

```text
Study/
├── docs/                 # All Markdown content (MkDocs docs_dir)
├── templates/            # Reusable note templates
├── pdf/                  # PDF metadata, styling, cover and output folder
├── scripts/              # Preview, PDF build and link validation scripts
├── .vscode/              # Workspace settings, extension recommendations, tasks
├── mkdocs.yml            # Website configuration
└── requirements.txt      # Python packages for the website
```

## Quick start

### 1. Preview the documentation website

```powershell
# Windows (from the Study folder)
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
.\scripts\preview-docs.ps1
```

```bash
# macOS / Linux (from the Study folder)
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
./scripts/preview-docs.sh
```

Open <http://127.0.0.1:8000> in a browser.

### 2. Build a PDF

```powershell
.\scripts\build-pdf.ps1
.\scripts\build-pdf.ps1 -OutputName "AP-001.pdf" -Files "docs/Azure/Azure-Function-App/03-Architecture-Problems/AP-001-Downstream-API-Throttling.md"
```

See [pdf/README.md](pdf/README.md) and [scripts/README.md](scripts/README.md) for prerequisites and options.

### 3. Validate links

```powershell
.\scripts\validate-links.ps1
```

All three actions are also available as VS Code tasks (**Terminal → Run Task…**).

## Related documents

- [Learning roadmap](LEARNING-ROADMAP.md)
- [Glossary](GLOSSARY.md)
- [Contributing and writing conventions](CONTRIBUTING.md)
- [Note templates](templates/)
