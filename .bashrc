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
# taken from https://github.com/bahamas10/dotfiles/blob/master/bashrc
COLOR256=()
COLOR256[0]=$(tput setaf 1)
COLOR256[256]=$(tput sgr0)
COLOR256[257]=$(tput bold)
PROMPT_COLORS=()
# Change the prompt colors to a theme, themes are 0-29
set_prompt_colors() {
	local h=${1:-0}
	local color=
	local i=0
	local j=0
	for i in {22..231}; do
		((i % 30 == h)) || continue

		color=${COLOR256[$i]}
		# cache the tput colors
		if [[ -z $color ]]; then
			COLOR256[$i]=$(tput setaf "$i")
			color=${COLOR256[$i]}
		fi
		PROMPT_COLORS[$j]=$color
		((j++))
	done
}
colors() {
	local i
	for i in {0..255}; do
		printf "\x1b[38;5;${i}mcolor %d\n" "$i"
	done
	tput sgr0
}
# set the theme
set_prompt_colors 24

# exit code of last process
PS1='$(ret=$?;(($ret!=0)) && echo "\[${COLOR256[0]}\]($ret) \[${COLOR256[256]}\]")'
# username (red for root)
PS1+='\[${PROMPT_COLORS[0]}\]\[${COLOR256[257]}\]$(((UID==0)) && echo "\[${COLOR256[0]}\]")\u\[${COLOR256[256]}\]'
# @
PS1+='\[${PROMPT_COLORS[1]}\]\[${COLOR256[257]}\]@\[${COLOR256[256]}\]'
# hostname
PS1+='\[${PROMPT_COLORS[3]}\]\h '
# cwd
PS1+='\[${PROMPT_COLORS[5]}\]\w '
# prompt character
PS1+='\[${PROMPT_COLORS[2]}\]\$\[${COLOR256[256]}\] '

# Completions
. /usr/share/bash-completion/bash_completion
# enable completion if using doas instead of sudo
complete -F _root_command doas

# History
HISTSIZE=2000
HISTFILESIZE=2000
HISTCONTROL=ignoredups:erasedups
shopt -s histappend

# Aliases
#alias paru="paru -a" # use paru only for aur pkgs
alias shutdown="sudo shutdown -h now"
alias reboot="sudo reboot"
alias ff="fastfetch"
alias ll="ls -lah --color"
alias ls="ls --color"
alias za="zathura"
alias syncthinggui="xdg-open https://127.0.0.1:8384"
alias mpvyt="noglob mpv --no-resume-playback"
alias md2tex="pandoc -f markdown -t latex"
alias tex2md="pandoc -f latex -t markdown"
alias tex2pdf="latexmk -pdf && latexmk -c"
alias make.conf="sudo $EDITOR /etc/portage/make.conf"
alias update="sudo emerge -avuDN @world && echo -e '\e[1;31mremoving unused dependencies \e[0m' && sudo emerge -avc"
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias format='astyle -A3 -t8 -p -xg -H -j -xB'
alias ter='$TERMINAL >/dev/null 2>&1 & disown'

export EDITOR='vim'
export NNN_FIFO='/tmp/nnn.fifo'

if command -v pyenv 1>/dev/null 2>&1; then
   eval "$(pyenv init - bash)" 
fi

# nnn cd on quit
if [ -f /usr/share/nnn/quitcd/quitcd.bash_sh_zsh ]; then
    source /usr/share/nnn/quitcd/quitcd.bash_sh_zsh
fi
