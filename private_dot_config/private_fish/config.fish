#############
# VARIABLES #
#############

# All global, never universal. Universal variables live in fish_variables

set -g fish_greeting

set -gx EDITOR nvim
set -gx SUDO_EDITOR nvim
set -gx LS_COLORS 'di=00;33:ow=01;31'

set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_STATE_HOME $HOME/.local/state
set -gx XDG_CACHE_HOME $HOME/.cache

set -gx GOPATH $XDG_DATA_HOME/go
# The archlinux-java symlink rather than a pinned version, so a JDK bump
# does not silently leave JAVA_HOME pointing at an uninstalled tree.
set -gx JAVA_HOME /usr/lib/jvm/default
set -gx PNPM_HOME $XDG_DATA_HOME/pnpm

# Starship reports the venv itself; the built-in prefix would double it up.
set -gx VIRTUAL_ENV_DISABLE_PROMPT true
# Empty format silences direnv's per-variable export chatter.
set -gx DIRENV_LOG_FORMAT ""

set -gx CC clang
set -gx CXX clang++

set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -gx MANROFFOPT -c

set -gx RIPGREP_CONFIG_PATH $XDG_CONFIG_HOME/ripgrep/config

set -gx FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --height=90% --preview-window=wrap --marker="*"
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
--color=selected-bg:#45475a
--color=border:#6c7086,label:#cdd6f4'
set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --exclude .git'
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -gx FZF_ALT_C_COMMAND 'fd --type d --hidden --exclude .git'

set -gx LESSHISTFILE $XDG_STATE_HOME/less_history
set -gx PYTHON_HISTORY $XDG_STATE_HOME/python_history
set -gx NODE_REPL_HISTORY $XDG_STATE_HOME/node_repl_history
set -gx SQLITE_HISTORY $XDG_STATE_HOME/sqlite_history
set -gx PSQL_HISTORY $XDG_STATE_HOME/psql_history

###########
#  PATH   #
###########

# System directories are deliberately absent: they are already in $PATH,
# and re-prepending them here only shuffles precedence.
fish_add_path -gP $HOME/.local/bin $HOME/.cargo/bin $GOPATH/bin $JAVA_HOME/bin $PNPM_HOME

###########
# STARTUP #
###########

if status is-interactive
    fish_config theme choose catppuccin-mocha
    fish_ssh_agent
    set -g fish_key_bindings fish_vi_key_bindings

    fzf --fish | source
    starship init fish | source
    zoxide init --cmd cd fish | source
    direnv hook fish | source
end

#############
# FUNCTIONS #
#############

function quiet
    nohup $argv &>/dev/null &
end

function _pick_and_open
    set -l args
    for ext in $argv
        set -a args -e $ext
    end
    set -l file (fd --no-ignore $args --type f | fzf)
    if test -n "$file"
        xdg-open $file &>/dev/null &
        disown
    end
end

function pdf
    _pick_and_open pdf djvu
end

function epub
    _pick_and_open epub
end

function notes
    set notes_dir ~/BahadirAydin/Notes
    cd $notes_dir && nvim
end

function daily
    # Get current date components
    set year (date +%Y)
    set month (date +%m)
    set date_str (date +%Y-%m-%d)

    # Define the base path
    set base_path ~/BahadirAydin/Notes/Günlük

    # Create the directory structure
    set target_dir $base_path/$year/$month
    set target_file $target_dir/$date_str.md

    # Create directories if they don't exist
    mkdir -p $target_dir

    # Open the file with nvim
    nvim $target_file
end

