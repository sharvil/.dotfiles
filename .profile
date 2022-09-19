# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

OS=$(uname)
if [ ${OS}  == "Linux" ]; then
  CORES=$(grep -c ^processor /proc/cpuinfo)
elif [ ${OS} == "Darwin" ]; then
  CORES=$(sysctl -n hw.ncpu)
else
  echo "Update .profile to compute number of cores on machine."
  CORES=0
fi

function gpu {
  if [ $# -lt 1 ]; then
    if [[ -z ${CUDA_VISIBLE_DEVICES} && ! -z ${CUDA_VISIBLE_DEVICES+none} ]]; then
      echo "none"
    else
      echo ${CUDA_VISIBLE_DEVICES}
    fi
  elif [ "$1" == "none" ]; then
    export CUDA_VISIBLE_DEVICES=""
  elif [ "$1" == "clear" ]; then
    unset CUDA_VISIBLE_DEVICES
  else
    export CUDA_VISIBLE_DEVICES="$*"
  fi
}

HOST=$(hostname -s)
case $HOST in
  arrakis)
    PS1="\[\033[38;2;204;173;96m\]\h \[\033[38;2;81;101;114m\]\W \$ \[\033[00m\]" ;;
  caladan)
    PS1="\[\033[38;2;1;255;7m\]\h \[\033[38;2;81;101;114m\]\W \$ \[\033[00m\]" ;;
  kaitain)
    PS1="\[\033[38;2;191;119;246m\]\h \[\033[38;2;81;101;114m\]\W \$ \[\033[00m\]" ;;
  rpi*)
    PS1="\[\033[38;2;225;119;1m\]\h \[\033[38;2;81;101;114m\]\W \$ \[\033[00m\]" ;;
  *)
    PS1="\[\033[01;32m\]\u@\h \[\033[01;34m\]\W \$ \[\033[00m\]" ;;
esac

export PS1
export CLICOLOR=1
export MAKEFLAGS="-j$((${CORES} + 1))"
export MINICOM="-o -c on"
export EDITOR='vim'
export VISUAL='vim'

# Python is the worst.
export PYTHONDONTWRITEBYTECODE=1
alias python='python -B'

# Set up colors for `man` and other utilities that use termcap.
export LESS_TERMCAP_mb=$(printf "\e[1;32m")
export LESS_TERMCAP_md=$(printf "\e[1;31m")
export LESS_TERMCAP_me=$(printf "\e[0m")
export LESS_TERMCAP_se=$(printf "\e[0m")
export LESS_TERMCAP_so=$(printf "\e[1;44;33m")
export LESS_TERMCAP_ue=$(printf "\e[0m")
export LESS_TERMCAP_us=$(printf "\e[1;32m")

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export VIRTUAL_ENV_DISABLE_PROMPT=1
export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.config/gcloud/credentials.json"
export TF_CPP_MIN_LOG_LEVEL=4  # TensorFlow is such a joke.

if [ -e ${HOME}/bin ]; then
  export PATH="$PATH:$HOME/bin"
fi

if [ -e ${HOME}/.local/bin ]; then
  export PATH="$PATH:$HOME/.local/bin"
fi

if [ -e ${HOME}/Library/Android/sdk/platform-tools/adb ]; then
  export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"
fi

alias m=make
alias amke=make
alias mkae=make
alias maek=make
alias grep='grep --color=always'
alias ll='ls -lhAv'
alias ps='ps aux'
alias nvidia-smi='watch -n .2 nvidia-smi'

if command -v htop 2>&1 > /dev/null; then
  alias top='htop'
fi

if command -v nvim 2>&1 > /dev/null; then
  alias vim='nvim'
fi

if [ -e "${HOME}/.profile.${HOST}" ]; then
  source "${HOME}/.profile.${HOST}"
fi

if [ -e "${HOME}/.profile.local" ]; then
  source "${HOME}/.profile.local"
fi
