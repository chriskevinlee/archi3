#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

 PS1=💀"\e[1;32m [\W]\$ \e[m "


# My Custom Alias
alias ls='lsd'
alias p='pacman'
alias sp='sudo pacman'
alias C='clear'
alias s='sudo'
alias nano='nano -l'

# colorscript for terminal from DT(DistroTube) on YouTube.
colorscript random

export EDITOR=/usr/bin/nano
