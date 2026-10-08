# ============================================================
# ZSH PROMPT — Rouge & Blanc
# ============================================================

# ------------------------------------------------------------
# Couleurs
# ------------------------------------------------------------

RED='%F{red}'
WHITE='%F{white}'
RESET='%f'

BOLD='%B'
NO_BOLD='%b'


# ------------------------------------------------------------
# Prompt principal
#
# ┌─[user@host] - [/chemin/courant] - [history]
# └─[$]
# ------------------------------------------------------------

PROMPT="
${RED}${BOLD}┌─[${RESET}${WHITE}%n${RED}@${RESET}${WHITE}%m${RED}${BOLD}]${NO_BOLD}${RED}${BOLD} - [${RESET}${WHITE}%~${RED}${BOLD}]${NO_BOLD}${RED}
${RESET}${RED}${BOLD}└─[${WHITE}\$${RED}${BOLD}]${NO_BOLD}${RESET} "


# ------------------------------------------------------------
# Prompt secondaire
# Utilisé lorsque Zsh attend une suite de commande
# ------------------------------------------------------------

PS2="${RED}${BOLD}>${RESET} "
