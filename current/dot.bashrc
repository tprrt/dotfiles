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

# circle-ci
export TOKEN="FOOBAR"

# functions
function logless { ccze -A < $1 | less -R; }
function logtail { tail -f $1 | ccze -A; }
function epass { openssl passwd -1 $1; }
function kclip { xclip -sel clip < $HOME/.ssh/id_rsa.pub; }

# alias
alias emacs='emacs -nw'
alias emacsclient='emacsclient -nw'
alias diff='colordiff -Nurp'
alias ip='ip -c'
alias cp='cp -i'
alias less="less -r"
alias mv='mv -i'
alias rm='rm -i'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias ping='ping -c 5'
alias psc="ps xawf -eo pid,user,cgroup,args"
alias picocom="picocom --escape x --imap lfcrlf"
alias termbin="nc termbin.com 9999"
alias tree="tree -C"
