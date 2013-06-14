[ -r ~/.aliases ] && source ~/.aliases

# general
export LANG=en_US.UTF-8
bindkey -e

setopt auto_cd
setopt auto_resume
setopt auto_list
# setopt auto_pushd
# setopt pushd_ignore_dups
setopt list_types
setopt correct
setopt equals
setopt no_flow_control
setopt long_list_jobs
setopt magic_equal_subst
setopt print_eight_bit
unsetopt promptcr

autoload -Uz select-word-style
select-word-style bash

# prompt
autoload -Uz colors
colors
setopt prompt_subst

## zsh-vcs-prompt
if [ -f ~/.zsh/zsh-vcs-prompt/zshrc.sh ]; then
    source ~/.zsh/zsh-vcs-prompt/zshrc.sh

    # The symbols.
    ZSH_VCS_PROMPT_AHEAD_SIGIL='↑ '
    ZSH_VCS_PROMPT_BEHIND_SIGIL='↓ '
    ZSH_VCS_PROMPT_STAGED_SIGIL='● '
    ZSH_VCS_PROMPT_CONFLICTS_SIGIL='✖ '
    ZSH_VCS_PROMPT_UNSTAGED_SIGIL='✚ '
    ZSH_VCS_PROMPT_UNTRACKED_SIGIL='… '
    ZSH_VCS_PROMPT_STASHED_SIGIL='⚑ '
    ZSH_VCS_PROMPT_CLEAN_SIGIL='✔ '

    # Git without Action.
    ## Branch name
    ZSH_VCS_PROMPT_GIT_FORMATS='%{%B%F{black}%}[%{%f%b%}%{%F{cyan}%}#b%{%f%}'
    ## Ahead and Behind
    ZSH_VCS_PROMPT_GIT_FORMATS+='%{%F{green}%}#c%{%F{red}%}#d%{%B%F{black}%}|%{%f%b%}'
    ## Staged
    ZSH_VCS_PROMPT_GIT_FORMATS+='%{%F{blue}%}#e%{%f%}'
    ## Conflicts
    ZSH_VCS_PROMPT_GIT_FORMATS+='%{%F{red}%}#f%{%f%}'
    ## Unstaged
    ZSH_VCS_PROMPT_GIT_FORMATS+='%{%F{yellow}%}#g%{%f%}'
    ## Untracked
    ZSH_VCS_PROMPT_GIT_FORMATS+='#h'
    ## Stashed
    ZSH_VCS_PROMPT_GIT_FORMATS+='%{%F{magenta}%}#i%{%f%}'
    ## Clean
    ZSH_VCS_PROMPT_GIT_FORMATS+='%{%F{green}%}#j%{%f%}%{%B%F{black}%}]%{%f%b%}'

    # Git with Action.
    ## Branch name
    ZSH_VCS_PROMPT_GIT_ACTION_FORMATS='%{%B%F{black}%}[%{%f%b%}%{%F{cyan}%}#b%{%f%}'
    ## Action
    ZSH_VCS_PROMPT_GIT_ACTION_FORMATS+='%{%B%F{black}%}:%{%f%b%}%{%F{red}%}#a%{%f%}'
    ## Ahead and Behind
    ZSH_VCS_PROMPT_GIT_ACTION_FORMATS+='#c#d%{%B%F{black}%}|%{%f%b%}'
    ## Staged
    ZSH_VCS_PROMPT_GIT_ACTION_FORMATS+='%{%F{blue}%}#e%{%f%}'
    ## Conflicts
    ZSH_VCS_PROMPT_GIT_ACTION_FORMATS+='%{%F{red}%}#f%{%f%}'
    ## Unstaged
    ZSH_VCS_PROMPT_GIT_ACTION_FORMATS+='%{%F{yellow}%}#g%{%f%}'
    ## Untracked
    ZSH_VCS_PROMPT_GIT_ACTION_FORMATS+='#h'
    ## Stashed
    ZSH_VCS_PROMPT_GIT_ACTION_FORMATS+='%{%F{magenta}%}#i%{%f%}'
    ## Clean
    ZSH_VCS_PROMPT_GIT_ACTION_FORMATS+='%{%F{green}%}#j%{%f%}%{%B%F{black}%}]%{%f%b%}'

    # Unabale using python
    ZSH_VCS_PROMPT_USING_PYTHON='false'
    # Enable caching
    ZSH_VCS_PROMPT_ENABLE_CACHING='true'
fi

if [ "$SSH_CLIENT" ]; then
    PROMPT_HOST="@%{$fg_bold[blue]%}%m"
else
    PROMPT_HOST=""
fi
PROMPT='%{%(?.$fg_bold[black].$fg_bold[red])%}`for i in {13..$COLUMNS}; echo -n "─"` [%D{%H:%M:%S}]%{$reset_color%}
%{$fg_bold[black]%}%n$PROMPT_HOST %{$reset_color%}%{${fg[yellow]}%}%~ %{$reset_color%}$(vcs_super_info)
%{$fg_bold[black]%}%(!.#.$) %{$reset_color%}%'
SPROMPT='%{$fg_bold[white]%}%r %{$reset_color%}%{$fg[yellow]%}is correct? [n,y,a,e]: %{$reset_color%}'

# complement
autoload -Uz compinit
compinit

zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' command 'ps -axco pid,user,command'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format '%F{magenta}%d%f'
zstyle ':completion:*:warnings' format '%F{red}No matches for: %F{yellow}%d%f'
zstyle ':completion:*:corrections' format '%F{yellow}-- %d %F{red}(errors: %e) %F{yellow}--%f'
zstyle ':completion:*' format '%F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true

setopt complete_in_word
setopt hist_expand
setopt no_beep
setopt glob_complete
setopt numeric_glob_sort
setopt extended_glob
setopt mark_dirs

bindkey '^[[Z' reverse-menu-complete

# history
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt share_history
setopt append_history
setopt extended_history
setopt hist_verify

# http://mollifier.hatenablog.com/entry/20090728/p1
zshaddhistory() {
    local line=${1%%$'\n'}

    # 以下の条件をすべて満たすものだけをヒストリに追加する
    [[ ${#line} -ge 5 ]]
}

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
if zle -la | grep -q '^history-incremental-pattern-search'; then
  bindkey '^R' history-incremental-pattern-search-backward
  bindkey '^S' history-incremental-pattern-search-forward
fi

# aliases using pipes
alias -g G="| grep"
alias -g T="| tail"
alias -g H="| head"
alias -g L="| less -R"

# z
if [ -f ~/.zsh/z/z.sh ]; then
    _Z_CMD=j
    source ~/.zsh/z/z.sh
    precmd() {
        _z --add "$(pwd -P)"
    }
fi

# zaw
if [ -f ~/.zsh/zaw/zaw.zsh ]; then
    source ~/.zsh/zaw/zaw.zsh
    zstyle ':filter-select' case-insensitive yes
    bindkey "c'" zaw-history
    bindkey "c;" zaw-git-branches
fi

# local
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
