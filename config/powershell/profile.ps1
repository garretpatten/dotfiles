# Cross-platform PowerShell profile (PowerShell 7+; most of it works on 5.1).
# Inspired by Chris Titus Tech's powershell-profile, trimmed for dotfiles:
# no self-update plumbing (git manages this repo), XDG-aware history,
# Oh My Posh themes shared with the zsh setup.

### Interactive / platform / admin detection ###
$isInteractiveShell = try {
    $Host.Name -eq 'ConsoleHost' -and -not [Console]::IsInputRedirected -and -not [Console]::IsOutputRedirected
} catch {
    $false
}

# $IsWindows only exists in PowerShell Core; 5.1 is Windows-only by definition.
$onWindows = if ($PSVersionTable.PSEdition -eq 'Core') { [bool]$IsWindows } else { $true }
$onMacOS = if ($PSVersionTable.PSEdition -eq 'Core') { [bool]$IsMacOS } else { $false }

$isAdmin = try {
    if ($onWindows) {
        ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
            [Security.Principal.WindowsBuiltInRole]::Administrator
        )
    } else {
        (id -u 2>$null) -eq '0'
    }
} catch {
    $false
}

### TLS 1.2 for older .NET stacks (harmless elsewhere) ###
try {
    [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
} catch {
    Write-Verbose "Unable to enable TLS 1.2: $_"
}

### Optional modules ###
if ($isInteractiveShell) {
    if (Get-Module -ListAvailable -Name Terminal-Icons) {
        Import-Module Terminal-Icons -ErrorAction SilentlyContinue
    }

    # Chocolatey needs its profile for shimmed commands (Windows only).
    $chocoProfile = if ($env:ChocolateyInstall) {
        Join-Path $env:ChocolateyInstall 'helpers\chocolateyProfile.psm1'
    }
    if ($onWindows -and $chocoProfile -and (Test-Path $chocoProfile -PathType Leaf)) {
        Import-Module $chocoProfile -ErrorAction SilentlyContinue
    }
}

### PSReadLine ###
function Initialize-PSReadLine {
    if (-not $isInteractiveShell -or -not (Get-Module -ListAvailable -Name PSReadLine)) {
        return
    }

    # Keep history under XDG state when possible (matches .zshrc conventions).
    try {
        if (-not $onWindows) {
            $stateHome = $env:XDG_STATE_HOME
            if ([string]::IsNullOrWhiteSpace($stateHome)) {
                $stateHome = Join-Path $HOME '.local/state'
            }
            $historyDir = Join-Path $stateHome 'powershell'
            New-Item -ItemType Directory -Path $historyDir -Force | Out-Null
            Set-PSReadLineOption -HistorySavePath (Join-Path $historyDir 'history_consolehost.txt')
        }
        Set-PSReadLineOption -MaximumHistoryCount 10000
    } catch {
        Write-Verbose "History options unavailable: $_"
    }

    $options = @{
        EditMode                      = 'Windows'
        HistoryNoDuplicates           = $true
        HistorySearchCursorMovesToEnd = $true
        PredictionViewStyle           = 'ListView'
        BellStyle                     = 'None'
    }
    try {
        Set-PSReadLineOption @options
    } catch {
        Write-Verbose "PSReadLine options unavailable: $_"
    }

    # HistoryAndPlugin fails when no predictor plugin is registered; fall back to History.
    if ($PSVersionTable.PSEdition -eq 'Core') {
        try {
            Set-PSReadLineOption -PredictionSource HistoryAndPlugin
        } catch {
            try {
                Set-PSReadLineOption -PredictionSource History
            } catch {
                Write-Verbose "Prediction unavailable: $_"
            }
        }
    }

    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
    Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
    Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
    Set-PSReadLineKeyHandler -Chord 'Ctrl+w' -Function BackwardDeleteWord
    Set-PSReadLineKeyHandler -Chord 'Alt+d' -Function DeleteWord
    Set-PSReadLineKeyHandler -Chord 'Ctrl+z' -Function Undo
    Set-PSReadLineKeyHandler -Chord 'Ctrl+y' -Function Redo

    # Never remember anything that looks like a secret (or uses the leading-space trick shared with zsh).
    Set-PSReadLineOption -AddToHistoryHandler {
        param([string]$line)
        $line -notmatch '(?i)(password|secret|token|apikey|connectionstring)' -and $line -notmatch '^\s'
    }
}

### Oh My Posh (shares themes/DOTFILES_THEME with zsh) ###
function Initialize-PromptTool {
    if (-not $isInteractiveShell) {
        return
    }

    if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
        $theme = $env:POSH_THEME
        if ([string]::IsNullOrWhiteSpace($theme)) {
            $dotfilesTheme = if ($env:DOTFILES_THEME) { $env:DOTFILES_THEME } else { 'gruvbox' }
            $xdgConfig = if ($env:XDG_CONFIG_HOME) { $env:XDG_CONFIG_HOME } else { Join-Path $HOME '.config' }
            $theme = Join-Path $xdgConfig "oh-my-posh/themes/$dotfilesTheme-amro.omp.json"
        }

        if (Test-Path $theme -PathType Leaf) {
            oh-my-posh init pwsh --config $theme | Out-String | Invoke-Expression
        } else {
            Write-Warning "Oh My Posh theme not found: $theme"
        }
    } else {
        Write-Verbose 'oh-my-posh is not installed'
    }

    if (Get-Command zoxide -ErrorAction SilentlyContinue) {
        zoxide init --cmd z powershell | Out-String | Invoke-Expression
    } else {
        Write-Verbose 'zoxide is not installed'
    }
}

