<#
.SYNOPSIS
    Previews the documentation site locally with MkDocs Material, or builds it.

.PARAMETER Port
    Local port for the preview server. Default: 8000.

.PARAMETER Build
    Build the static site into ./site instead of serving it. Uses --strict so warnings fail the build.

.EXAMPLE
    .\scripts\preview-docs.ps1

.EXAMPLE
    .\scripts\preview-docs.ps1 -Port 8001

.EXAMPLE
    .\scripts\preview-docs.ps1 -Build
#>
[CmdletBinding()]
param(
    [ValidateRange(1, 65535)]
    [int]$Port = 8000,
    [switch]$Build
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

function Write-Status([string]$Message) { Write-Host "[preview-docs] $Message" -ForegroundColor Cyan }
function Stop-Preview([string]$Message) {
    Write-Host "[preview-docs] ERROR: $Message" -ForegroundColor Red
    exit 1
}

$RepoRoot = Split-Path -Parent $PSScriptRoot
$ConfigFile = Join-Path $RepoRoot 'mkdocs.yml'
if (-not (Test-Path -LiteralPath $ConfigFile -PathType Leaf)) { Stop-Preview "mkdocs.yml not found at $ConfigFile" }

# Prefer the project virtual environment if it exists.
$python = $null
foreach ($candidate in @(
        (Join-Path $RepoRoot '.venv/Scripts/python.exe'),
        (Join-Path $RepoRoot '.venv/bin/python'))) {
    if (Test-Path -LiteralPath $candidate -PathType Leaf) { $python = $candidate; break }
}
if (-not $python) {
    foreach ($name in @('python', 'python3', 'py')) {
        $cmd = Get-Command $name -ErrorAction SilentlyContinue
        if ($cmd) { $python = $cmd.Source; break }
    }
}
if (-not $python) { Stop-Preview 'Python was not found. Install Python 3.9+ and run: pip install -r requirements.txt' }
Write-Status "Using Python: $python"

& $python -c "import mkdocs, material" 2>$null
if ($LASTEXITCODE -ne 0) {
    Stop-Preview "MkDocs Material is not installed for this Python. Run: `"$python`" -m pip install -r requirements.txt"
}

Push-Location $RepoRoot
try {
    if ($Build) {
        Write-Status 'Building site into ./site (strict mode)...'
        & $python -m mkdocs build --strict --config-file $ConfigFile
        if ($LASTEXITCODE -ne 0) { Stop-Preview "mkdocs build failed with exit code $LASTEXITCODE." }
        Write-Status 'Build complete: ./site'
    } else {
        Write-Status "Starting preview at http://127.0.0.1:$Port (press Ctrl+C to stop)..."
        & $python -m mkdocs serve --config-file $ConfigFile --dev-addr "127.0.0.1:$Port"
        if ($LASTEXITCODE -ne 0) { Stop-Preview "mkdocs serve exited with code $LASTEXITCODE." }
    }
}
finally {
    Pop-Location
}
