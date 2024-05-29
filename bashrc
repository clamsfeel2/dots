if [[ $- != *i* ]]; then return; fi

shopt -s histappend
shopt -s autocd
shopt -s dirspell
if [[ -e ~/.config/starship.toml ]]; then eval "$(starship init bash)"; fi
if [[ $- == *i* ]]; then source ~/.local/share/blesh/ble.sh --noattach; fi
if [[ -e ~/.dircolors ]]; then eval "$(dircolors -b ~/.dircolors)"; fi
if [[ -f ~/.bash_aliases ]]; then source ~/.bash_aliases; fi
if [[ ":$PATH:" != *":~/.local/bin:"* ]]; then export PATH="$PATH:~/.local/bin"; fi
if [[ -d "~/.local/pipx/bin" ]]; then export PATH="$PATH:~/.local/pipx/bin"; fi
if [[ -d "~/.cargo/bin" ]]; then export PATH="$PATH:~/.cargo/bin"; fi

export PIPX_BIN_DIR="~/.local/pipx/bin"
export CMAKE_GENERATOR="Ninja"
export ALACRITTY_CONFIG_FILE="~/.config/alacritty/alacritty.toml"
export EDITOR="vim"
export VISUAL="vim"
export GOPATH="~/.go"
export MANPAGER="sh -c 'col -bx | bat --theme=default -l man -p'"
export MANROFFOPT="-c"
export BASH_ENV="~/.bash_aliases"
export XDG_SCREENSHOTS_DIR="~/Pictures/Screenshots"
export APPIMAGE_EXTRACT_AND_RUN=1
export MOZ_ENABLE_WAYLAND=1
export TERM="xterm-256color"
export RANGER_LOAD_DEFAULT_RC=false
export TINYTASK_CONFIG_FILE="~/.config/tinytask/config.toml"
export FLASHCARD_SETS_PATH="~/Mollusk/Documents/Vault/MD/School/Summer2024/Flashcards"

nitch++ -c
[[ ${BLE_VERSION-} ]] && ble-attach
