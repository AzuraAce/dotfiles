PS1="\033[32m[\u@\h\033[00m \033[36m\w\033[00m\033[32m]\033[00m$ "

HISTFILE="$HOME/.ksh_history"
HISTSIZE=5000

# Aliases
alias ff="fastfetch"
alias ll="ls -lah --color"
alias ls="ls --color"
alias za="zathura"
alias dotfiles='/usr/local/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias format='astyle -A3 -t8 -p -xg -H -j -xB'
alias ter='$TERMINAL >/dev/null 2>&1 & disown'

export VISUAL="emacs"
export EDITOR="$VISUAL"
set -o emacs
