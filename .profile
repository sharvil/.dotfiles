export CLICOLOR=1
export MAKEFLAGS="-j8"
export MINICOM="-o -c on"
export PS1="\[\033[01;32m\]\u@\h \[\033[01;34m\]\W \$ \[\033[00m\]"
export EDITOR='vim'
export VISUAL='vim'
export GREP_OPTIONS='--color=always'

if [ -e ${HOME}/Library/Android/sdk/platform-tools/adb ]; then
  export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"
fi

man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;32m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
      man "$@"
}

alias f='find . -iname'

if command -v nvim 2>&1 > /dev/null; then
  alias vim='nvim'
fi
