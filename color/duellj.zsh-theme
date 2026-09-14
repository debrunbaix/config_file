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

# ======
# PROMPT
# ======

PROMPT_PREFIX="${RED}${BOLD}┌─"
PROMPT_USER="${BRIGHT_CYAN}%n${BRIGHT_CYAN}@${RESET}${CYAN}%m"
PROMPT_PATH="${RED}${BOLD}] - [${RESET}${BRIGHT_WHITE}%~${RED}${BOLD}]"

PROMPT_SYMBOL="${RED}${BOLD}└─[${BRIGHT_MAGENTA}\$${RED}${BOLD}]${RESET}"

PROMPT="${PROMPT_PREFIX}[${PROMPT_USER}${PROMPT_PATH}
${PROMPT_SYMBOL} "
