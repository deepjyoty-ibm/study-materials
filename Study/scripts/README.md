# Scripts

Helper scripts for previewing the documentation, building PDFs and validating links. PowerShell scripts target Windows PowerShell 5.1 and PowerShell 7+; shell scripts target Bash.

| Script | Purpose |
| --- | --- |
| `preview-docs.ps1` / `.sh` | Serve the MkDocs Material site locally, or build it with `--strict`. |
| `build-pdf.ps1` / `.sh` | Build an A4 PDF from selected Markdown files using Pandoc. |
| `validate-links.ps1` | Check relative links, image paths, heading anchors and `mkdocs.yml` nav entries. |

All scripts:

- use paths relative to the repository root, so they work from any current directory;
- print status messages with a `[script-name]` prefix;
- exit with a **non-zero code** on failure;
- never delete or modify source Markdown files.

> 💡 If PowerShell reports that running scripts is disabled, either run the script with `powershell -NoProfile -ExecutionPolicy Bypass -File <script>` (applies to that process only) or change your execution policy according to your organisation's rules. The VS Code tasks already use the process-level bypass.

---

## preview-docs

Prerequisites: Python 3.9+ and `pip install -r requirements.txt` (a `.venv` in the repository root is used automatically if present).

```powershell
# Serve at http://127.0.0.1:8000
.\scripts\preview-docs.ps1

# Another port
.\scripts\preview-docs.ps1 -Port 8001

# Build the static site into ./site (strict: warnings fail the build)
.\scripts\preview-docs.ps1 -Build
```

```bash
./scripts/preview-docs.sh
./scripts/preview-docs.sh -p 8001
./scripts/preview-docs.sh --build
```

## build-pdf

Prerequisites: Pandoc 3.x and a PDF engine (WeasyPrint recommended, or wkhtmltopdf). Optional: `mermaid-filter` for rendering Mermaid diagrams. Details in [pdf/README.md](../pdf/README.md).

Output is always written to `pdf/output/`.

```powershell
# All Azure Function App notes -> pdf/output/study-notes.pdf
.\scripts\build-pdf.ps1

# Custom output name
.\scripts\build-pdf.ps1 -OutputName "azure-function-app.pdf"

# Selected files only (paths relative to the repository root, in the order they should appear)
.\scripts\build-pdf.ps1 -OutputName "AP-001.pdf" -Files `
  "docs/Azure/Azure-Function-App/03-Architecture-Problems/AP-001-Downstream-API-Throttling.md"

# Several files, no cover page, keep the intermediate HTML for debugging
.\scripts\build-pdf.ps1 -OutputName "interview.pdf" -NoCover -KeepHtml -Files `
  "docs/Azure/Azure-Function-App/07-Interview-Revision/Advanced-Architecture-Questions.md", `
  "docs/Azure/Azure-Function-App/08-Quick-Reference/Decision-Matrix.md"

# Force an engine
.\scripts\build-pdf.ps1 -Engine wkhtmltopdf
```

```bash
./scripts/build-pdf.sh
./scripts/build-pdf.sh -o azure-function-app.pdf
./scripts/build-pdf.sh -o AP-001.pdf docs/Azure/Azure-Function-App/03-Architecture-Problems/AP-001-Downstream-API-Throttling.md
./scripts/build-pdf.sh --no-cover --keep-html -e weasyprint -o interview.pdf \
  docs/Azure/Azure-Function-App/07-Interview-Revision/Advanced-Architecture-Questions.md
```

| Option (PowerShell / Bash) | Meaning |
| --- | --- |
| `-OutputName` / `-o` | Output file name only (no folder). `.pdf` is added if missing. |
| `-Files` / trailing arguments | Markdown files relative to the repository root. Default: all notes under `docs/Azure/Azure-Function-App`. |
| `-Engine` / `-e` | `auto`, `weasyprint` or `wkhtmltopdf`. |
| `-NoCover` / `--no-cover` | Skip `pdf/cover.md`. |
| `-KeepHtml` / `--keep-html` | Keep the intermediate HTML in `pdf/output/`. |

## validate-links

No prerequisites. Read-only.

```powershell
.\scripts\validate-links.ps1
```

Checks:

- relative links and image paths resolve to existing files;
- `#anchor` fragments match a heading in the target file;
- no absolute local paths are used in links;
- no Markdown file is empty;
- every file referenced in `mkdocs.yml` exists.

Links inside code fences, HTML comments and inline code are ignored. External `http(s)` links are not checked.

## Exit codes

| Code | Meaning |
| --- | --- |
| `0` | Success |
| `1` | Missing prerequisite, invalid argument or build/validation failure |

---

[Back to repository README](../README.md)
