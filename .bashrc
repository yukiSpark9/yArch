#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1="\[\033[1;37m\][\[\033[1;35m\]\u\[\033[0m\]@\[\033[1;36m\]\h\[\033[0m\]]\[\033[0m\] \[\033[1;37m\]\w\[\033[0m\] ~> "
alias yukifetch='neofetch --kitty ~/yArch/ASCIIyuki.jpeg'
blahaj -s
alias spotify='spt'
alias bottom='btm'
