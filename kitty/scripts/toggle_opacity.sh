#!/bin/bash

CONFIG_FILE="$HOME/.config/kitty/current_opacity"
[ ! -f "$CONFIG_FILE" ] && echo 1.0 > "$CONFIG_FILE"

CURRENT_OPACITY=$(cat "$CONFIG_FILE")

if [ "$CURRENT_OPACITY" = "1.0" ]; then
    kitty @ set-background-opacity 0.5
    echo 0.5 > "$CONFIG_FILE"
else
    kitty @ set-background-opacity 1.0
    echo 1.0 > "$CONFIG_FILE"
fi

