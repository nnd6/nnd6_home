# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export LANG=C
S_LANG=ja_JP.UTF-8
PATH=$PATH:$HOME/bin

alias emacs="LANG=${S_LANG} emacs"
alias screen="LANG=${S_LANG} screen"
alias netbeans="LANG=${S_LANG} netbeans"
# User specific aliases and functions
alias nlp01="ssh hirai@nlp01"

myos() {
    if [ -f /etc/redhat-release ] ;then
	cut -d' ' -f 1 /etc/redhat-release
    elif [ -f /etc/os-release ] ;then
	sed -n -e 's/^NAME="*\([^" ]\+\).*/\1/p' /etc/os-release
    else
	echo 'unkwn'
    fi
}

### for screen
if [ x"$TERM" = xscreen ]
then
    MYOS=`myos`
    PS1=`echo "$PS1" |sed 's,\\\\h,\\\\h\\/$WINDOW.$SHLVL,g'`
elif [ "`hostname |grep '^[0-9a-f]\{12\}$'`" != "" ]
then
    # may be inside docker container
    MYOS=`myos`
    PS1=`echo "$PS1" |sed 's,\\\\h,[${MYOS} on docker],g'`
fi

## ruby -- gem for local install
if [ -d ~/.gem/ruby/1.9.1 ]
then
    #export GEM_HOME=~/lib/gems
    export GEM_HOME=~/.gem/ruby/1.9.1
    PATH=$PATH:${GEM_HOME}/bin
fi

## for emacs warning (X)
export NO_AT_BRIDGE=1

alias nlp224='ssh nlp224'
alias jevex='ssh jevex'
alias redhatdev1='ssh redhatdev1'

if [ "$MSYSTEM" != "" ]
then
    alias vi=vim
    export ALTERNATE_EDITOR='/c/GNU/emacs/24.4-ime_pached/bin/runemacs.exe'
    alias ec='HOME=/c/GNU/emacs/home /c/GNU/emacs/24.4-ime_pached/bin/emacsclient.exe'
    alias ecw='HOME=/c/GNU/emacs/home /c/GNU/emacs/24.4-ime_pached/bin/emacsclientw.exe'

    CONDAPATH="/C/e/Anaconda3:/C/d/Anaconda3/Scripts:/C/e/Anaconda3/Library/bin"CUDAPATH="/C/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v8.0/bin:/C/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v8.0/libnvvp"
    GCC32PATH="/C/e/TDM-GCC-32/bin"
    GCC64PATH="/C/e/TDM-GCC-64/bin"
    set_anaconda()
    {
	PATH=${CONDAPATH}:${PATH}
    }
    PATH=/c/target/bin:/c/tools/bin:$PATH
    set_gcc32()
    {
	PATH=${GCC32PATH}:${PATH}
	alias make=mingw32-make.exe
    }
fi

if [ -f ~/nnd6_home/.bash_nnd6 ]
then
    . ~/nnd6_home/.bash_nnd6
fi
