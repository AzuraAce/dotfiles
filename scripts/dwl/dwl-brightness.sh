#!/bin/sh

APP_NAME="brightness"
STEP=5

get_icon () {
  if [ $1 -lt 50 ]; then
    echo "brightness-low"
  else
    echo "brightness-high"
  fi
}

case "$1" in
    up)
        light -A "${STEP}%"
        ;;
    down)
        light -U "${STEP}%"
        ;;
    *)
        echo "Usage: $0 [up|down]"
        exit 1
        ;;
esac

brightness=$(printf "%.0f" "$(light -G)")
icon=$(get_icon $brightness)

notify-send -a "$APP_NAME" \
            -h string:x-canonical-private-synchronous:brightness \
            -h int:value:"$brightness" \
            -i "$icon" \
            ""
