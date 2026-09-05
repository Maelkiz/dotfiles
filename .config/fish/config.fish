set -gx PATH "/home/karl/.pixi/bin" $PATH

if not status is-interactive
    return
end

# Starship
source (/usr/local/bin/starship init fish --print-full-init | psub)

function fish_greeting
    #fastfetch
end

function fish_user_key_bindings
    bind -M insert ctrl-backspace backward-kill-word
    bind -M insert ctrl-delete kill-word
    bind -M insert ctrl-tab accept-autosuggestion
end

alias ls='eza --group-directories-first --icons always'
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME' 

# Vim Mode
fish_vi_key_bindings

# Vim-style cursor
set -g fish_cursor_insert line
set -g fish_cursor_replace underscore
set -g fish_cursor_visual block
set -g fish_cursor_default block

# Export Vim Mode environment variable for Starship prompt
function update_fish_mode --on-variable fish_bind_mode
    switch $fish_bind_mode
        case default
            set -gx VIM_MODE [NORMAL]
        case insert
            set -gx VIM_MODE [INSERT]
        case visual
            set -gx VIM_MODE [VISUAL]
    end
end

update_fish_mode
