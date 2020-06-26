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

kube_cluster="\$(kubectl config current-context | sed -E 's/benchprep-(.*)|(minikube)/$PURPLE\1\2$RESET/')"
kube_cluster="\$(kubectl config current-context | sed -E 's/benchprep-(.*)\/.*|(minikube)/$PURPLE\1\2$RESET/')"

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
    echo " ✗ "
  fi
}

_prompt_command() {
  local RET="$?"
  PS1=""

  if [ $RET != 0 ]; then
    PS1+="$RED"
  else
    PS1+="$GREEN"
  fi

  PS1+="$kube_cluster "
  PS1+="$LIGHT_GRAY$BOLD\W$RESET"
  PS1+="$GREEN\$(git_branch)"
  PS1+="$RESET"

  if [ $RET != 0 ]; then
    PS1+="$RED"
  else
    PS1+="$GREEN"
  fi
  PS1+="$BOLD> $RESET"
  PS1+="$YELLOW\$(git_status)$RESET"
}

PROMPT_COMMAND=_prompt_command

####################################################################################################

# Format status message for bash PS1
header()
{
  if [ "$2" = "" ]; then
    echo "${PURPLE}[${GREEN}$1${PURPLE}]"
  else
    echo "${PURPLE}[$1${GREEN}$2${PURPLE}]"
  fi
}

git_repo() {
  git remote -v 2>/dev/null | head -n1 | awk '{print $2}' | sed 's/.*\///' | sed 's/\.git//'
}


# Get git status for PS1 header
try_get_git()
{

    none=""
    if [ $(which git 1>/dev/null 2>/dev/null; echo $?) -ne '0' ]; then
        echo ${none}
        return
    fi
    if [ $(git branch 1>/dev/null 2>/dev/null; echo $?) -ne '0' ]; then
        echo ${none}
        return
    fi
    repo=$(git_repo)
    branch=$(git branch 2>/dev/null | grep '*' | sed s/'* '//g)
    status=$(git  2>/dev/null | grep '*' | sed s/'* '//g)

    BRED="${BOLD}${RED}"
    if ! git diff-files --quiet --ignore-submodules -- 2>/dev/null; then
        if ! git diff origin/${branch}..HEAD --quiet --ignore-submodules >/dev/null 2>/dev/null; then
            # uncommited, unpushed changes
            echo "${PURPLE}[${GIT_SYMBOL}${BRED}${repo}/${branch}${OFF}${PURPLE}]"
        else
            # uncommited changes
            echo "${PURPLE}[${GIT_SYMBOL}${GREEN}${repo}${BRED}/${branch}${OFF}${PURPLE}]"
        fi
    else
        if ! git diff origin/${branch}..HEAD --quiet --ignore-submodules >/dev/null 2>/dev/null; then
            # nothing to commit, unpushed commits
            echo "${PURPLE}[${GIT_SYMBOL}${BRED}${repo}/${OFF}${GREEN}${branch}${OFF}${PURPLE}]"
        else
            # clean
            echo "${PURPLE}[${GIT_SYMBOL}${GREEN}${repo}${OFF}${GREEN}/${branch}${OFF}${PURPLE}]"
        fi
    fi
}


# Format status message for bash PS1
try_k8s_context()
{
    if [ "$KUBE_CONTEXT" != "" ]; then
        echo "${PURPLE}[${K8S_SYMBOL}${GREEN}$KUBE_CONTEXT${PURPLE}]"
    fi
}


# Format the return code for PS1
return_code="""
if [ \$? = 0 ]; then echo '';
else echo $(header ${RED}${ERROR_SYMBOL}\$?); fi"""

# Format the current directory for PS1
current_dir()
{
    CWD="$(pwd -L)"
    hdr=$(echo -e "${HDR}[${CWD}]")
    if [ ${#hdr} -gt $(expr ${COLUMNS} + 150) ];
    then
        echo ""
    fi
    echo "$(header ${CWD_SYMBOL}${CWD})"
}

# Format the hostname directory for PS1
get_hostname()
{
    if ! which scutil >/dev/null 2>/dev/null; then
        echo $(hostname -s)
    else
        echo $(scutil --get ComputerName)
    fi
}

# Format any venv name directory for PS1
try_virtual_env()
{
    if [ "$VIRTUAL_ENV" != "" ]
    then
        echo "${PURPLE}[${VENV_SYMBOL}${GREEN}${VIRTUAL_ENV##*/}${PURPLE}]"
    fi
}

try_get_user()
{
    echo '\u'
}

ps1_timer_start() {
  timer=${timer:-$SECONDS}
}

ps1_timer_stop() {
  ps1_timer_show=$(($SECONDS - $timer))
  unset timer
}

try_get_ps1_timer()
{
    if [ "$ps1_timer_show" != "0" ]; then
        echo "${PURPLE}[${TIMER_SYMBOL}${GREEN}${ps1_timer_show}${PURPLE}]"
    fi
}

trap 'ps1_timer_start' DEBUG

prompt_cmd() {
    ps1_timer_stop
    PS1=""
    HDR="\n\n"
    HDR="${HDR}"
    HDR="${HDR}\$(${return_code})"
    HDR="${HDR}$(try_get_ps1_timer)"
    # HDR="${HDR}$(try_virtual_env)"
    HDR="${HDR}$(try_k8s_context)"
    HDR="${HDR}$(try_get_git)"
    HDR="${HDR}$(current_dir)"
    HDR="${HDR}\n"

    PS1="${PS1}${HDR}"
    PS1="${PS1}${OFF}${GREEN}$(try_get_user)"
    PS1="${PS1}${OFF}${BOLD}${GREEN}@$(get_hostname)"
    PS1="${PS1}${BOLD}${BLUE}(\\W)"
    PS1="${PS1}${GREEN}$ ${OFF}"

    # Add timestamp?
    # tput sc
    # tput cup $(($(get_cursor_row)+2)) $(($(tput cols)-29))
    # echo -e "$(date)"
    # tput rc
}

# PROMPT_COMMAND=prompt_cmd
