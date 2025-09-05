#!/bin/sh

STEP=5

case "$1" in
  up)
    wpctl set-volume @DEFAULT_AUDIO_SINK@ ${STEP}%+
    ;;
  down)
    wpctl set-volume @DEFAULT_AUDIO_SINK@ ${STEP}%-
    ;;
  mute)
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    ;;
  mute-mic)
    wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    ;;
  *)
    echo "Usage: $0 {up|down|mute|mute-mic}"
    exit 1
    ;;
esac

# Get current volume and mute state in percentage and boolean
volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')
muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $3}')

notify-send \
  -h string:x-canonical-private-synchronous:volume \
  -h int:value:"$volume" \
  "$muted"

