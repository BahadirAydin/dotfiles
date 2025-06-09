if status is-interactive
    pyenv virtualenv-init - | source
end

#############
# VARIABLES #
#############

set -U fish_greeting

set -gx EDITOR nvim
set -gx SUDO_EDITOR nvim
set -Ux LS_COLORS 'di=00;33:ow=01;31'

set -Ux XDG_DATA_HOME $HOME/.local/share
set -Ux XDG_CONFIG_HOME $HOME/.config
set -Ux XDG_STATE_HOME $HOME/.local/state
set -Ux XDG_CACHE_HOME $HOME/.cache

set -Ux PYENV_ROOT $HOME/.pyenv
set -Ux GOPATH $XDG_DATA_HOME/go

###########
# STARTUP #
###########

fish_ssh_agent
fish_vi_key_bindings
pyenv init - | source

starship init fish | source
source "$HOME/.cargo/env.fish"

###########
#  PATH   #
###########

fish_add_path -p /bin
fish_add_path -p /usr/bin/ /usr/local/bin /usr/local/sbin /usr/bin /usr/sbin
fish_add_path -p /home/bahadir/.cargo/bin
fish_add_path -p /home/bahadir/.local/bin 
fish_add_path -p $GOPATH/bin
fish_add_path -p $JAVA_HOME/bin
fish_add_path $PYENV_ROOT/bin

###########
# ALIASES #
###########

alias ls "lsd"
alias ll "ls -alF"

alias vim "nvim"
alias lgit "lazygit"
alias gst "git status"

alias ssh-kitty "kitty +kitten ssh"

#############
# FUNCTIONS #
#############

function quiet
    nohup $argv &>/dev/null &
end

function pdf
    set file (fd -e pdf -e djvu --type f | fzf)
    if test -n "$file"
        nohup zathura "$file" &>/dev/null &
    end
end

function epub
    set file (fd -e epub --type f | fzf)
    if test -n "$file"
        nohup zathura "$file" &>/dev/null &
    end
end

function notes
    set notes_dir ~/BahadirAydin/Notes
    cd $notes_dir && nvim .
end

#############
#   HOOKS   #
#############

zoxide init --cmd cd fish | source
direnv hook fish | source
