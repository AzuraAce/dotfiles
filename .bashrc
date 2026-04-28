# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Put your fun stuff here.
eval "$(fzf --bash)"

PROMPT_DIRTRIM=2
# PS1 theming 
PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\]:\w$(__git_ps1 " [%s]") \$\[\033[00m\] '

# Completions
. /usr/share/bash-completion/bash_completion
# enable completion if using doas instead of sudo
complete -F _root_command doas

# History
HISTSIZE=2000
HISTFILESIZE=2000
HISTCONTROL=ignoreboth
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Aliases
alias ff="fastfetch"
alias ll="ls -lah --color"
alias ls="ls --color"
alias za="zathura"
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias format='astyle -A3 -t8 -p -xg -H -j -xB'
alias ter='$TERMINAL >/dev/null 2>&1 & disown'

export EDITOR='vim'
