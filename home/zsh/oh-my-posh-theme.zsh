# shellcheck shell=bash
# Oh My Posh — picks JSON from DOTFILES_THEME (theme-env.sh).
# Resolves themes from $DOTFILES/config/… first, then ~/.config/oh-my-posh/themes.
# See: docs/themes/README.md

_omp_dir=""
if [[ -n "${DOTFILES:-}" && -d "${DOTFILES}/config/oh-my-posh/themes" ]]; then
  _omp_dir="${DOTFILES}/config/oh-my-posh/themes"
elif [[ -d "${HOME}/.config/oh-my-posh/themes" ]]; then
  _omp_dir="${HOME}/.config/oh-my-posh/themes"
else
  return 0
fi

case "${DOTFILES_THEME:-gruvbox}" in
  everforest) _omp_file="${_omp_dir}/everforest-amro.omp.json" ;;
  gruvbox) _omp_file="${_omp_dir}/gruvbox-amro.omp.json" ;;
  *) _omp_file="${_omp_dir}/gruvbox-amro.omp.json" ;;
esac

if [[ -r "$_omp_file" ]] && command -v oh-my-posh >/dev/null 2>&1; then
  eval "$(oh-my-posh init zsh --config "$_omp_file")"
fi

unset _omp_dir _omp_file
