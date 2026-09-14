# user, host, full path, and time/date
# on two lines for easier vgrepping
# entry in a nice long thread on the Arch Linux forums: https://bbs.archlinux.org/viewtopic.php?pid=521888#p521888
#
# =====
# color
# =====

autoload -U colors && colors

RESET='%{$reset_color%}'
BOLD='%B'
NOBOLD='%b'

BLACK='%{$fg[black]%}'
RED='%{$fg[red]%}'
GREEN='%{$fg[green]%}'
YELLOW='%{$fg[yellow]%}'
BLUE='%{$fg[blue]%}'
MAGENTA='%{$fg[magenta]%}'
CYAN='%{$fg[cyan]%}'
WHITE='%{$fg[white]%}'

# Versions bright
BRIGHT_GREEN='%{$fg_bold[green]%}'
BRIGHT_CYAN='%{$fg_bold[cyan]%}'
BRIGHT_MAGENTA='%{$fg_bold[magenta]%}'
BRIGHT_WHITE='%{$fg_bold[white]%}'

# ===
# GIT
# ===

ZSH_THEME_GIT_PROMPT_PREFIX="$FG[075]($FG[078]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$my_orange*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$FG[075])%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%} ✈"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%} ✭"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✗"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%} ➦"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%} ✂"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[grey]%} ✱"

git_prompt_info() {
  local ref
  ref=$(git symbolic-ref HEAD 2>/dev/null) || ref=$(git rev-parse --short HEAD 2>/dev/null) || return
  echo "${ZSH_THEME_GIT_PROMPT_PREFIX}${ref#refs/heads/}$(git_dirty)${ZSH_THEME_GIT_PROMPT_SUFFIX}"
}

git_dirty() {
  git diff --quiet --ignore-submodules HEAD 2>/dev/null
  if [[ $? -eq 1 ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

# ======
# PROMPT
# ======

PROMPT_PREFIX="${RED}${BOLD}┌─"
PROMPT_USER="${BRIGHT_CYAN}%n${BRIGHT_CYAN}@${RESET}${CYAN}%m"
PROMPT_PATH="${RED}${BOLD}] - [${RESET}${BRIGHT_WHITE}%~${RED}${BOLD}]"

PROMPT_SYMBOL="${RED}${BOLD}└─[${BRIGHT_MAGENTA}\$${RED}${BOLD}]${RESET}"

PROMPT="${PROMPT_PREFIX}[${PROMPT_USER}${PROMPT_PATH}\$(git_prompt_info)
${PROMPT_SYMBOL} "
