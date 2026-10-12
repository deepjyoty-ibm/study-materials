#!/usr/bin/env bash
# Previews the documentation site locally with MkDocs Material, or builds it.
#
# Usage:
#   ./scripts/preview-docs.sh            # serve at http://127.0.0.1:8000
#   ./scripts/preview-docs.sh -p 8001    # serve on another port
#   ./scripts/preview-docs.sh --build    # build ./site in strict mode

set -euo pipefail

status() { printf '[preview-docs] %s\n' "$*"; }
fail()   { printf '[preview-docs] ERROR: %s\n' "$*" >&2; exit 1; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CONFIG_FILE="$REPO_ROOT/mkdocs.yml"
PORT=8000
BUILD=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    -p|--port)  [[ $# -ge 2 ]] || fail "Missing value for $1"; PORT="$2"; shift 2 ;;
    -b|--build) BUILD=1; shift ;;
    -h|--help)  sed -n '2,7p' "$0"; exit 0 ;;
    *)          fail "Unknown argument: $1" ;;
  esac
done

[[ "$PORT" =~ ^[0-9]+$ ]] || fail "Port must be a number."
[[ -f "$CONFIG_FILE" ]] || fail "mkdocs.yml not found at $CONFIG_FILE"

PYTHON=""
if [[ -x "$REPO_ROOT/.venv/bin/python" ]]; then
  PYTHON="$REPO_ROOT/.venv/bin/python"
elif command -v python3 >/dev/null 2>&1; then
  PYTHON="python3"
elif command -v python >/dev/null 2>&1; then
  PYTHON="python"
fi
[[ -n "$PYTHON" ]] || fail "Python was not found. Install Python 3.9+ and run: pip install -r requirements.txt"
status "Using Python: $PYTHON"

"$PYTHON" -c "import mkdocs, material" 2>/dev/null \
  || fail "MkDocs Material is not installed for this Python. Run: $PYTHON -m pip install -r requirements.txt"

cd "$REPO_ROOT"

if [[ $BUILD -eq 1 ]]; then
  status "Building site into ./site (strict mode)..."
  "$PYTHON" -m mkdocs build --strict --config-file "$CONFIG_FILE" || fail "mkdocs build failed."
  status "Build complete: ./site"
else
  status "Starting preview at http://127.0.0.1:$PORT (press Ctrl+C to stop)..."
  "$PYTHON" -m mkdocs serve --config-file "$CONFIG_FILE" --dev-addr "127.0.0.1:$PORT"
fi
