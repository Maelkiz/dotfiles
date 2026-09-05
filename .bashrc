# Pixi
export PATH="$HOME/.pixi/bin:$PATH"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Starship
eval "$(starship init bash)"

# Aliases
alias ls='eza --group-directories-first --icons always'
alias dotfiles='git --git-dir="$HOME/.dotfiles" --work-tree="$HOME"'

# Vim mode
set -o vi

# Export Vim mode environment variable for Starship prompt
update_bash_mode() {
    case "$READLINE_VI_MODE" in
        ""|vi-insertion)
            export VIM_MODE='[INSERT]'
            ;;
        vi-command)
            export VIM_MODE='[NORMAL]'
            ;;
    esac
}

# Update mode before each prompt
PROMPT_COMMAND="update_bash_mode${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
