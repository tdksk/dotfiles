# 履歴保存数
export HISTSIZE=10000
# 重複履歴を無視 & 空白から始めたコマンドを保存しない
export HISTCONTROL=ignoreboth
# 履歴保存対象外
export HISTIGNORE="?:??:???:history*:cd ~:cd ..:emacs:git di:git d:gst:l *"
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
# PS1="\n\`if [ \$? = 0 ]; then echo \[\e[32m\]; else echo \[\e[31m\]; fi\`\u@\h \[\e[33m\]\w\[\e[36m\]\$(__git_ps1)\[\e[0m\]\n\$ "
PS1='\n`if [ \$? = 0 ]; then echo "\[\e[32m\]"; else echo "\[\e[31m\]"; fi`\u@\h \[\e[33m\]\w\[\e[36m\] `~/.bash/gitbranch`\[\e[0m\]\n\$ '

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

alias tm='tmux a || tmux'
alias tls='tmux ls'

alias gst='git status -sb && git stash list'
alias gra='git status | grep deleted: | awk "{print \$3}" | xargs git rm'

function gsta {
    if [ $# -eq 1 ]; then
        git add `git status -sb | grep -v "^#" | awk  '{print$1="";print}' | grep -v "^$" | awk "NR==$1"`
        gst
    else
        echo "'"gsta"'" must take exactly one argument.
        return 1
    fi
}

function gstc {
    if [ $# -eq 1 ]; then
        git checkout `git status -sb | grep -v "^#" | awk  '{print$1="";print}' | grep -v "^$" | awk "NR==$1"`
        gst
    else
        echo "'"gstc"'" must take exactly one argument.
        return 1
    fi
}

function gstd {
    if [ $# -eq 1 ]; then
        git diff -- `git status -sb | grep -v "^#" | awk  '{print$1="";print}' | grep -v "^$" | awk "NR==$1"`
    else
        echo "'"gstd"'" must take exactly one argument.
        return 1
    fi
}

function gstv {
    if [ $# -eq 1 ]; then
        vim `git status -sb | grep -v "^#" | awk  '{print$1="";print}' | grep -v "^$" | awk "NR==$1"`
    else
        echo "'"gstv"'" must take exactly one argument.
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
