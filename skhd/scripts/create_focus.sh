#!/usr/bin/env bash

space_index=$1
if ! yabai -m query --spaces | jq '.[].index' | grep -q "^$space_index$"; then
	yabai -m space --create
fi
yabai -m space --focus $space_index
