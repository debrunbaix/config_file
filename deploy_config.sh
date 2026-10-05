#!/bin/bash

CONFIG_PATH="$HOME/config_file"

#
# KDE
#
ln -sf "$CONFIG_PATH/kde/kdeglobals" "$HOME/.config/kdeglobals"
ln -sf "$CONFIG_PATH/kde/kwinrc" "$HOME/.config/kwinrc"
ln -sf "$CONFIG_PATH/kde/kglobalshortcutsrc" "$HOME/.config/kglobalshortcutsrc"
ln -sf "$CONFIG_PATH/kde/kcminputrc" "$HOME/.config/kcminputrc"
ln -sf "$CONFIG_PATH/kde/plasma-org.kde.plasma.desktop-appletsrc" "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc"

#
# ALACRITTY
#
mkdir -p "$HOME/.config/alacritty"
ln -sf "$CONFIG_PATH/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"

#
# ZSHRC
#
ln -sf "$CONFIG_PATH/zshrc" "$HOME/.zshrc"

mkdir -p "$HOME/.oh-my-zsh/themes"
ln -sf "$CONFIG_PATH/debrunbaix.zsh-theme" "$HOME/.oh-my-zsh/themes/debrunbaix.zsh-theme"

#
# TMUX
#
ln -sf "$CONFIG_PATH/tmux.conf" "$HOME/.tmux.conf"

#
# NVIM
#
mkdir -p "$HOME/.config"
ln -sfn "$CONFIG_PATH/nvim" "$HOME/.config/nvim"

