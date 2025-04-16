[[ $- != *i* ]] && return

PLUGINS="${XDG_CONFIG_HOME}/zsh/zshplug"
files=(
    "${PLUGINS}/fzf-tab/fzf-tab.plugin.zsh"
    "${PLUGINS}/zsh-autosuggestions/zsh-autosuggestions.zsh"
    "${PLUGINS}/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
    "${PLUGINS}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    "${XDG_CONFIG_HOME}/zsh/shl.zsh"
    "${XDG_CONFIG_HOME}/zsh/alifn"
)
for file in "${files[@]}"; do source "$file"; done

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(keychain --dir /tmp/ --quiet --eval id_rsa)"
eval "$(gdircolors ${XDG_CONFIG_HOME}/dircolors)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(fzf --zsh)"

zle -N edit-command-line && autoload -U edit-command-line
autoload -Uz compinit && compinit -d "${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}"

zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' fzf-flags --height=~75% --bind=ctrl-space:toggle+down
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ":completion:*" sort false
zstyle ':completion:*' list-dirs-first true
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls $realpath'
ZVM_VI_HIGHLIGHT_BACKGROUND=#EBCB8B
ZVM_VI_HIGHLIGHT_FOREGROUND=#3B4252

zvm_after_init() {
    bindkey -v
    keys=('^j' '^e' '^r' '^[c')
    typeset -A widget_bindings=('^g' fzf-cd-widget '^e' edit-command-line '^r' fzf-history-widget)
    for key in "${keys[@]}"; do
        bindkey -r "$key"
    done
    for key in ${(k)widget_bindings}; do
        bindkey "$key" "${widget_bindings[$key]}"
    done
    bindkey -s '^l' "cls\r"
}

compdef -d show
