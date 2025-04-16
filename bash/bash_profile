paths=("${HOME}/.local/bin" "${HOME}/.local/pipx/bin" "${HOME}/.cargo/bin")
for path in "${paths[@]}"; do if [[ -d "$path" && ":$PATH:" != *":$path:"* ]]; then export PATH="$PATH:$path"; fi; done
export PIPX_BIN_DIR="${HOME}/.local/pipx/bin"
export CMAKE_GENERATOR="Ninja"
export ALACRITTY_CONFIG_FILE="${HOME}/.config/alacritty/alacritty.toml"
export EDITOR="vim"
export VISUAL="vim"
export GOPATH="${HOME}/.go"
export MANPAGER="sh -c 'col -bx | bat --theme=default -l man -p'"
export MANROFFOPT="-c"
export BASH_ENV="${HOME}/.bash_aliases"
export XDG_SCREENSHOTS_DIR="${HOME}/Pictures/Screenshots"
export APPIMAGE_EXTRACT_AND_RUN=1
export MOZ_ENABLE_WAYLAND=1
export TERM="xterm-256color"
export RANGER_LOAD_DEFAULT_RC=false
[[ -r "${HOME}/.bashrc" ]] && source "${HOME}/.bashrc"
