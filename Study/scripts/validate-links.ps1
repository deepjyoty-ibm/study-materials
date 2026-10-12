<#
.SYNOPSIS
    Validates relative Markdown links, image paths, heading anchors and mkdocs.yml nav entries.

.DESCRIPTION
    Scans the repository Markdown files (docs/, templates are skipped because they contain placeholders)
    plus root-level Markdown files and pdf/README.md. Links inside fenced code blocks and inline code
    are ignored. External links (http, https, mailto) are not checked. The script is read-only.
    Exits with code 1 when a problem is found.

.EXAMPLE
    .\scripts\validate-links.ps1
#>
[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$RepoRoot = Split-Path -Parent $PSScriptRoot
$errors = New-Object System.Collections.Generic.List[string]
$checked = 0

function Get-Slug([string]$Heading) {
    $h = $Heading -replace '`', ''
    $h = $h -replace '\[([^\]]*)\]\([^)]*\)', '$1'
    $h = $h.Trim().ToLowerInvariant()
    $h = [regex]::Replace($h, '[^\w\s-]', '')
    $h = [regex]::Replace($h, '[\s]+', '-')
    return $h
}

function Get-Anchors([string]$Path) {
    $anchors = New-Object System.Collections.Generic.HashSet[string]
    $inFence = $false
    foreach ($line in [IO.File]::ReadAllLines($Path, [Text.Encoding]::UTF8)) {
        if ($line -match '^\s*(```|~~~)') { $inFence = -not $inFence; continue }
        if ($inFence) { continue }
        if ($line -match '^\s{0,3}#{1,6}\s+(.+?)\s*#*\s*$') { [void]$anchors.Add((Get-Slug $Matches[1])) }
    }
    return , $anchors
}

$anchorCache = @{}

$files = @()
$files += Get-ChildItem -LiteralPath (Join-Path $RepoRoot 'docs') -Recurse -Filter '*.md' -File
$files += Get-ChildItem -LiteralPath $RepoRoot -Filter '*.md' -File
$pdfReadme = Join-Path $RepoRoot 'pdf/README.md'
if (Test-Path -LiteralPath $pdfReadme) { $files += Get-Item -LiteralPath $pdfReadme }
$scriptsReadme = Join-Path $RepoRoot 'scripts/README.md'
if (Test-Path -LiteralPath $scriptsReadme) { $files += Get-Item -LiteralPath $scriptsReadme }

foreach ($file in $files) {
    $relFile = $file.FullName.Substring($RepoRoot.Length + 1)
    $text = [IO.File]::ReadAllText($file.FullName, [Text.Encoding]::UTF8)

    if ($text.Trim().Length -eq 0) { $errors.Add("${relFile}: file is empty"); continue }

    # Remove fenced code blocks, HTML comments and inline code so their contents are not treated as links.
    $clean = [regex]::Replace($text, '(?ms)^\s*(```+|~~~+).*?^\s*\1\s*$', '')
    $clean = [regex]::Replace($clean, '(?s)<!--.*?-->', '')
    $clean = [regex]::Replace($clean, '`[^`\r\n]*`', '')

    $matches2 = [regex]::Matches($clean, '!?\[[^\]]*\]\(\s*<?([^)\s>]+)>?(?:\s+"[^"]*")?\s*\)')
    foreach ($m in $matches2) {
        $target = $m.Groups[1].Value
        if ($target -match '^(https?:|mailto:|tel:)') { continue }
        $checked++

        $pathPart = $target
        $anchorPart = $null
        $hashIndex = $target.IndexOf('#')
        if ($hashIndex -ge 0) {
            $pathPart = $target.Substring(0, $hashIndex)
            $anchorPart = $target.Substring($hashIndex + 1)
        }

        if ($pathPart -match '^([A-Za-z]:[\\/]|/|\\\\)') {
            $errors.Add("${relFile}: absolute path in link: $target")
            continue
        }

        if ([string]::IsNullOrEmpty($pathPart)) {
            $resolved = $file.FullName
        } else {
            $decoded = [Uri]::UnescapeDataString($pathPart)
            $resolved = [IO.Path]::GetFullPath((Join-Path $file.DirectoryName $decoded))
        }

        if (-not (Test-Path -LiteralPath $resolved)) {
            $errors.Add("${relFile}: broken link -> $target")
            continue
        }

        if ($anchorPart -and $resolved.EndsWith('.md', [StringComparison]::OrdinalIgnoreCase)) {
            if (-not $anchorCache.ContainsKey($resolved)) { $anchorCache[$resolved] = Get-Anchors $resolved }
            if (-not $anchorCache[$resolved].Contains($anchorPart.ToLowerInvariant())) {
                $errors.Add("${relFile}: missing anchor '#$anchorPart' in $target")
            }
        }
    }
}

# ---- mkdocs.yml nav entries
$mkdocs = Join-Path $RepoRoot 'mkdocs.yml'
if (Test-Path -LiteralPath $mkdocs) {
    $docsRoot = Join-Path $RepoRoot 'docs'
    foreach ($line in [IO.File]::ReadAllLines($mkdocs, [Text.Encoding]::UTF8)) {
        if ($line -match '^\s*(?:-\s+)?(?:[^:#]+:\s+)?([A-Za-z0-9_./-]+\.(?:md|mmd))\s*$') {
            $checked++
            $navPath = Join-Path $docsRoot $Matches[1]
            if (-not (Test-Path -LiteralPath $navPath -PathType Leaf)) { $errors.Add("mkdocs.yml: nav file not found -> $($Matches[1])") }
        }
    }
} else {
    $errors.Add('mkdocs.yml not found')
}

Write-Host "Checked $checked link(s) in $($files.Count) Markdown file(s)."
if ($errors.Count -gt 0) {
    Write-Host "Found $($errors.Count) problem(s):" -ForegroundColor Red
    $errors | ForEach-Object { Write-Host "  - $_" -ForegroundColor Red }
    exit 1
}
Write-Host 'All relative links, anchors and nav entries are valid.' -ForegroundColor Green
exit 0
