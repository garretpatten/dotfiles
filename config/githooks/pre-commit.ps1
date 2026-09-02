#Requires -Version 7
# Pre-commit hook: scan staged changes with betterleaks for verified secrets.
# Installs betterleaks via winget when missing. Passes through gracefully
# when winget is unavailable or betterleaks encounters an execution error.

function Test-Command([string]$Name) {
  $null -ne (Get-Command $Name -ErrorAction SilentlyContinue)
}

if (-not (Test-Command betterleaks)) {
  if (-not (Test-Command winget)) {
    Write-Host "Warning: betterleaks is not installed and winget was not found. Skipping scan."
    exit 0
  }

  Write-Host "Pre-commit hook: installing betterleaks via winget..."
  winget install --id Betterleaks.Betterleaks --silent --accept-package-agreements --accept-source-agreements
  if ($LASTEXITCODE -ne 0) {
    Write-Host "Warning: winget installation of betterleaks did not work as intended."
    exit 0
  }

  # Refresh PATH from environment variables in case winget added betterleaks.
  $env:Path = [Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [Environment]::GetEnvironmentVariable("Path", "User")
  if (-not (Test-Command betterleaks)) {
    Write-Host "Warning: betterleaks was installed but could not be found in PATH. Skipping scan."
    exit 0
  }
}

$reportFile = [System.IO.Path]::GetTempFileName()
$stderrFile = [System.IO.Path]::GetTempFileName()

try {
  betterleaks git . `
    --pre-commit `
    --staged `
    --validation `
    --validation-status valid `
    --report-format json `
    --report-path $reportFile 2>$stderrFile
  $exitCode = $LASTEXITCODE

  if ($exitCode -eq 0) {
    Write-Host "Pre-commit hook: no verified secrets detected."
    exit 0
  }

  if ((Test-Path $reportFile) -and ((Get-Item $reportFile).Length -gt 0)) {
    Write-Host "Pre-commit hook failed: a verified secret was detected."
    Write-Host "The secret must be removed before the commit can be made."
    Write-Host "Affected file(s):"

    try {
      $data = Get-Content $reportFile | ConvertFrom-Json
      $paths = [System.Collections.Generic.HashSet[string]]::new()
      foreach ($item in $data) {
        $path = $item.Attributes.path
        if (-not $path) { $path = $item.Fragment.FilePath }
        if ($path) { $paths.Add($path) | Out-Null }
      }
      $paths | Sort-Object | Get-Unique
    } catch {
      Write-Host "Could not parse betterleaks report; install jq or python3 to see exact file path(s)."
    }

    exit 1
  }

  Write-Host "Pre-commit hook: betterleaks did not run correctly."
  if ((Test-Path $stderrFile) -and ((Get-Item $stderrFile).Length -gt 0)) {
    Write-Host "Error output:"
    Get-Content $stderrFile
  }
  exit 0
} finally {
  Remove-Item $reportFile -ErrorAction SilentlyContinue
  Remove-Item $stderrFile -ErrorAction SilentlyContinue
}
