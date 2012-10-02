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

[ -f ~/.bashrc.local ] && source ~/.bashrc.local
