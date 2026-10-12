#!/usr/bin/env bash
# Builds an A4 PDF from selected Markdown notes using Pandoc and an HTML-based PDF engine.
#
# Flow: Markdown -> (Pandoc) self-contained HTML -> (WeasyPrint or wkhtmltopdf) PDF.
# All generated files are written to pdf/output only. Source files are never modified or deleted.
#
# Usage:
#   ./scripts/build-pdf.sh [-o OUTPUT_NAME] [-e auto|weasyprint|wkhtmltopdf] [--no-cover] [--keep-html] [FILE ...]
#
# Examples:
#   ./scripts/build-pdf.sh
#   ./scripts/build-pdf.sh -o AP-001.pdf docs/Azure/Azure-Function-App/03-Architecture-Problems/AP-001-Downstream-API-Throttling.md

set -euo pipefail

status() { printf '[build-pdf] %s\n' "$*"; }
warn()   { printf '[build-pdf] WARNING: %s\n' "$*" >&2; }
fail()   { printf '[build-pdf] ERROR: %s\n' "$*" >&2; exit 1; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PDF_DIR="$REPO_ROOT/pdf"
OUTPUT_DIR="$PDF_DIR/output"
CSS_FILE="$PDF_DIR/pdf-style.css"
METADATA_FILE="$PDF_DIR/metadata.yml"
COVER_FILE="$PDF_DIR/cover.md"
DEFAULT_SOURCE_DIR="$REPO_ROOT/docs/Azure/Azure-Function-App"

OUTPUT_NAME="study-notes.pdf"
ENGINE="auto"
USE_COVER=1
KEEP_HTML=0
FILES=()

# ---------------------------------------------------------------- arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    -o|--output)    [[ $# -ge 2 ]] || fail "Missing value for $1"; OUTPUT_NAME="$2"; shift 2 ;;
    -e|--engine)    [[ $# -ge 2 ]] || fail "Missing value for $1"; ENGINE="$2"; shift 2 ;;
    --no-cover)     USE_COVER=0; shift ;;
    --keep-html)    KEEP_HTML=1; shift ;;
    -h|--help)      sed -n '2,13p' "$0"; exit 0 ;;
    --)             shift; FILES+=("$@"); break ;;
    -*)             fail "Unknown option: $1" ;;
    *)              FILES+=("$1"); shift ;;
  esac
done

case "$ENGINE" in auto|weasyprint|wkhtmltopdf) ;; *) fail "Engine must be auto, weasyprint or wkhtmltopdf." ;; esac

[[ -n "$OUTPUT_NAME" ]] || fail "Output name must not be empty."
[[ "$OUTPUT_NAME" == "$(basename -- "$OUTPUT_NAME")" ]] || fail "Output name must be a file name only (no folders). Got: $OUTPUT_NAME"
[[ "$OUTPUT_NAME" == *.pdf || "$OUTPUT_NAME" == *.PDF ]] || OUTPUT_NAME="$OUTPUT_NAME.pdf"
PDF_PATH="$OUTPUT_DIR/$OUTPUT_NAME"
HTML_PATH="$OUTPUT_DIR/${OUTPUT_NAME%.*}.html"

# ---------------------------------------------------------------- prerequisites
status "Checking prerequisites..."
command -v pandoc >/dev/null 2>&1 || fail "Pandoc was not found on PATH. Install Pandoc 3.x from https://pandoc.org/installing.html"
status "Found $(pandoc --version | head -n 1)"

ENGINE_NAME=""
if [[ "$ENGINE" == "auto" ]]; then
  for candidate in weasyprint wkhtmltopdf; do
    if command -v "$candidate" >/dev/null 2>&1; then ENGINE_NAME="$candidate"; break; fi
  done
else
  command -v "$ENGINE" >/dev/null 2>&1 && ENGINE_NAME="$ENGINE"
fi
[[ -n "$ENGINE_NAME" ]] || fail "No PDF engine found. Install WeasyPrint (recommended: 'pip install weasyprint') or wkhtmltopdf. See pdf/README.md."
status "Using PDF engine: $ENGINE_NAME"

