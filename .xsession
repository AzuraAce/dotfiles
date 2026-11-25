#!/bin/sh
if [ -x ${PREFIX}/bin/dbus-launch -a -z "${DBUS_SESSION_BUS_ADDRESS}" ]; then
	eval "$(dbus-launch --sh-syntax --exit-with-x11)"
fi

[ -f ~/.xprofile ] && . ~/.xprofile
xrdb -merge ~/.Xresources

#picom --backend=glx --vsync &
xcompmgr &
sxhkd &
feh --bg-scale ~/wallpapers/nerv.webp &
slstatus &
dunst &
xidle -ne -program "/usr/sbin/zzz" & # top right sleep hot corner

exec dwm
