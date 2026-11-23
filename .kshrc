if [ -z "$TMUX" ]; then
    exec tmux
fi

PS1="\033[32m[\u\033[35m@\033[33m\h\033[00m \033[36m\w\033[00m\033[32m]\033[00m$ "

HISTFILE="$HOME/.ksh_history"
HISTSIZE=5000

# Aliases
alias ff="fastfetch"
alias ll="ls -lah"
alias za="zathura"
alias dotfiles='/usr/local/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias format='astyle -A3 -t8 -p -xg -H -j -xB'
alias ter='$TERMINAL >/dev/null 2>&1 & disown'

# Play Zork
zork() {
    case "$1" in
        1|2|3) cd ~/Games/Zork && frotz "/usr/local/share/zork/zork$1.z3" ;;
        *) echo "Usage: zork 1|2|3" >&2; return 1 ;;
    esac
}

# fzf search history
fh()
{
    command=$(fc -ln 1 | fzf)
    [ -n "$command" ] && print -s "$command"
}

# fzf file search
vf()
{
    file=$(find . -type f | fzf)
    [ -n "$file" ] && vim "$file"
}

# fzf ctags search
ft()
{
    tag=$(cut -f1 tags | sort -u | fzf)
    [ -n "$tag" ] && vim -t "$tag"
}

export VISUAL="emacs"
export EDITOR="$VISUAL"
set -o emacs
