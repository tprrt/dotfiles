# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
[ -r /home/tperrot/.byobu/prompt ] && . /home/tperrot/.byobu/prompt   #byobu-prompt#

# home binaries
export PATH="$HOME/dev/bin:$PATH"

# tokens
# export CIRLECI_TOKEN="FOOBAR"
# export GH_TOKEN="FOOBAR"
# export DOCKERHUB_TOKEN="FOOBAR"
# export MISTRAL_API_KEY="FOOBAR"

# bootlin
export FEINTRAGIT="$HOME/dev/bootlin/intragit"

# functions
function logless { ccze -A < $1 | less -R; }
function logtail { tail -f $1 | ccze -A; }
function epass { openssl passwd -1 $1; }
function kclip { xclip -sel clip < $HOME/.ssh/id_rsa.pub; }
function wttrin { curl https://wttr.in/$1; }

# alias
alias cp='cp -i'
alias df='df -h'
alias diff='colordiff -Nurp'
alias du='du -c -h'
alias duckchat='duckchat -y -m 4'
alias emacs='doom emacs -nw'
alias emacsclient='doom emacs -nw'
alias htop='htop --readonly'
alias ip='ip -c'
alias less="less -r"
alias mkdir='mkdir -p -v'
alias mv='mv -i'
alias picocom="picocom --escape x -b 115200 --quiet"
alias ping='ping -c 5'
alias psc="ps xawf -eo pid,user,cgroup,args"
alias pyhttp="python -m http.server"
alias rm='rm -i'
alias tb="nc termbin.com 9999"
alias tree="tree -C"

export PATH="${HOME}/.npm-global/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"

export SUPPRESS_BOLTDB_WARNING=1
