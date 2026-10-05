#!/bin/bash

CONFIG_PATH="~/config_file"

#
# KDE
#
ln -sf $(CONFIG_PATH)/kde/kdeglobals ~/.config/kdeglobals
ln -sf $(CONFIG_PATH)/kde/kwinrc ~/.config/kwinrc
ln -sf $(CONFIG_PATH)/kde/kglobalshortcutsrc ~/.config/kglobalshortcutsrc
ln -sf $(CONFIG_PATH)/kde/kcminputrc ~/.config/kcminputrc
ln -sf $(CONFIG_PATH)/kde/plasma-org.kde.plasma.desktop-appletsrc ~/.config/plasma-org.kde.plasma.desktop-appletsrc

#
# ALACRITTY
#
ln -s $(CONFIG_PATH)/alacritty.toml ~/.config/alacritty/alacritty.toml

#
# ZSHRC
#
ln -s $(CONFIG_PATH)/zshrc ~/.zshrc
mkdir -p ~/.oh-my-zsh/themes
ln -s $(CONFIG_PATH)/debrunbaix.zsh-theme ~/.oh-my-zsh/themes/debrunbaix.zsh-theme

#
# TMUX
#
ln -s $(CONFIG_PATH)/tmux.conf ~/.tmux.conf

#
# NVIM
#
ln -s $(CONFIG_PATH)/nvim ~/.config/nvim
