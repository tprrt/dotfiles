# Check for an interactive session
[ -z "$PS1" ] && return

PS1='\[\e[0;32m\]\u\[\e[1;34m\]@\h:\w \[\e[1;32m\]\$ \[\e[1;37m\] '

set show-all-if-ambiguous on

###########
## Proxy ##
###########

#use_proxy=off
#http_proxy=http://proxy.irit.fr:8001

#################
## Environment ##
#################

export LANG='fr_FR.UTF-8'
export SHELL='/bin/bash'
export TERM='xterm'
export VISUAL='emacs'
export EDITOR='emacs'

export PATH="/usr/lib/ccache/bin/:$PATH"

################
## Log viewer ##
################

logless() { ccze -A < $1 | less -R; }
logtail() { tail -f $1 | ccze -A; }

####################
## Http user mode ##
####################

#httpmode() { sudo su - http -s /bin/bash; }

###########
## Alias ##
###########

# To launch a urxvt daemon and to use urxvt clients
#/usr/bin/urxvtd -q -o -f &

alias xterm='urxvt'

alias ls='ls -hF --color=always'
alias grep='grep --color=always'
alias diff='colordiff'

alias ping='ping -c 5'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias nano='nano --mouse -w'
alias make='make -j4'
alias more='less'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

#alias jasmin='java -jar /home/pantoufle/tc2/jasmin-2.2/jasmin.jar'

#alias openoffice='/usr/bin/soffice'
