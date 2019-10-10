# Source global definitions
if [ -f /etc/profile ]; then
        . /etc/profile
fi

# export USER=k0xxxxx
# export HOME depending on cygwin or gitbash
if [ -d /cygdrive/c/home ]; then
    export HOME=/cygdrive/c/home
else
    export HOME=/c/home
fi
export SHELL=/bin/bash
export TMPDIR=/tmp
export TZ=America/Mexico_City
export MAKE_MODE=unix
export LANG=ja_JP.UTF-8
#export LANG=C
#export LC_ALL=ja_JP.UTF-8
export LC_ALL=en_US.UTF-8
#export LC_ALL=latin1
PATH=./:/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/bin:$PATH
PATH=$PATH:$HOME/bin
export PATH
EDITOR=VIM
export EDITOR

NEWENV=profile
export NEWENV

PS1="\[\e[1;33m\]\w/\[\e[00m\]$ "  

if [ -n ${DISPLAY} ]; then
    export DISPLAY=localhost:0.0
fi

if [ ! -n "${TERM}" ]; then
    TERM=cygwin
fi

# sync history between each bash
function share_history {
  history -a
  history -c
  history -r
}
PROMPT_COMMAND='share_history'

shopt -u histappend
alias la="ls -aF"
alias ll="ls -l"
alias ls="ls -CF --color=auto"
alias cp="cp -vip"
alias mv="mv -vi"
alias rm="rm -vi"
alias emacs="/cygdrive/c/emacs/bin/emacs"
alias cs="cygstart"
alias vi="vim"
alias gdb="gdb -quiet"
alias sqlite3="sqlite3 -init ~/.sqliterc"
alias cdd="cd /cygdrive/c/Users/mtakatani/google_drive/learning_programs/javascriptworks/Head-First-JavaScript-Programming-master"

source ~/mintty-colors-solarized/sol.dark
eval `dircolors ~/etc/dircolors-solarized/dircolors.ansi-dark`