### Editor + window title ###
$editorCandidates = 'nvim', 'vim', 'vi', 'code', 'codium', 'notepad++', 'sublime_text'
$defaultEditor = if ($onWindows) { 'notepad' } else { 'nano' }
$EDITOR = $env:EDITOR
if ([string]::IsNullOrWhiteSpace($EDITOR)) {
    foreach ($candidate in ($editorCandidates + @($defaultEditor))) {
        if (Get-Command $candidate -ErrorAction SilentlyContinue) {
            $EDITOR = $candidate
            break
        }
    }
}
if ($EDITOR) {
    Set-Alias -Name vim -Value $EDITOR -Force
}

if ($isInteractiveShell) {
    try {
        $adminSuffix = if ($isAdmin) { ' [ADMIN]' } else { '' }
        $Host.UI.RawUI.WindowTitle = "pwsh $($PSVersionTable.PSVersion)$adminSuffix"
    } catch {
        Write-Verbose "Unable to set console title: $_"
    }
}

### Locations ###
function docs {
    if ($onWindows) {
        Set-Location ([Environment]::GetFolderPath('MyDocuments'))
    } elseif (Get-Command xdg-user-dir -ErrorAction SilentlyContinue) {
        Set-Location (xdg-user-dir DOCUMENTS)
    } else {
        Set-Location (Join-Path $HOME 'Documents')
    }
}

function dtop {
    if ($onWindows) {
        Set-Location ([Environment]::GetFolderPath('Desktop'))
    } elseif (Get-Command xdg-user-dir -ErrorAction SilentlyContinue) {
        Set-Location (xdg-user-dir DESKTOP)
    } else {
        Set-Location (Join-Path $HOME 'Desktop')
    }
}

### File helpers ###
function touch {
    param([Parameter(Mandatory)][string]$File)

    if (Test-Path -LiteralPath $File) {
        (Get-Item -LiteralPath $File).LastWriteTime = Get-Date
    } else {
        New-Item -Path $File -ItemType File -Force | Out-Null
    }
}

function mkcd {
    param([Parameter(Mandatory)][string]$Path)
    New-Item -Path $Path -ItemType Directory -Force | Out-Null
    Set-Location -LiteralPath $Path
}

function nf {
    param([Parameter(Mandatory)][string]$Name)
    New-Item -ItemType File -Path . -Name $Name -Force | Out-Null
}

function ff {
    param([Parameter(Mandatory)][string]$Name)
    Get-ChildItem -Recurse -Filter "*$Name*" -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName
}

function unzip {
    param([Parameter(Mandatory)][string]$File)

    if (-not (Test-Path -LiteralPath $File -PathType Leaf)) {
        Write-Error "File not found: $File"
        return
    }
    Expand-Archive -Path $File -DestinationPath (Get-Location) -Force
}

function trash {
    param([Parameter(Mandatory)][string]$Path)

    $resolved = Resolve-Path -LiteralPath $Path -ErrorAction SilentlyContinue
    if (-not $resolved) {
        Write-Error "Item not found: $Path"
        return
    }

    if ($onWindows) {
        $item = Get-Item -LiteralPath $resolved.ProviderPath
        $parent = if ($item.PSIsContainer) { Split-Path $item.FullName -Parent } else { $item.DirectoryName }
        if ([string]::IsNullOrWhiteSpace($parent)) {
            Write-Error "Cannot recycle root path: $($item.FullName)"
            return
        }
        $shell = New-Object -ComObject 'Shell.Application'
        $shellItem = $shell.NameSpace($parent).ParseName($item.Name)
        if ($shellItem) {
            $shellItem.InvokeVerb('delete')
        } else {
            Write-Error "Could not move item to Recycle Bin: $($item.FullName)"
        }
    } elseif ($onMacOS) {
        Move-Item -LiteralPath $resolved.Path -Destination (Join-Path $HOME '.Trash') -Force
    } elseif (Get-Command gio -ErrorAction SilentlyContinue) {
        gio trash @($resolved.Path)
    } else {
        Write-Error 'trash needs ~/.Trash (macOS) or gio (Linux); use Remove-Item.'
    }
}

