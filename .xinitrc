[ -f ~/.xprofile ] && . ~/.xprofile
xrdb -merge ~/.Xresources

setxkbmap de

# start pipewire before anything
gentoo-pipewire-launcher & # this is gentoo specific
#pipewire & # uncomment this line on non-gentoo

feh --bg-scale -z /home/oliver/wallpapers/mountains.jpg &
dwmblocks &
dunst &

exec dbus-launch --sh-syntax --exit-with-session dwm # gentoo specific

## OLD
#syncthing &
#darkman run & # light/dark mode auto switch
#gammastep -l 55.7:12.6 -t 5700:3600 -g 0.8 -m randr &
#udiskie &

#exec dbus-run-session dwm
