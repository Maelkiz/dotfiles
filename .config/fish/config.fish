fish_add_path -P ~/.pixi/bin ~/.local/bin

if not status is-interactive
    return
end

starship init fish | source

set -g fish_greeting

function fish_user_key_bindings
    bind -M insert ctrl-backspace backward-kill-word
    bind -M insert ctrl-delete kill-word
    bind -M insert ctrl-tab accept-autosuggestion
end

function copy
    if isatty stdin
        wl-copy < $argv[1]
    else
        wl-copy
    end
end

alias ls='eza --group-directories-first --icons always'
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME' 

fish_vi_key_bindings

set -g fish_cursor_insert line
set -g fish_cursor_replace underscore
set -g fish_cursor_visual block
set -g fish_cursor_default block

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
