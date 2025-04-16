### PATH ###
path+=($HOME/.local/bin)
path+=($HOME/.spicetify)
### XDG ###
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_SCREENSHOTS_DIR="${HOME}/Pictures/Screenshots"
### SYSTEM ###
export CMAKE_GENERATOR="Ninja"
export EDITOR="vim"
export VISUAL="vim"
export MANPAGER="sh -c 'col -bx | bat --theme=default -l man -p'"
export MANROFFOPT="-c"
export APPIMAGE_EXTRACT_AND_RUN=1
export MOZ_ENABLE_WAYLAND=1
export TERM="xterm-256color"
export LESSHISTFILE="/dev/null"
### ZSH SPECIFIC ###
export ZDOTDIR="${HOME}/.config/zsh"
export HISTFILE="${XDG_CACHE_HOME}/zsh/history"
export HISTSIZE=10000000
export SAVEHIST=$HISTSIZE
export ZSH_SESSION_FILE="${XDG_CACHE_HOME}/zsh/zsh_sessions"
export ZSH_COMPDUMP="${XDG_CACHE_HOME}/zcompdump"
### PROGRAMS ###
export ALACRITTY_CONFIG_FILE="${XDG_CONFIG_HOME}/alacritty/alacritty.toml"
export TINYTASK_CONFIG_FILE="${XDG_CONFIG_HOME}/tinytask/config.toml"
export TEXMFVAR="${XDG_CACHE_HOME}/texlive/texmf-var"
export PYTHONPYCACHEPREFIX="${XDG_CACHE_HOME}/pythonvirt"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export GOPATH="${XDG_DATA_HOME}/go"
export GRADLE_USER_HOME="${XDG_DATA_HOME}/gradle"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="${XDG_DATA_HOME}/java"
export PUB_CACHE="${XDG_CACHE_HOME}/pub_cache"
export PIPX_BIN_DIR="${HOME}/.local/pipx/bin"
export WGETRC="${XDG_CONFIG_HOME}/wgetrc"
export RANGER_LOAD_DEFAULT_RC=false
export MYVIMRC="${XDG_CONFIG_HOME}/vim/vimrc"
### GUM ###
export GUM_CHOOSE_SHOW_HELP=false
export GUM_WRITE_SHOW_HELP=false
export GUM_INPUT_SHOW_HELP=false
export GUM_CONFIRM_SHOW_HELP=false
export GUM_FILE_SHOW_HELP=false
export GUM_CONFIRM_PROMPT_FOREGROUND="#87D7FF"
export GUM_CONFIRM_SELECTED_BACKGROUND="#81AD79"
export GUM_CHOOSE_HEADER_FOREGROUND="#87D7FF"
export GUM_WRITE_CURSOR_FOREGROUND="#D8DEE9"
export GUM_SPIN_SPINNER="minidot"
### FZF ###
export FZF_DEFAULT_OPTS="--prompt=' ' --bind ctrl-t:toggle --bind ctrl-d:toggle+down --bind ctrl-u:up+toggle --bind ctrl-a:select-all --bind ctrl-alt-a:deselect-all --preview-window=up:30%:wrap --reverse --cycle --border --color='bg+:#3B4252,bg:#353C4A,spinner:#81A1C1,hl:#616E88,fg:#D8DEE9,header:#616E88,info:#81A1C1,pointer:#81A1C1,marker:#81A1C1,fg+:#D8DEE9,prompt:#81A1C1,hl+:#81A1C1' --no-bold"
