[ -f ~/.bash_aliases ] && . ~/.bash_aliases
export LDFLAGS="-L/usr/local/opt/readline/lib"
export CPPFLAGS="-I/usr/local/opt/readline/include"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

__kube_ps1()
{
    # Get current context
    CONTEXT=$(cat ~/.kube/config | grep "current-context:" | sed "s/current-context: //")

    if [ -n "$CONTEXT" ]; then
        echo "${CONTEXT}"
    fi
}

NORMAL="\[\e[00m\]"
BLACK="\[\e[1;30m\]"
BLUE="\[\e[1;34m\]"
YELLOW="\[\e[1;33m\]"
GREEN="\[\e[1;32m\]"
CYAN="\[\e[1;36m\]"

BLUEBG="\e[44m"
MAGENTABG="\e[45m"

GIT_BRANCH='$(__git_ps1 " (%s)")'
KUBE_CONTEXT='$(__kube_ps1)'

PS1="${CYAN}${KUBE_CONTEXT}${NORMAL} ${GREEN}\w${YELLOW}${GIT_BRANCH}${GREEN}\n$ ${NORMAL}"


# PS1='\[\e[1;32m\]\w\[\e[0m\]\[\e[1;33m\]$(__git_ps1 " (%s)")\[\e[0m\]\n\[\e[1;32m\]\$\[\e[0m\] '


. ~/.git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1

export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3

source /usr/local/bin/virtualenvwrapper.sh

source <(kubectl completion bash)

# Default PG creds
export PGHOST=localhost
export PGUSER=postgres
export PGPASSWORD=postgres


# alias emacs='emacs -nw'

alias k=kubectl
complete -F __start_kubectl k

alias ssh="TERM=xterm-256color ssh"
export TERM=xterm-24bit

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export PATH=/Users/vganshin/.emacs.d/bin:/usr/local/Cellar/openjdk/14.0.1/bin:$PATH
export PATH="/usr/local/opt/inetutils/libexec/gnubin:$PATH"
