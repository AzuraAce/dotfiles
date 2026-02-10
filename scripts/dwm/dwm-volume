#!/bin/bash

APP_NAME="volume"
STEP=5

get_icon () {
  if [ $1 -lt 20 ]; then
    echo "audio-volume-low"
  elif [ $1 -lt 70 ]; then
    echo "audio-volume-medium"
  else
    echo "audio-volume-high"
  fi
}

case "$1" in
  up)
    wpctl set-volume @DEFAULT_AUDIO_SINK@ ${STEP}%+
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
    volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ \
               | awk '{print int($2*100)}')
    icon=$(get_icon $volume)
    ;;
  down)
    wpctl set-volume @DEFAULT_AUDIO_SINK@ ${STEP}%-
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
    volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ \
               | awk '{print int($2*100)}')
    icon=$(get_icon $volume)
    ;;
  mute)
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $3}')
    if [[ ! -z $muted ]]; then
      icon="audio-volume-muted"
      volume=0
    else
      volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ \
                | awk '{print int($2*100)}')
      icon=$(get_icon $volume)
    fi
    ;;
  mute-mic)
    wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    muted_mic=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ \
                  | awk '{print $3}')
    if [[ ! -z $muted_mic ]]; then
      icon="mic-volume-muted"
      volume=0
    else
      volume=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ \
                | awk '{print int($2*100)}')
      icon="mic-volume-high"
    fi
    ;;
  *)
    echo "Usage: $0 [up|down|mute|mute-mic]"
    exit 1
    ;;
esac

notify-send -a "$APP_NAME" \
            -h string:x-canonical-private-synchronous:volume \
            -h int:value:"$volume" \
            -i "$icon" \
            ""
