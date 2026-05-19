#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT_DIR"

# Symlink repo config/<app>/ → ~/.config/<app>/ (real dirs renamed to *.dotfiles-bak-<timestamp>)
link_xdg_config_dirs() {
  shopt -s nullglob
  local xdg config_dir dir name src_abs target bak
  local failed=0
  xdg="${XDG_CONFIG_HOME:-$HOME/.config}"
  mkdir -p "$xdg"

  config_dir="$ROOT_DIR/config"
  for dir in "$config_dir/"*/ ; do
    [[ -d "$dir" ]] || continue
    name="$(basename "${dir%/}")"
    src_abs="$(cd "${dir%/}" && pwd)"
    target="${xdg}/${name}"

    if [[ -e "$target" || -L "$target" ]] && [[ ! -L "$target" ]]; then
      bak="${target}.dotfiles-bak-$(date +%Y%m%d%H%M%S)"
      printf '%s exists; moving to %s\n' "$target" "$bak" >&2
      mv "$target" "$bak" || failed=1
    fi

    if [[ "$(readlink "$target" 2>/dev/null)" == "$src_abs" ]]; then
      printf '%s already -> %s\n' "$target" "$src_abs"
      continue
    fi

    ln -sfn "$src_abs" "$target"
    printf 'Linked %s -> %s\n' "$target" "$src_abs"
  done
  [[ "$failed" -eq 0 ]]
}

case "${1:-}" in
  --link-xdg-config | link-xdg | --link-xdg | link-xdg-config)
    link_xdg_config_dirs
    exit 0
    ;;
esac

if [[ ! -d config ]] || [[ ! -d home ]]; then
  printf 'setup.sh: expected config/ and home/ in %s\n' "$(pwd)" >&2
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
