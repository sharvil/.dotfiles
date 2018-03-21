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

export CLICOLOR=1
export MAKEFLAGS="-j$((${CORES} + 1))"
export MINICOM="-o -c on"
export PS1="\[\033[01;32m\]\u@\h \[\033[01;34m\]\W \$ \[\033[00m\]"
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

if [ -e ${HOME}/Library/Android/sdk/platform-tools/adb ]; then
  export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"
fi

alias grep='grep --color=always'

if command -v nvim 2>&1 > /dev/null; then
  alias vim='nvim'
fi
