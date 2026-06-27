#!/bin/sh
#if [ -x ${PREFIX}/bin/dbus-launch -a -z "${DBUS_SESSION_BUS_ADDRESS}" ]; then
#	eval `dbus-launch --sh-syntax --exit-with-session`
#fi
[ -f ~/.xprofile ] && . ~/.xprofile
xrdb -merge ~/.Xresources

picom --backend=glx --vsync &
sxhkd &
feh --bg-scale -z ~/wallpapers/nerv.webp &
slstatus &
dunst &
#xss-lock slock &

#exec dbus-launch --sh-syntax --exit-with-session dwm 
#exec dwm 
dwm
