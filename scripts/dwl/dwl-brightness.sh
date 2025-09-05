#!/bin/sh

# Set increment step (e.g., 5%)
STEP=5

# Direction: "up" or "down"
DIRECTION="$1"

# Change brightness
if [ "$DIRECTION" = "up" ]; then
    light -A "${STEP}%"
elif [ "$DIRECTION" = "down" ]; then
    light -U "${STEP}%-"
else
    echo "Usage: $0 [up|down]"
    exit 1
fi

# Get current and max brightness
current=$(light -G)

# Send notification with progress bar via mako (notify-send)
notify-send -u low -h string:x-canonical-private-synchronous:volume -h int:value:$current ""
