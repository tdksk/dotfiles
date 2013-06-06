[ -r ~/.aliases ] && source ~/.aliases

# 上書き禁止
set -o noclobber

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

# git-completion
if type brew > /dev/null 2>&1 && [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then
    source `brew --prefix`/etc/bash_completion.d/git-completion.bash
else
    source ~/.bash/git-completion.bash
fi
complete -o bashdefault -o default -o nospace -F _git g 3>/dev/null || complete -o default -o nospace -F _git g
__define_git_completion () {
eval "
    _git_$2_shortcut () {
        COMP_LINE=\"git $2\${COMP_LINE#$1}\"
        let COMP_POINT+=$((4+${#2}-${#1}))
        COMP_WORDS=(git $2 \"\${COMP_WORDS[@]:1}\")
        let COMP_CWORD+=1

        local cur words cword prev
        _get_comp_words_by_ref -n =: cur words cword prev
        _git_$2
    }
"
}
__git_shortcut () {
    type _git_$2_shortcut &>/dev/null || __define_git_completion $1 $2
    alias $1="git $2 $3"
    complete -o default -o nospace -F _git_$2_shortcut $1
}
__git_shortcut ad add
__git_shortcut co checkout
__git_shortcut ci commit
__git_shortcut br branch
__git_shortcut ba branch -a
__git_shortcut c  diff --cached

PS1='\[\e[1;30m\]`for i in \`seq 11 1 ${COLUMNS}\`; do echo -n "-"; done`[\t]\n`if [ \$? = 0 ]; then echo "\[\e[0;32m\]"; else echo "\[\e[0;31m\]"; fi`\u@\h \[\e[0;33m\]\w\[\e[0;36m\] `~/.bash/gitbranch`\n\[\e[1;30m\]\$\[\e[0m\] '

[ -f ~/.bashrc.local ] && source ~/.bashrc.local
