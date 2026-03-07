# -- OH MY ZSH --
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="simple"

# -- PLUGINS --
plugins=(
  git
)

# -- activate OMZ --
source $ZSH/oh-my-zsh.sh

# -- ALIAS --
alias python="/usr/bin/python3"
alias e="exit"
alias ipa="ip -br -c a"
alias install="sudo pacman -S"
alias r2="radare2"
alias bat="batcat"
alias v="nvim"
alias y="yazi"

# -- EXEGOL --
export PATH="$PATH:/home/songbird/.local/bin"
alias exegol='sudo -E /home/songbird/.local/bin/exegol'

eval "$(zoxide init zsh)"
export EDITOR="nvim"
export PATH=$PATH:/home/songbird/.venv/bin
export PATH=/home/songbird/.local/share/gem/ruby/3.4.0/bin:/home/songbird/.local/share/gem/ruby/3.4.0/bin:/home/songbird/.cargo/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/var/lib/flatpak/exports/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/songbird/.local/bin:/home/songbird/.venv/bin:/home/songbird/.local/bin:/home/songbird/.venv/bin
export JAVA_HOME=/usr/lib/jvm/jdk-24.0.1-oracle-x64
export PATH=$JAVA_HOME/bin:$PATH

fpath+=${ZDOTDIR:-~}/.zsh_functions
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"

export PATH="$HOME/my_prog:$PATH"
export PWNLIB_GDB=pwndbg
