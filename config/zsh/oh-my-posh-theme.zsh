# shellcheck shell=bash
# Oh My Posh — picks JSON from DOTFILES_THEME.
# Resolves themes from ~/.config/oh-my-posh/themes.
# See: docs/themes/README.md

_omp_dir="${XDG_CONFIG_HOME:-$HOME/.config}/oh-my-posh/themes"
[[ -d "$_omp_dir" ]] || return 0

case "${DOTFILES_THEME:-gruvbox}" in
  everforest) _omp_file="${_omp_dir}/everforest-amro.omp.json" ;;
  *) _omp_file="${_omp_dir}/gruvbox-amro.omp.json" ;;
esac

if [[ -r "$_omp_file" ]] && command -v oh-my-posh >/dev/null 2>&1; then
  eval "$(oh-my-posh init zsh --config "$_omp_file")"
fi

unset _omp_dir _omp_file
