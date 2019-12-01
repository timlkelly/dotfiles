if [ -f $HOME/.bash_aliases ]; then
  source $HOME/.bash_aliases
fi

if [ -f $HOME/.bash_functions ]; then
  source $HOME/.bash_functions
fi

# does this work?
# seen single and double with -s
# also what is test -d /path/
# [[ -f $HOME/.bash_functions ]] && source $HOME/.bash_functions
# [[ "$var" -ne 0]] && ...

# source the locally installed files
# /usr/local/etc/bash_completion.d/

if [ -f $HOME/.git-completion.bash ]; then
  source $HOME/.git-completion.bash
fi

# dont know if these are needed
export LSCOLORS=ExGxFxdxCxDxDxaccxaeex
export HISTCONTROL=ignoreboth:erasedups

export MAIL_SAFE_EMAIL="tim@benchprep.com"
export PROJECT_DIR="/Users/tim/development"

source $PROJECT_DIR/infrastructure/shell-includes/helpers

shopt -s cdspell
# what's this one do?
# set cd options

BLACK="\[\033[30m\]"
BLUE="\[\033[34m\]"
BOLD="\[\033[1m\]"
BROWN="\[\033[33m\]"
CYAN="\[\033[36m\]"
GREEN="\[\033[32m\]"
LIGHT_BLUE="\[\033[1;34m\]"
LIGHT_CYAN="\[\033[1;36m\]"
LIGHT_GRAY="\[\033[0;37m\]"
LIGHT_GREEN="\[\033[1;32m\]"
LIGHT_PURPLE="\[\033[1;35m\]"
LIGHT_RED="\[\033[1;31m\]"
PURPLE="\[\033[35m\]"
RED="\[\033[31m\]"
RESET="\[\033[0m\]"
WHITE="\[\033[37m\]"
YELLOW="\[\033[33m\]"

git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

git_status() {
  if ! git rev-parse --git-dir > /dev/null 2>&1;then
    return 0
  fi

  if git diff --quiet 2>/dev/null>&2; then
    return 0
  else
    echo " ✗"
  fi
}

kube_cluster="\$(kubectl config current-context | sed -E 's/benchprep-(.*)|(minikube)/$PURPLE\1\2$RESET/')"
kube_cluster="\$(kubectl config current-context | sed -E 's/benchprep-(.*)\/.*|(minikube)/$PURPLE\1\2$RESET/')"

__prompt_command() {
  local RET="$?"
  PS1=""

  if [ $RET != 0 ]; then
    PS1+="$RED"
  else
    PS1+="$GREEN"
  fi

  PS1+="Ƌ $RESET"
  PS1+="$kube_cluster "
  PS1+="$LIGHT_GRAY$BOLD\W$RESET"
  PS1+="$GREEN\$(git_branch)"
  PS1+="$YELLOW\$(git_status)" # this says its ok when changes added, seems strange
  PS1+="$RESET:> "
}

PROMPT_COMMAND=__prompt_command
# PROMPT_COMMAND="__prompt_command; ${PROMPT_COMMAND}"

########################################################################

########################################################################

# PROMPT_COMMAND='RET=$?;\
#   BRANCH="";\
#   ERRMSG="";\
#   if [[ $RET != 0 ]]; then\
#     ERRMSG=" $RET";\
#   fi;\
#   if git branch &>/dev/null; then\
#     BRANCH=$(git branch 2>/dev/null | grep \* |  cut -d " " -f 2);\
#   fi;'

# PS1="$GREEN\u@\h $BLUE\W $CYAN$BRANCH$RED$ERRMSG \$ $LIGHT_GRAY"

# PROMPT_COMMAND='
#   RET=$?;\
#   BRANCH="one";
# '

# export PS1="\W $RET $BRANCH"

# function prompt_command {
#   export PS1=$(~/bin/bash_prompt)
# }

#################################

# function git_color {
#   local git_status="$(git status 2> /dev/null)"

#   if [[ ! $git_status =~ "working directory clean" ]]; then
#     echo -e $COLOR_RED
#   elif [[ $git_status =~ "Your branch is ahead of" ]]; then
#     echo -e $COLOR_YELLOW
#   elif [[ $git_status =~ "nothing to commit" ]]; then
#     echo -e $COLOR_GREEN
#   else
#     echo -e $COLOR_OCHRE
#   fi
# }

# function git_branch {
#   local git_status="$(git status 2> /dev/null)"
#   local on_branch="On branch ([^${IFS}]*)"
#   local on_commit="HEAD detached at ([^${IFS}]*)"

#   if [[ $git_status =~ $on_branch ]]; then
#     local branch=${BASH_REMATCH[1]}
#     echo "$branch"
#   elif [[ $git_status =~ $on_commit ]]; then
#     local commit=${BASH_REMATCH[1]}
#     echo "$commit"
#   fi
# }

#################################

# A more colorful prompt
# \[\e[0m\] resets the color to default color
c_reset='\[\e[0m\]'
#  \e[0;31m\ sets the color to red
c_path='\[\e[0;31m\]'
# \e[0;32m\ sets the color to green
c_git_clean='\[\e[0;32m\]'
# \e[0;31m\ sets the color to red
c_git_dirty='\[\e[0;31m\]'


# determines if the git branch you are on is clean or dirty
git_prompt ()
{
  # Is this a git directory?
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    return 0
  fi
  # Grab working branch name
  git_branch=$(git branch 2>/dev/null | sed -n '/^\*/s/^\* //p')
  # Clean or dirty branch
  if git diff --quiet 2>/dev/null >&2; then
    git_color="${c_git_clean}"
  else
    git_color=${c_git_dirty}
  fi
  echo " [$git_color$git_branch${c_reset}]"
}

# ## Colors ##
# aqua="\[\e[1;36m\]"
# black="\[\e[0;30m\]"
# blue="\[\e[1;34m\]"
# green="\[\e[0;32m\]"
# grey="\[\e[1;30m\]"
# lavender="\[\e[1;35m\]"
# lime="\[\e[1;32m\]"
# lyellow="\[\e[1;33m\]"
# navy="\[\e[0;34m\]"
# pink="\[\e[1;31m\]"
# purple="\[\e[0;35m\]"
# red="\[\e[0;31m\]"
# reset="\[\e[0m\]"
# silver="\[\e[0;37m\]"
# turquoise="\[\e[0;36m\]"
# white="\[\e[1;37m\]"
# yellow="\[\e[0;33m\]"
