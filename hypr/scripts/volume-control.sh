#!/bin/bash

# Check if the default source is muted
if pactl list sources | command grep -q "Mute: yes"; then
    return 1;
else
    # If not muted, change the volume
	pactl set-sink-volume @DEFAULT_SINK@ +2%
fi

