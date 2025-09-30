
export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

#fastfetch --logo arch


# Created by `pipx` on 2025-02-22 11:55:00
export PATH="$PATH:/Users/econhead/.local/bin"
export PATH="/Applications/Inkscape.app/Contents/MacOS:$PATH"

alias vim=nvim 

export PATH="$HOME/.local/share/nvim/lazy-rocks/bin:$PATH"

eval "$(starship init zsh)"

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Disable underline
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

bindkey '^I' autosuggest-accept

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source <(fzf --zsh)
alias fzfp='fzf --preview="bat --color=always {}"'
alias inv='nvim $(fzf -m --preview="bat --color=always {}")'

# ---- Eza (better ls) -----

alias eza="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"

# thefuck alias
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

alias cd='z'
alias python=python3
alias pip=pip3

export PATH="/opt/homebrew/bin:$PATH"
