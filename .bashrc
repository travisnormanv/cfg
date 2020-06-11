#
# ~/.bashrc
#

# default editor
export EDITOR="vim"
export VISUAL="vim"

# color setting
export COLOR_NC='\e[0m' # No Color
export COLOR_WHITE='\e[1;37m'
export COLOR_BLACK='\e[0;30m'
export COLOR_BLUE='\e[0;34m'
export COLOR_LIGHT_BLUE='\e[1;34m'
export COLOR_GREEN='\e[0;32m'
export COLOR_LIGHT_GREEN='\e[1;32m'
export COLOR_CYAN='\e[0;36m'
export COLOR_LIGHT_CYAN='\e[1;36m'
export COLOR_RED='\e[0;31m'
export COLOR_LIGHT_RED='\e[1;31m'
export COLOR_PURPLE='\e[0;35m'
export COLOR_LIGHT_PURPLE='\e[1;35m'
export COLOR_BROWN='\e[0;33m'
export COLOR_YELLOW='\e[1;33m'
export COLOR_GRAY='\e[0;30m'
export COLOR_LIGHT_GRAY='\e[0;37m'

# iBus config
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

# enable autocomplete with sudo
complete -cf sudo

# aliases
alias c="clear"
alias grep="grep --color=auto"
alias ls="ls --color=auto --group-directories-first"
alias sc="sudo systemctl"
alias p="sudo pacman"
alias t="tmux"
alias em="emacs -nw"
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1="\[${COLOR_YELLOW}\]\u\[${COLOR_LIGHT_GREEN}\]@\h\[${COLOR_WHITE}\][\W]\\[${COLOR_NC}\]$ "
