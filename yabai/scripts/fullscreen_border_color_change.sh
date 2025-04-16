#!/usr/bin/env bash

set_borders() {
    local color=$1
    local width=$2
    borders active_color=$color width=$width
}

while true; do
    window_info=$(yabai -m query --windows --window)
    is_floating=$(echo "$window_info" | jq -r '."is-floating"')
    if [[ "$is_floating" == "true" ]]; then
        set_borders "0xff33d6ff" 3.0
    else
        set_borders "0xff8fbcbb" 3.0
    fi
    sleep 1
done
