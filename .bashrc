# 履歴保存数
export HISTSIZE=10000
# 重複履歴を無視 & 空白から始めたコマンドを保存しない
export HISTCONTROL=ignoreboth
# 履歴保存対象外
export HISTIGNORE="?:??:???:history*:cd ~:cd ..:l *"
# 履歴に時刻を追加
export HISTTIMEFORMAT='%Y%m%d %T '
# 履歴の共有
shopt -s histappend
export PROMPT_COMMAND="history -a; history -n"

# 何も入力していないときはコマンド名を補完しない
shopt -s no_empty_cmd_completion
# ディレクトリ名だけで cd >=4.0
# shopt -s autocd
# cd するときディレクトリ名をよしなに修正する
shopt -s cdspell
# 補完するときディレクトリ名をよしなに修正する >=4.0
# shopt -s dirspell

source ~/.bash/git-completion.bash
PS1='\[\e[1;30m\]`for i in \`seq 11 1 ${COLUMNS}\`; do echo -n "-"; done`[\t]\n`if [ \$? = 0 ]; then echo "\[\e[0;32m\]"; else echo "\[\e[0;31m\]"; fi`\u@\h \[\e[0;33m\]\w\[\e[0;36m\] `~/.bash/gitbranch`\n\[\e[1;30m\]\$\[\e[0m\] '

alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

case "${OSTYPE}" in
    # OS X
    darwin*)
        alias la='ls -laFhG'
        ;;
    # Linux
    linux*)
        alias la='ls -laFh --color=auto'
        ;;
esac

# history のエイリアス (引数なしで30件表示)
function l {
    if [ "$1" ]; then history "$1"; else history 30; fi
}

alias e='emacs'
alias tm='tmux a || tmux'
alias tls='tmux ls'
alias b='bundle'
alias be='bundle exec'
alias t='tig'

# aliases for git
alias g='git'
alias s='git status -sb && git stash list'
alias ad='git add'
alias aa='git add . && s'
alias co='git checkout'
alias ci='git commit'
alias br='git branch'
alias ba='git branch -a'
alias c='git diff --cached'
alias gg='git grep -I -n -i --heading --break -e'
alias gra='git status | grep deleted: | awk "{print \$3}" | xargs git rm'

function m {
    git commit -m "$*"
}

function am {
    if [ $# -eq 0 ]; then
        git commit --amend -C HEAD
    else
        git commit --amend -m "$*"
    fi
}

function a {
    if [ $# -eq 1 ]; then
        git add `git status -sb | grep -v "^#" | awk  '{print$1="";print}' | grep -v "^$" | awk "NR==$1"`
        s
    else
        git add -i
    fi
}

function d {
    if [ $# -eq 1 ]; then
        git diff -- `git status -sb | grep -v "^#" | awk  '{print$1="";print}' | grep -v "^$" | awk "NR==$1"`
    else
        git diff
    fi
}

function r {
    if [ $# -eq 1 ]; then
        git reset -- `git status -sb | grep -v "^#" | awk  '{print$1="";print}' | grep -v "^$" | awk "NR==$1"`
    else
        echo "'"r"'" must take exactly one argument.
        return 1
    fi
}

function v {
    if [ $# -eq 1 ]; then
        vim `git status -sb | grep -v "^#" | awk  '{print$1="";print}' | grep -v "^$" | awk "NR==$1"`
    else
        echo "'"v"'" must take exactly one argument.
        return 1
    fi
}

# Git リポジトリのトップレベルに cd
function u {
    cd ./$(git rev-parse --show-cdup)
    if [ $# = 1 ]; then
        cd $1
    fi
}

[ -f ~/.bashrc.local ] && source ~/.bashrc.local
