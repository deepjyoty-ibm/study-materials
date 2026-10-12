<#
.SYNOPSIS
    Builds an A4 PDF from selected Markdown notes using Pandoc and an HTML-based PDF engine.

.DESCRIPTION
    Flow: Markdown -> (Pandoc) self-contained HTML -> (WeasyPrint or wkhtmltopdf) PDF.
    All generated files are written to pdf/output only. Source files are never modified or deleted.

.PARAMETER OutputName
    Output PDF file name (file name only, no folders). Default: study-notes.pdf

.PARAMETER Files
    One or more Markdown files, relative to the repository root, in the order they should appear.
    Default: every Markdown file under docs/Azure/Azure-Function-App (index pages first in each folder).

.PARAMETER Engine
    auto (default), weasyprint or wkhtmltopdf.

.PARAMETER NoCover
    Do not prepend pdf/cover.md.

.PARAMETER KeepHtml
    Keep the intermediate HTML file in pdf/output for inspection.

.EXAMPLE
    .\scripts\build-pdf.ps1

.EXAMPLE
    .\scripts\build-pdf.ps1 -OutputName "AP-001.pdf" -Files "docs/Azure/Azure-Function-App/03-Architecture-Problems/AP-001-Downstream-API-Throttling.md"
#>
[CmdletBinding()]
param(
    [string]$OutputName = 'study-notes.pdf',
    [string[]]$Files,
    [ValidateSet('auto', 'weasyprint', 'wkhtmltopdf')]
    [string]$Engine = 'auto',
    [switch]$NoCover,
    [switch]$KeepHtml
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

function Write-Status([string]$Message) { Write-Host "[build-pdf] $Message" -ForegroundColor Cyan }
function Write-Ok([string]$Message) { Write-Host "[build-pdf] $Message" -ForegroundColor Green }
function Stop-Build([string]$Message) {
    Write-Host "[build-pdf] ERROR: $Message" -ForegroundColor Red
    exit 1
}

$RepoRoot = Split-Path -Parent $PSScriptRoot
$PdfDir = Join-Path $RepoRoot 'pdf'
$OutputDir = Join-Path $PdfDir 'output'
$CssFile = Join-Path $PdfDir 'pdf-style.css'
$MetadataFile = Join-Path $PdfDir 'metadata.yml'
$CoverFile = Join-Path $PdfDir 'cover.md'
$DefaultSourceDir = Join-Path $RepoRoot 'docs/Azure/Azure-Function-App'

# ---------------------------------------------------------------- output name
if ([string]::IsNullOrWhiteSpace($OutputName)) { Stop-Build 'OutputName must not be empty.' }
if ([IO.Path]::GetFileName($OutputName) -ne $OutputName) {
    Stop-Build "OutputName must be a file name only (no folders). Output is always written to pdf/output. Got: $OutputName"
}
if (-not $OutputName.EndsWith('.pdf', [StringComparison]::OrdinalIgnoreCase)) { $OutputName = "$OutputName.pdf" }
$PdfPath = Join-Path $OutputDir $OutputName
$HtmlPath = Join-Path $OutputDir ([IO.Path]::ChangeExtension($OutputName, '.html'))

# ---------------------------------------------------------------- prerequisites
Write-Status 'Checking prerequisites...'

$pandoc = Get-Command 'pandoc' -ErrorAction SilentlyContinue
if (-not $pandoc) {
    Stop-Build 'Pandoc was not found on PATH. Install Pandoc 3.x from https://pandoc.org/installing.html and re-open the terminal.'
}
$pandocVersion = (& pandoc --version | Select-Object -First 1)
Write-Status "Found $pandocVersion"

$engineName = $null
$candidates = if ($Engine -eq 'auto') { @('weasyprint', 'wkhtmltopdf') } else { @($Engine) }
foreach ($candidate in $candidates) {
    if (Get-Command $candidate -ErrorAction SilentlyContinue) { $engineName = $candidate; break }
}
if (-not $engineName) {
    Stop-Build ("No PDF engine found (looked for: {0}). Install WeasyPrint (recommended: 'pip install weasyprint') or wkhtmltopdf. See pdf/README.md." -f ($candidates -join ', '))
}
Write-Status "Using PDF engine: $engineName"

foreach ($required in @($CssFile, $MetadataFile)) {
    if (-not (Test-Path -LiteralPath $required -PathType Leaf)) { Stop-Build "Required file missing: $required" }
}

# Optional Mermaid filter (renders ```mermaid blocks to images)
$mermaidFilter = Get-Command 'mermaid-filter.cmd', 'mermaid-filter' -ErrorAction SilentlyContinue | Select-Object -First 1
if ($mermaidFilter) {
    Write-Status "Mermaid filter found: $($mermaidFilter.Source). Diagrams will be rendered."
} else {
    Write-Host '[build-pdf] WARNING: mermaid-filter not found. Mermaid diagrams will appear as source code. See pdf/README.md.' -ForegroundColor Yellow
}

# ---------------------------------------------------------------- source files
$sources = New-Object System.Collections.Generic.List[string]
if ($Files -and $Files.Count -gt 0) {
    foreach ($f in $Files) {
        $candidatePath = Join-Path $RepoRoot $f
        if (-not (Test-Path -LiteralPath $candidatePath -PathType Leaf)) { Stop-Build "Source file not found: $f (paths are relative to the repository root)" }
        if ([IO.Path]::GetExtension($candidatePath) -ne '.md') { Stop-Build "Source file is not Markdown: $f" }
        $sources.Add((Resolve-Path -LiteralPath $candidatePath).Path)
    }
} else {
    if (-not (Test-Path -LiteralPath $DefaultSourceDir -PathType Container)) { Stop-Build "Default source folder not found: $DefaultSourceDir" }
    Get-ChildItem -LiteralPath $DefaultSourceDir -Recurse -Filter '*.md' -File |
        Where-Object { $_.FullName -notmatch '[\\/]assets[\\/]' } |
        Sort-Object @{ Expression = { $_.DirectoryName } }, @{ Expression = { $_.Name -ne 'index.md' } }, @{ Expression = { $_.Name } } |
        ForEach-Object { $sources.Add($_.FullName) }
}
if ($sources.Count -eq 0) { Stop-Build 'No Markdown source files selected.' }
Write-Status "Selected $($sources.Count) Markdown file(s)."

# Resource path: every source folder (for relative images) plus the docs root.
$resourceDirs = New-Object System.Collections.Generic.List[string]
$resourceDirs.Add((Join-Path $RepoRoot 'docs'))
foreach ($s in $sources) {
    $dir = Split-Path -Parent $s
    if (-not $resourceDirs.Contains($dir)) { $resourceDirs.Add($dir) }
}
$resourcePath = $resourceDirs -join [IO.Path]::PathSeparator

# ---------------------------------------------------------------- build
if (-not (Test-Path -LiteralPath $OutputDir -PathType Container)) {
    New-Item -ItemType Directory -Path $OutputDir | Out-Null
}

$inputs = New-Object System.Collections.Generic.List[string]
if (-not $NoCover -and (Test-Path -LiteralPath $CoverFile -PathType Leaf)) { $inputs.Add($CoverFile) }
$inputs.AddRange($sources)

$pandocArgs = New-Object System.Collections.Generic.List[string]
$pandocArgs.AddRange([string[]]@(
    '--from', 'markdown-tex_math_dollars-yaml_metadata_block',
    '--to', 'html5',
    '--standalone',
    '--embed-resources',
    '--toc', '--toc-depth=2',
    '--highlight-style=breezedark',
    "--css=$CssFile",
    "--metadata-file=$MetadataFile",
    "--resource-path=$resourcePath",
    '--output', $HtmlPath
))
if ($mermaidFilter) { $pandocArgs.AddRange([string[]]@('--filter', $mermaidFilter.Source)) }
$pandocArgs.AddRange($inputs)

Write-Status 'Step 1/2: Converting Markdown to HTML with Pandoc...'
Push-Location $RepoRoot
try {
    & pandoc @pandocArgs
    if ($LASTEXITCODE -ne 0) { Stop-Build "Pandoc failed with exit code $LASTEXITCODE." }

    Write-Status "Step 2/2: Rendering PDF with $engineName..."
    switch ($engineName) {
        'weasyprint' { & weasyprint $HtmlPath $PdfPath }
        'wkhtmltopdf' {
            & wkhtmltopdf --quiet --enable-local-file-access --page-size A4 `
                --margin-top 20mm --margin-bottom 22mm --margin-left 18mm --margin-right 18mm `
                --footer-center '[page] / [topage]' --footer-font-size 8 `
                $HtmlPath $PdfPath
        }
    }
    if ($LASTEXITCODE -ne 0) { Stop-Build "$engineName failed with exit code $LASTEXITCODE." }
}
finally {
    Pop-Location
}

if (-not (Test-Path -LiteralPath $PdfPath -PathType Leaf)) { Stop-Build 'PDF was not created.' }

if (-not $KeepHtml -and (Test-Path -LiteralPath $HtmlPath -PathType Leaf)) {
    # Removes only the intermediate HTML generated by this script inside pdf/output.
    Remove-Item -LiteralPath $HtmlPath
}

Write-Ok "PDF created: $PdfPath"
exit 0
