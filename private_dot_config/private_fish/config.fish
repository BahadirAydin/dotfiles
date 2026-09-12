#############
# VARIABLES #
#############

# All global, never universal. Universal variables live in fish_variables,
# which is gitignored -- anything set there is real configuration that the
# repo cannot see, cannot review and cannot restore on a new machine.

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
set -gx ANDROID_SDK_ROOT $HOME/Android/Sdk

# Starship reports the venv itself; the built-in prefix would double it up.
set -gx VIRTUAL_ENV_DISABLE_PROMPT true
# Empty format silences direnv's per-variable export chatter.
set -gx DIRENV_LOG_FORMAT ""

set -gx CC clang
set -gx CXX clang++

###########
#  PATH   #
###########

# -g -P edits $PATH directly in global scope. The default writes to a
# universal fish_user_paths, which would be re-prepended at every single
# shell start and would not survive into the repo.
#
# System directories are deliberately absent: they are already in $PATH,
# and re-prepending them here only shuffles precedence.
fish_add_path -gP $HOME/.local/bin $HOME/.cargo/bin $GOPATH/bin $JAVA_HOME/bin

###########
# STARTUP #
###########

fish_ssh_agent
fish_vi_key_bindings

starship init fish | source

#############
# FUNCTIONS #
#############

# Note: ls/ll/l/v/vim/lgit/L/gst/ssh-kitty are autoloaded from functions/.
# They are not repeated here -- an alias of the same name would shadow the
# autoload at every startup for no gain.

function quiet
    nohup $argv &>/dev/null &
end

function pdf
    set file (fd --no-ignore -e pdf -e djvu --type f | fzf)
    if test -n "$file"
        nohup zathura "$file" &>/dev/null &
    end
end

function epub
    set file (fd --no-ignore -e epub --type f | fzf)
    if test -n "$file"
        nohup zathura "$file" &>/dev/null &
    end
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

#############
#   HOOKS   #
#############

# rustup's env.fish is sourced by conf.d/rustup.fish, not here.

zoxide init --cmd cd fish | source
direnv hook fish | source

# pnpm
set -gx PNPM_HOME "/home/bahadir/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