if ($onWindows) {
    # Native equivalents exist on Unix; only define there where PowerShell is the fallback.
    function grep {
        param([Parameter(Mandatory)][string]$Pattern, [string]$Path)
        if ($Path) {
            Get-ChildItem -Path $Path -Recurse -File -ErrorAction SilentlyContinue | Select-String -Pattern $Pattern
        } else {
            $input | Select-String -Pattern $Pattern
        }
    }
    function sed {
        param([Parameter(Mandatory)][string]$File, [Parameter(Mandatory)][string]$Find, [Parameter(Mandatory)][string]$Replace)
        (Get-Content -LiteralPath $File).Replace($Find, $Replace) | Set-Content -LiteralPath $File
    }
    function which {
        param([Parameter(Mandatory)][string]$Name)
        Get-Command -Name $Name -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Definition
    }
    function head {
        param([Parameter(Mandatory)][string]$Path, [int]$n = 10)
        Get-Content -LiteralPath $Path -Head $n
    }
    function tail {
        param([Parameter(Mandatory)][string]$Path, [int]$n = 10, [switch]$f)
        Get-Content -LiteralPath $Path -Tail $n -Wait:$f
    }
    function df { Get-Volume | Format-Table -AutoSize }
}

function export {
    param([Parameter(Mandatory)][string]$Name, [Parameter(Mandatory)][string]$Value)
    Set-Item -Path "env:$Name" -Value $Value -Force
}

### Clipboard ###
function cpy { Set-Clipboard ($args -join ' ') }
function pst { Get-Clipboard }

### System ###
function uptime {
    if ($onWindows) {
        $boot = (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime
        (Get-Date) - $boot | Select-Object Days, Hours, Minutes, Seconds
    } else {
        $bootEpoch = if ($onMacOS) {
            [regex]::Match((sysctl -n kern.boottime), 'sec = (\d+)').Groups[1].Value
        } else {
            (Get-Content /proc/stat | Where-Object { $_ -like 'btime *' }) -replace 'btime ', ''
        }

        $bootSeconds = 0L
        if (-not [long]::TryParse([string]$bootEpoch, [ref]$bootSeconds)) {
            Write-Error 'Unable to determine boot time.'
            return
        }
        (Get-Date) - [datetimeoffset]::FromUnixTimeSeconds($bootSeconds).DateTime
    }
}

function flushdns {
    if ($onWindows) {
        Clear-DnsClientCache
        Write-Host 'DNS has been flushed'
    } elseif ($onMacOS) {
        dscacheutil -flushcache; killall -HUP mDNSResponder
        Write-Host 'DNS has been flushed'
    } elseif (Get-Command resolvectl -ErrorAction SilentlyContinue) {
        resolvectl flush-caches
        Write-Host 'DNS has been flushed'
    } else {
        Write-Error 'No supported DNS flush command found.'
    }
}

function sysinfo { Get-ComputerInfo }

### Processes ###
function pkill {
    param([Parameter(Mandatory)][string]$Name)
    Get-Process -Name $Name -ErrorAction SilentlyContinue | Stop-Process -Force
}

function pgrep {
    param([Parameter(Mandatory)][string]$Name)
    Get-Process -Name $Name -ErrorAction SilentlyContinue
}

function k9 { param([Parameter(Mandatory)][string]$Name) pkill $Name }

### Listing ###
function la { Get-ChildItem | Format-Table -AutoSize }
function ll { Get-ChildItem -Force | Format-Table -AutoSize }

### Elevation (su-like) ###
function admin {
    if ($onWindows) {
        $cwd = (Get-Location).ProviderPath
        $shellArgs = if ($args.Count -gt 0) { @('-NoExit', '-Command', ($args -join ' ')) } else { @('-NoExit') }
        if (Get-Command wt -ErrorAction SilentlyContinue) {
            Start-Process wt -Verb RunAs -ArgumentList (@('-d', $cwd, 'pwsh') + $shellArgs)
        } else {
            Start-Process pwsh -Verb RunAs -WorkingDirectory $cwd -ArgumentList $shellArgs
        }
    } else {
        sudo pwsh -NoExit -NoLogo
    }
}
Set-Alias -Name su -Value admin -Force

### Windows-only extras (the famous ones from Chris Titus Tech) ###
function winutil {
    if (-not $onWindows) {
        Write-Error 'winutil is Windows-only.'
        return
    }
    & ([ScriptBlock]::Create((Invoke-RestMethod -Uri 'https://christitus.com/win'))) @args
}

### Git shortcuts ###
function gs { git status }
function ga { git add . }
function gpush { git push @args }
function gpull { git pull @args }
function gcl { git clone @args }
function gc { git commit -m ($args -join ' ') }
function gcom {
    git add .
    git commit -m ($args -join ' ')
}
function lazyg {
    git add .
    git commit -m ($args -join ' ')
    git push
}

function g {
    if (Get-Command __zoxide_z -ErrorAction SilentlyContinue) {
        __zoxide_z github
    } elseif (Test-Path (Join-Path $HOME 'github')) {
        Set-Location (Join-Path $HOME 'github')
    }
}

### Profile management ###
function Edit-Profile {
    & $EDITOR $PROFILE.CurrentUserAllHosts
}
Set-Alias -Name ep -Value Edit-Profile -Force

function Invoke-Profile {
    . $PROFILE.CurrentUserAllHosts
}
Set-Alias -Name reload -Value Invoke-Profile -Force

function Update-PowerShell {
    try {
        $release = Invoke-RestMethod -Uri 'https://api.github.com/repos/PowerShell/PowerShell/releases/latest' -ErrorAction Stop
        $latest = [version]($release.tag_name -replace '^v', '')
        $current = [version]$PSVersionTable.PSVersion

        if ($current -ge $latest) {
            Write-Host "PowerShell $current is up to date." -ForegroundColor Green
            return
        }

        if ($onWindows) {
            if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
                Write-Warning 'winget is required to update PowerShell automatically.'
                return
            }
            winget upgrade --id Microsoft.PowerShell --exact --accept-source-agreements --accept-package-agreements
            if ($LASTEXITCODE -ne 0) {
                Write-Error "winget failed to update PowerShell. Exit code: $LASTEXITCODE"
                return
            }
        } elseif ($onMacOS) {
            brew upgrade --cask powershell
        } else {
            Write-Warning 'Update PowerShell via your package manager (e.g. dotnet or the distro repo).'
            return
        }
        Write-Host 'PowerShell has been updated. Restart your shell to use the new version.' -ForegroundColor Magenta
    } catch {
        Write-Error "Failed to check for PowerShell updates: $_"
    }
}

