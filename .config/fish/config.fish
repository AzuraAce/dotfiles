if status is-interactive
    # Commands to run in interactive sessions can go here
    # disable welcome message
    set -g fish_greeting

    # Aliases
    alias dotfiles='/usr/local/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
end
