#!/bin/bash

CONFIG_PATH="~/config_file"

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
