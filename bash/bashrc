[[ $- != *i* ]] && return
[[ $- == *i* ]] && source ${HOME}/.local/share/blesh/ble.sh --noattach
[[ -r "${HOME}/.bash_aliases" ]] && source "${HOME}/.bash_aliases"
[[ -r "${HOME}/.dircolors" ]] && eval "$(dircolors -b ${HOME}/.dircolors)"
[[ -r "${HOME}/.config/starship.toml" ]] && eval "$(starship init bash)"
nitch++ -c
[[ ${BLE_VERSION-} ]] && ble-attach
