[ -f ~/.xprofile ] && . ~/.xprofile
xrdb -merge ~/.Xresources

feh --bg-scale -z /home/oliver/wallpapers/2014465.webp
easyeffects --gapplication-service &
# picom -b
# xautolock -time 5 -locker 'xset dpms force off && slock' -detectsleep -corners '++--' -cornerdelay 5 -notify 5 -notifier /home/oliver/scripts/slock/lock-screen-noti.sh &
# slstatus &
dwmblocks &
dunst &
udiskie &

# exec dbus-launch --sh-syntax --exit-with-session dwm
dwm
