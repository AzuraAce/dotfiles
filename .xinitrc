[ -f ~/.xprofile ] && . ~/.xprofile
xrdb -merge ~/.Xresources

setxkbmap de

sxhkd &
#feh --bg-scale -z ~/wallpapers/windows-xp.jpg &
slstatus &
dunst &

exec dbus-launch --sh-syntax --exit-with-session dwm 
