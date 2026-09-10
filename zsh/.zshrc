#!/usr/bin/env zsh

typeset -U path PATH
path=(
  /opt/homebrew/bin
  /opt/homebrew/sbin
  "$HOME/.local/bin"
  "$HOME/.local/share/nvim/lazy-rocks/bin"
  /Applications/Inkscape.app/Contents/MacOS
  $path
)

export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"

alias vim=nvim 
alias qq=exit

eval "$(starship init zsh)"

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Disable underline
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none


source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh


source <(fzf --zsh)
bindkey '^I' autosuggest-accept
alias fzfp='fzf --preview="bat --color=always {}"'
alias inv='nvim $(fzf -m --preview="bat --color=always {}")'

# ---- Eza (better ls) -----

alias eza="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"


# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

alias cd='z'
alias python=python3
alias pip=pip3