### Completions ###
function Register-CustomCompletion {
    if (-not $isInteractiveShell) {
        return
    }

    $completionMap = @{
        git  = @('status', 'add', 'commit', 'push', 'pull', 'clone', 'checkout')
        npm  = @('install', 'start', 'run', 'test', 'build')
        deno = @('run', 'compile', 'bundle', 'test', 'lint', 'fmt', 'cache', 'info', 'doc', 'upgrade')
    }

    Register-ArgumentCompleter -Native -CommandName git, npm, deno -ScriptBlock {
        param($wordToComplete, $commandAst, $cursorPosition)
        $null = $cursorPosition
        $map = $completionMap
        $command = $commandAst.CommandElements[0].Value
        if ($map.ContainsKey($command)) {
            $map[$command] |
                Where-Object { $_ -like "$wordToComplete*" } |
                ForEach-Object { [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_) }
        }
    }.GetNewClosure()

    if (Get-Command dotnet -ErrorAction SilentlyContinue) {
        Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
            param($wordToComplete, $commandAst, $cursorPosition)
            $null = $wordToComplete
            dotnet complete --position $cursorPosition $commandAst.ToString() |
                ForEach-Object { [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_) }
        }
    }
}

### Help ###
function Show-Help {
    @'
PowerShell Profile Help
=======================

Profile:
  Edit-Profile (ep)  Edit ~$PROFILE.CurrentUserAllHosts.
  Invoke-Profile     Reload this profile (alias: reload).
  Update-PowerShell  Update PowerShell (winget / Homebrew).

System:
  admin (su)         Open an elevated shell (wt/desktop-aware on Windows).
  flushdns, sysinfo, uptime, winutil (Windows)

Files & processes:
  touch, mkcd, nf, ff, unzip, trash
  pkill, pgrep (k9), cpy, pst, la, ll
  export <name> <value>
  Windows-only: grep, sed, which, head, tail, df

Shortcuts:
  docs / dtop        Go to Documents / Desktop.
  g                  Jump to ~/github (zoxide-aware).

Git:
  gs / ga / gc <msg>  status / add . / commit -m
  gcom <msg>          add . + commit
  lazyg <msg>         add . + commit + push
  gpush / gpull / gcl push / pull / clone
'@ | Write-Host
}

Initialize-PSReadLine
Register-CustomCompletion
Initialize-PromptTool

if ($isInteractiveShell) {
    Write-Host "Use 'Show-Help' to display help" -ForegroundColor Yellow
}
