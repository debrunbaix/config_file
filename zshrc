# if current workdir doesn't exist
[[ ! -d "$PWD" ]] && cd "$HOME"

# PATH
typeset -U path PATH
path=(
  "$JAVA_HOME/bin"
  "$HOME/my_prog"
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  $path
)

# -- Oh My Zsh --
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="duellj"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
fpath+=("${ZDOTDIR:-$HOME}/.zsh_functions")
source "$ZSH/oh-my-zsh.sh"

# -- Environnement --
export EDITOR="nvim"
export PWNLIB_GDB="pwndbg"

# -- Alias --
alias python="/usr/bin/python3"
alias e="exit"
alias ipa="ip -br -c a"
alias v="nvim"
alias arcadia-connect="ssh -i $HOME/.ssh/arcadia-runner albat0r@90.79.90.58"

# -- Outils --
eval "$(zoxide init zsh)"
eval "$(register-python-argcomplete --no-defaults exegol)"
