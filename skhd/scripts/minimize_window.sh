#!/usr/bin/env bash

FILE="$HOME/.cache/yabai/minimized_window_id.txt"

if [[ -f ~/.cache/yabai/minimized_window_id.txt ]]; then
    yabai -m window --deminimize $(< $FILE)
	rm $FILE
else
    yabai -m window --minimize
	# Needs sed because a comma is at the end for some reason and jq fails without the sed
	yabai -m query --windows | sed 's/,]$/]/' | jq -r 'map(select(.["has-focus"] == true)) | .[0].id' > $FILE
fi
