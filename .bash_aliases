# Editor
alias e="subl"
alias vi="nvim"
alias vim="nvim"
alias emacs="emacs -nw"

# Shell
alias ll="ls -lah"
alias ls="ls -Gh"
alias cp="cp -iv"
alias mv="mv -iv"
alias mkdir="mkdir -pv"
alias path='echo -e ${PATH//:/\\n}'
alias f="open -a Finder ./"

# Git
alias gst="git status"

# Rails / Ruby
alias be="bundle exec"
alias berc="bundle exec rails c"
alias pr='pry-remote -w'

# Kubernetes
alias kube='kubectl'
alias kcp='kube cp'
alias kconnect='/Users/tim/development/infrastructure/bin/remote-shell'
alias mk='export KUBECONFIG=/Users/tim/.minikube.yml'

# Benchprep
alias berp="bundle exec primer restart"
alias restart="passenger-config restart-app"

alias api="cd ~/development/benchprep-v2"
alias assets="cd ~/development/benchprep-assets"
alias blueprint="cd ~/development/benchprep-course-publisher"
alias boost="cd ~/development/benchprep-instructor-dashboard"
alias development="cd ~/development"
alias infrastructure="cd ~/development/infrastructure"
alias marketing="cd ~/development/benchprep-marketing"
alias reporting="cd ~/development/benchprep_reporting_api"
alias sso="cd ~/development/benchprep-sso"
alias teachers="cd ~/development/benchprep-teachers"
alias v2="cd ~/development/benchprep-v2"
alias webapp="cd ~/development/benchprep-webapp"