[[ -f "$CSS_FILE" ]] || fail "Required file missing: $CSS_FILE"
[[ -f "$METADATA_FILE" ]] || fail "Required file missing: $METADATA_FILE"

MERMAID_ARGS=()
if command -v mermaid-filter >/dev/null 2>&1; then
  status "Mermaid filter found. Diagrams will be rendered."
  MERMAID_ARGS=(--filter mermaid-filter)
else
  warn "mermaid-filter not found. Mermaid diagrams will appear as source code. See pdf/README.md."
fi

# ---------------------------------------------------------------- source files
SOURCES=()
if [[ ${#FILES[@]} -gt 0 ]]; then
  for f in "${FILES[@]}"; do
    path="$REPO_ROOT/$f"
    [[ -f "$path" ]] || fail "Source file not found: $f (paths are relative to the repository root)"
    [[ "$path" == *.md ]] || fail "Source file is not Markdown: $f"
    SOURCES+=("$path")
  done
else
  [[ -d "$DEFAULT_SOURCE_DIR" ]] || fail "Default source folder not found: $DEFAULT_SOURCE_DIR"
  # Sort by folder, then index.md first, then file name.
  while IFS= read -r line; do
    SOURCES+=("${line#*|}")
  done < <(
    find "$DEFAULT_SOURCE_DIR" -type f -name '*.md' -not -path '*/assets/*' |
    while IFS= read -r p; do
      dir="$(dirname -- "$p")"; name="$(basename -- "$p")"
      if [[ "$name" == "index.md" ]]; then rank=0; else rank=1; fi
      printf '%s/%s%s|%s\n' "$dir" "$rank" "$name" "$p"
    done | LC_ALL=C sort
  )
fi
[[ ${#SOURCES[@]} -gt 0 ]] || fail "No Markdown source files selected."
status "Selected ${#SOURCES[@]} Markdown file(s)."

# Resource path: docs root plus every source folder (for relative images).
RESOURCE_PATH="$REPO_ROOT/docs"
for s in "${SOURCES[@]}"; do
  d="$(dirname -- "$s")"
  case ":$RESOURCE_PATH:" in *":$d:"*) ;; *) RESOURCE_PATH="$RESOURCE_PATH:$d" ;; esac
done

# ---------------------------------------------------------------- build
mkdir -p "$OUTPUT_DIR"

INPUTS=()
if [[ $USE_COVER -eq 1 && -f "$COVER_FILE" ]]; then INPUTS+=("$COVER_FILE"); fi
INPUTS+=("${SOURCES[@]}")

cd "$REPO_ROOT"

status "Step 1/2: Converting Markdown to HTML with Pandoc..."
pandoc \
  --from markdown-tex_math_dollars-yaml_metadata_block \
  --to html5 \
  --standalone \
  --embed-resources \
  --toc --toc-depth=2 \
  --highlight-style=breezedark \
  --css="$CSS_FILE" \
  --metadata-file="$METADATA_FILE" \
  --resource-path="$RESOURCE_PATH" \
  --output "$HTML_PATH" \
  ${MERMAID_ARGS[@]+"${MERMAID_ARGS[@]}"} \
  "${INPUTS[@]}" || fail "Pandoc failed."

status "Step 2/2: Rendering PDF with $ENGINE_NAME..."
case "$ENGINE_NAME" in
  weasyprint)
    weasyprint "$HTML_PATH" "$PDF_PATH" || fail "WeasyPrint failed." ;;
  wkhtmltopdf)
    wkhtmltopdf --quiet --enable-local-file-access --page-size A4 \
      --margin-top 20mm --margin-bottom 22mm --margin-left 18mm --margin-right 18mm \
      --footer-center '[page] / [topage]' --footer-font-size 8 \
      "$HTML_PATH" "$PDF_PATH" || fail "wkhtmltopdf failed." ;;
esac

[[ -f "$PDF_PATH" ]] || fail "PDF was not created."

if [[ $KEEP_HTML -eq 0 && -f "$HTML_PATH" ]]; then
  # Removes only the intermediate HTML generated by this script inside pdf/output.
  rm -f -- "$HTML_PATH"
fi

status "PDF created: $PDF_PATH"
