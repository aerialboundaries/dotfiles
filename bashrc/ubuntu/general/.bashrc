# ======================================================================
# BashRC: ユーザー定義の設定とGit, Pyenv, Zoxide, Fzf, Postgres設定
# ======================================================================

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# ----------------------------------------------------------------------
# 履歴設定 (History Settings)
# ----------------------------------------------------------------------
# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
shopt -s histappend
export HISTSIZE=100000
export HISTFILESIZE=409600
export HISTIGNORE=":pwd:id:uptime:resize:ls:clear:history:"

# ----------------------------------------------------------------------
# シェル挙動の設定
# ----------------------------------------------------------------------
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# ----------------------------------------------------------------------
# Git Prompt 設定
# ----------------------------------------------------------------------
# Gitプロンプト関数の読み込み (Ubuntu/WSLの標準パス)
if [ -f /usr/lib/git-core/git-sh-prompt ]; then
  . /usr/lib/git-core/git-sh-prompt
fi

# Gitプロンプトの表示オプション
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWCOLORHINTS=true

# ----------------------------------------------------------------------
# PROMPT_COMMAND の定義と統合 (競合解消済み)
# ----------------------------------------------------------------------

# 履歴同期関数: 複数セッション間で履歴を共有
function share_history {
  history -a # 現在のセッションの履歴をファイルに追記
  history -c # メモリ上の履歴をクリア
  history -r # ファイルから履歴を再読み込み
}

# プロンプトの後に改行を入れる関数
function add_line {
  if [[ -z "${PS1_NEWLINE_LOGIN}" ]]; then
    PS1_NEWLINE_LOGIN=true
  else
    printf '\n'
  fi
}

# PROMPT_COMMAND: Git状態の準備 -> 履歴同期 -> 改行追加 を統合して実行
# NOTE: __git_ps1 の関数呼び出しは PS1 定義に含まれるため、ここでは 'history -a' のみを実行。
# しかし、git-sh-prompt の仕様により、__git_ps1の評価を確実にするため、
# PROMPT_COMMANDに組み込む方式ではなく、最終的に履歴の追記のみを PROMPT_COMMAND とします。
export PROMPT_COMMAND='share_history; add_line'

# ----------------------------------------------------------------------
# PS1 (プロンプト文字列) の定義
# ----------------------------------------------------------------------

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  # PS1: [ユーザー名@ホスト名]:[ディレクトリ (Git状態)] 改行 $
  # 元の設定: ${debian_chroot:+($debian_chroot)}\[\033[0;33m\]\u@\h\[\033[00m\]:\[\033[0;34m\]\w\[\033[00m\]\n\$ '
  # Gitプロンプト: $(__git_ps1 " (%s)") を組み込み
  PS1='${debian_chroot:+($debian_chroot)}\[\033[0;33m\]\u@\h\[\033[00m\]:\[\033[0;34m\]\w\[\033[00m\]$(__git_ps1 " (%s)")\n\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1 " (%s)")\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*) ;;
esac

# ----------------------------------------------------------------------
# エイリアスと色設定
# ----------------------------------------------------------------------

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# ----------------------------------------------------------------------
# ユーザー定義のエイリアスと設定 (masato)
# ----------------------------------------------------------------------
alias la="ls -aF"
alias ll="ls -alF"
alias ls="ls -CF --color=auto"
alias cp="cp -vip"
alias mv="mv -vi"
alias rm="rm -vi"
alias vi="nvim"
alias vim="nvim"
alias python="python3"

# Config by masato
stty stop undef

# Path masato
PATH=$PATH:${HOME}/bin/scripts

# dircolors設定の読み込み
eval $(dircolors ~/etc/dircolors-solarized/dircolors.ansi-dark)

# VcXsrv setting
export DISPLAY=:0.0

# -----------------------------
# pyenv 設定
# -----------------------------
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# pyenv を bash で有効化
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)" # ログインシェル用
  eval "$(pyenv init -)"      # 非ログインシェル用
fi

# neovim
export PATH="/opt/nvim-linux-x86_64/bin:$PATH"

# -----------------------------
# PostgreSQL 16 設定
# -----------------------------
export PG_VERSION=16
export PATH="/usr/lib/postgresql/$PG_VERSION/bin:$PATH"

# デフォルト接続設定
export PGUSER=masato
export PGDATABASE=scmex
export PGPORT=5432
export PGHOST=localhost
export PGPASSWORD='scmex123'

# -----------------------------
# PostgreSQL 便利エイリアス
# -----------------------------
alias psql16='psql -U $PGUSER -d $PGDATABASE -h $PGHOST -p $PGPORT'
alias pgstart='sudo service postgresql start'
alias pgstop='sudo service postgresql stop'
alias pgstatus='sudo service postgresql status'
alias pglogs='sudo journalctl -u postgresql -f'

# ------------------------
# zoxide
# ------------------------
eval "$(zoxide init bash)"

# ------------------------
# fzf
# ------------------------
shellcheck source=/home/masato/.fzf.bash
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# ----------------------------------------------------

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# -------------------
# Gemini API
# --------------------
export "GEMINI_API_KEY=AIzaSyAeIhzIHwQbNnHNGGSvcIVk5a157cpWO_o"
# --------------------

# ------------------
# Truecolor
# ------------------
export COLORTERM=truecolor

# ------------------
# Midnight Commander Solarized
export MC_SKIN=/home/masato/.config/mc/skins/solarized-dark-truecolor.ini
# --------------------
export EDITOR=nvim
export VISUAL=nvim

# ------------------
# gcc options
# ------------------
# C言語学習・開発用のエイリアス
alias ccg='gcc -g -Wall -Wextra -Wpedantic -std=c11'
