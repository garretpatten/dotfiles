# PowerShell

Cross-platform PowerShell (7+) profile — the best of
[Chris Titus Tech's powershell-profile][ctt], tuned for this dotfiles repo:

[ctt]: https://github.com/ChrisTitusTech/powershell-profile

- XDG-aware PSReadLine history (`~/.local/state/powershell` on Unix)
- Oh My Posh prompt sharing `config/oh-my-posh/themes` and `DOTFILES_THEME`
- zoxide `z` integration
- Linux/macOS/Windows-aware helpers (`trash`, `uptime`, `flushdns`, `admin`)
- Secret-filtering history (`password|secret|token|apikey|connectionstring`,
  plus leading-space commands, matching the zsh setup)

## Install

Point the profile at the checked-out file (PowerShell reads
`profile.ps1` for all hosts):

- **Linux / macOS**: symlink `config/powershell/profile.ps1` to
  `~/.config/powershell/profile.ps1`
- **Windows**: symlink or copy it to
  `$HOME/Documents/PowerShell/profile.ps1`

Then start `pwsh` — no generator needed.

## What's included

- **Profile management** — `Edit-Profile` (`ep`), `Invoke-Profile`
  (`reload`), `Update-PowerShell`
- **System** — `admin` (`su`), `flushdns`, `sysinfo`, `uptime`,
  `winutil` (Windows)
- **Files & processes** — `touch`, `mkcd`, `nf`, `ff`, `unzip`, `trash`,
  `pkill`, `pgrep` (`k9`), `cpy`, `pst`, `export`
- **Shortcuts** — `docs`, `dtop`, `la`, `ll`
- **Windows fallbacks** — `grep`, `sed`, `which`, `head`, `tail`, `df`
  (defined only on Windows)
- **Git** — `gs`, `ga`, `gc`, `gcom`, `lazyg`, `gpush`, `gpull`, `gcl`, `g`
- **Completions** — native completers for `git`, `npm`, `deno`, `dotnet`
- **PSReadLine** — MenuComplete on Tab, history search on arrows,
  ListView prediction

Run `Show-Help` inside the shell for the same list.
