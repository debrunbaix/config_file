#!/bin/bash
CONFIG="$HOME/config_file/alacritty.toml"

# Lit la valeur actuelle
CURRENT=$(grep '^opacity' "$CONFIG" | awk -F'= ' '{print $2}')

if [ "$CURRENT" = "1.0" ]; then
    sed -i 's/^opacity = .*/opacity = 0.7/' "$CONFIG"
else
    sed -i 's/^opacity = .*/opacity = 1.0/' "$CONFIG"
fi
