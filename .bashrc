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
. ~/.profile
eval "$(fzf --bash)"

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
PS1="\w \$(parse_git_branch) $ "
PURPLE="\[$(tput setaf 5)\]"
RESET="\[$(tput sgr0)\]"
PS1="┌─[${PURPLE} \u@\h \w \$(parse_git_branch)${RESET}]\n└─\$ "

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
alias shutdown="sudo shutdown -h now"
alias reboot="sudo reboot"
alias ff="fastfetch"
alias ll="ls -lah --color"
alias ls="ls --color"
alias za="zathura"
alias ytdlm="yt-dlp -x --audio-format mp3 \
--embed-metadata \
--embed-thumbnail \
--add-metadata \
--output '%(playlist_title)s/%(playlist_index)02d - %(title)s.%(ext)s' \
--parse-metadata 'channel:%(artist)s' "
alias syncthinggui="xdg-open https://127.0.0.1:8384"
alias mpvyt="noglob mpv --no-resume-playback"
alias md2tex="pandoc -f markdown -t latex"
alias tex2md="pandoc -f latex -t markdown"
alias tex2pdf="latexmk -pdf && latexmk -c"
alias make.conf="sudo $EDITOR /etc/portage/make.conf"
alias update="sudo emerge -avuDN @world && echo -e '\e[1;31mremoving unused dependencies \e[0m' && sudo emerge -avc"
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='emacs'
fi
