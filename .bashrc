# Pixi (prepend once, so nested shells don't stack duplicates)
case ":$PATH:" in
    *":$HOME/.pixi/bin:"*) ;;
    *) export PATH="$HOME/.pixi/bin:$PATH" ;;
esac

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Starship
eval "$(starship init bash)"

# Aliases
alias ls='eza --group-directories-first --icons always'
alias dotfiles='git --git-dir="$HOME/.dotfiles" --work-tree="$HOME"'

# Vim mode (indicator comes from show-mode-in-prompt in ~/.inputrc)
set -o vi

# Drop VIM_MODE inherited from fish so starship doesn't show a stale mode
unset VIM_MODE
