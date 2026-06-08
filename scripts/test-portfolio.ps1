$ErrorActionPreference = 'Stop'

$projectRoot = Split-Path -Parent $PSScriptRoot
$htmlPath = Join-Path $projectRoot 'index.html'
$cssPath = Join-Path $projectRoot 'assets\css\portfolio.css'
$previewPath = Join-Path $projectRoot 'assets\media\csuf-project-rebound-preview.jpg'
$fullPagePath = Join-Path $projectRoot 'assets\media\csuf-project-rebound-full-page.jpg'

$html = Get-Content -LiteralPath $htmlPath -Raw
$css = Get-Content -LiteralPath $cssPath -Raw
Add-Type -AssemblyName System.Drawing

function Get-JpegDimensions {
  param([Parameter(Mandatory)][string]$Path)

  $bytes = [System.IO.File]::ReadAllBytes($Path)
  if ($bytes.Length -lt 24 -or $bytes[0] -ne 0xFF -or $bytes[1] -ne 0xD8) {
    throw "$Path uses a .jpg extension but is not encoded as JPEG."
  }

  $image = [System.Drawing.Image]::FromFile($Path)
  try {
    return [pscustomobject]@{
      Width = $image.Width
      Height = $image.Height
    }
  } finally {
    $image.Dispose()
  }
}

$previewDimensions = Get-JpegDimensions -Path $previewPath
$fullPageDimensions = Get-JpegDimensions -Path $fullPagePath

$expectedFrames = @(
  'https://colleges.claremont.edu/justice-education',
  'https://safehavenforempowerment.org',
  'https://mableshome.com'
)

$iframeSources = [regex]::Matches($html, '<iframe[^>]+data-src="([^"]+)"', 'IgnoreCase') |
  ForEach-Object { $_.Groups[1].Value }

if ($iframeSources.Count -ne 3) {
  throw "Expected exactly three live iframe previews; found $($iframeSources.Count)."
}

foreach ($source in $expectedFrames) {
  if ($iframeSources -notcontains $source) {
    throw "Working iframe preview changed or is missing: $source"
  }
}

if ($html -match '<iframe[^>]+fullerton') {
  throw 'The CSU Fullerton site must use the static preview, not a blocked iframe.'
}

if ($html -notmatch 'class="project-static-preview"[\s\S]+csuf-project-rebound-preview\.jpg') {
  throw 'The CSU Fullerton static preview is missing.'
}

if ($html -notmatch 'href="/assets/css/portfolio\.css\?v=contrast-20260608-3"') {
  throw 'The portfolio stylesheet needs a cache-busting version for the contrast release.'
}

if ($fullPageDimensions.Height -lt 2500 -or $fullPageDimensions.Height -le $fullPageDimensions.Width) {
  throw "Rebound source must be a full-page portrait capture; found $($fullPageDimensions.Width)x$($fullPageDimensions.Height)."
}

if ($previewDimensions.Width -le $previewDimensions.Height) {
  throw "Rebound card preview must present the complete capture in a landscape overview; found $($previewDimensions.Width)x$($previewDimensions.Height)."
}

$previewRule = [regex]::Match(
  $css,
  '\.project-static-preview img\s*\{(?<body>[^}]+)\}',
  'IgnoreCase'
)

if (-not $previewRule.Success -or $previewRule.Groups['body'].Value -notmatch 'object-fit:\s*contain') {
  throw 'Rebound preview must use object-fit: contain so the full capture is visible.'
}

if ($css -notmatch '(?s)body\s*\{[^}]*color:\s*var\(--text\)') {
  throw 'Body text must follow the active theme text variable.'
}

if ($css -notmatch '(?s)\.project-card\s*\{[^}]*--text:\s*#f4ebd6[^}]*--text-mute:') {
  throw 'Dark project cards must keep their own readable light text variables in every theme.'
}

if ($css -notmatch '(?s)footer\s*\{[^}]*--text:\s*#f4ebd6[^}]*--text-mute:') {
  throw 'The dark footer must keep its own readable light text variables in every theme.'
}

if ($css -notmatch '(?s)body\[data-theme="editorial"\]\s*\{[^}]*--ui-accent:\s*#[0-9a-fA-F]{6}') {
  throw 'Editorial theme needs a dark readable accent for labels on light surfaces.'
}

if ($css -notmatch '(?s)body\[data-theme="editorial"\]\s+\.final-cta h2 \.glow\s*\{[^}]*linear-gradient') {
  throw 'Editorial CTA gradient must use colors that remain visible on the light background.'
}

if ($css -notmatch '(?s)body\[data-theme="editorial"\]\s+\.project-card\s*\{[^}]*background:\s*#[0-9a-fA-F]{6}') {
  throw 'Editorial project cards need an opaque dark background behind their light text.'
}

if ($css -notmatch '(?s)\.theme-switch\s*\{[^}]*display:\s*grid[^}]*grid-template-columns:\s*repeat\(2,\s*minmax\(0,\s*1fr\)\)') {
  throw 'Mobile theme controls must show all four themes in a two-column grid.'
}

Write-Host "Portfolio preview checks passed: full-page source $($fullPageDimensions.Width)x$($fullPageDimensions.Height), overview $($previewDimensions.Width)x$($previewDimensions.Height); three live iframes preserved."
