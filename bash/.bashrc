# shellcheck shell=bash
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
case ":$PATH:" in
  *":$HOME/.local/texlive/2026/bin/aarch64-linux:"*) ;;
  *) export PATH="$HOME/.local/texlive/2026/bin/aarch64-linux:$PATH" ;;
esac
export PATH="$HOME/.cargo/bin:$PATH"


# # Show Fastfetch only in interactive shells, outside tmux
# if [[ $- == *i* && -z "$TMUX" ]]; then
#     fastfetch
# fi

alias vim='nvim'
alias ls='eza --icons'
alias ll='eza -lah --icons --git'
alias lt='eza --tree --level=2 --icons=auto'

alias ff='fastfetch'
alias top='btop'

eval "$(starship init bash)"
eval "$(zoxide init bash)"
