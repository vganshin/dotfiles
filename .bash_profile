[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# if [ -f $(brew --prefix)/etc/bash_completion ]; then
#  . $(brew --prefix)/etc/bash_completion
# fi

export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/vganshin/google-cloud-sdk/path.bash.inc' ]; then . '/Users/vganshin/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/vganshin/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/vganshin/google-cloud-sdk/completion.bash.inc'; fi

genpasswd() { 
LEN=${1:-12}
pwgen -Bs $LEN 1 | tr -d '\n' | pbcopy |pbpaste; echo "Has been copied to clipboard"
}

source ~/.bashrc

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/opt/ncurses/bin:$PATH"
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH="/usr/local/opt/krb5/bin:$PATH"
export PATH="/usr/local/opt/krb5/sbin:$PATH"

