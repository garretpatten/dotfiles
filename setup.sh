#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [[ ! -d config ]] || [[ ! -d home ]]; then
  echo "setup.sh: expected config/ and home/ in $(pwd)" >&2
  exit 1
fi

if [[ -f .gitmodules ]]; then
  if git submodule status 2>/dev/null | grep -q '^-'; then
    git submodule update --init --recursive
  else
    git submodule update --recursive
  fi
fi

# Two-pass headless Neovim: Lazy installs plugins first; TSUpdate runs after
# runtime paths are stable (avoids races on first bootstrap).
if command -v nvim >/dev/null 2>&1; then
  export XDG_CONFIG_HOME="$PWD/config"
  nvim --headless "+Lazy! sync" +qa
  nvim --headless "+TSUpdate" +qa
fi
