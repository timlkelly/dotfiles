source "${HOME}/.profile"

export PATH="/opt/nginx/sbin:$PATH"
export PATH="/usr/local/opt/postgresql@10/bin:$PATH"
source $PROJECT_DIR/infrastructure/shell-includes/helpers
export KUBECONFIG=$HOME/.kube/config

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
