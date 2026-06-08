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

if ($html -notmatch 'href="/assets/css/portfolio\.css\?v=fullsite-20260608"') {
  throw 'The portfolio stylesheet needs a cache-busting version for the full-site preview release.'
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

Write-Host "Portfolio preview checks passed: full-page source $($fullPageDimensions.Width)x$($fullPageDimensions.Height), overview $($previewDimensions.Width)x$($previewDimensions.Height); three live iframes preserved."
