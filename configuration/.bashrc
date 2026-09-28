# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

PATH="$HOME/bin:$PATH"


# If not running interactively, don't do anything | Should come before other formatting
case $- in # $- = SHELL active optive letters (i), ;; = ends case branch, 
    *i*) ;;
      *) return;; # Stops processing .bashrc if not interactive
esac

# Welcome message and cursor configuration (| <-- Blinking)
echo " "
echo -n "Welcome, "; whoami # To avoid the external command whoami use printf '.., %s\n' "$USER"
echo " " 
echo -n "Today is "; date
echo " " 
echo -e '\e[5 q' # \e is ASCII escape character, [5 q = blinking vertical cursor

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth # Combine ignorespace (empty space before command) & ignoredups (consecutive identical commands) | ignoreboth:erasedups would ignore every duplicate, currently it's kinda selective.

# append to the history file, don't overwrite it
shopt -s histappend # shopt controls optional bash behaviors, -s = set or enable, histappend = apprend new commands to history file, not set could overwrite.

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000 # Numbers of commands in current shell memory
HISTFILESIZE=2000 # Number of lines in the on-disk history file (~/.bashrc)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize # -s (set or enable), checks terminal size after resizing for rendering

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar #(** acts as recursive globbing, matching directories and files)

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)" # && runs the command on the right only if the left command succeeds. lesspipe is used to render compressed files in plain text

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then # debian_chroot hold a temp value (empty otherwise | Shell variable), :- safetly handles var being unset, -z test if a string has zero length. && both must succed. Left, test is debian_chroot is empty or unset. Right test is if it exist and is readable (-r).
    debian_chroot=$(< /etc/debian_chroot) # If it is changed then it is added to my shell prompt. The (<) avoid launching cat, checks and directs the ouput to the variable.
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in # $TERM = terminal capabilities available to applications (VALUES: xterm, xterm-256color, screen-256color, tmux-256color, linux)
    xterm-color|*-256color) color_prompt=yes;; # inside case pattern (| <-- means OR), if any color matches color the prompt.
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then # -n nonempty (run if it has a value).
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then # -x is file an executable, 
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	    color_prompt=yes # if test is successful enable the colored prompt
    else
	    color_prompt= # if NOT DO NOTHING
    fi
fi

if [ "$color_prompt" = yes ]; then # Only succeeds if force_color_prompt is NOT commented out.
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h:\[\033[00m\]\[\033[01;34m\]\w\[\033[00m\]\$ ' # [01;32m\] means they do not occupy visable columns, [\033 is like \e used for escape purposes. [\033[00m\]] reset formatting. [01;34m\] restart bold blue, the 01 is the bold, and 34m is the color. Background and cursor coloring is done by terminal profile settings
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt # Deletes these variables after assignment to keep shell variables cleaner

# If this is an xterm set the title to user@host:dir
case "$TERM" in #
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1" #\[\e]0 begings terminal title setting sequence
    ;;
*)
    ;;
esac


# Alias definitions are located in ~/.bash_aliases
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

# Setting environment variables.
export NVM_DIR="$HOME/.nvm" # Sets the env variable for the Node Version Manager(nvm) which is used to manage the different version of Node.js
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # -s test if file exist and has a SIZE > 0. \. is the same as (. <-- execute). The backslash is to prevent an aliases (.) from being called. NVM must be sourced (like source ~/.bashrc, reload a config file, can also use ..)instead of called, it modifies the current shell environment.
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion (tab completion, helps finish commands, and flag selection)
export EDITOR='code --wait'
export VISUAL='code'
export GIT_EDITOR='code --wait' # --wait, makes the command wait until vscode is closed before reportig completion. Useful for programs that pause while you edit.
export TERM=xterm-256color



aptup() {
    {
        sudo apt-get update && \
        sudo apt-get full-upgrade -y
    } 2>&1 | sudo tee -a "/var/log/apt/upgrade-$(date +%F).log"
}

# If oh-my-posh is installed, load my json config.
if command -v oh-my-posh >/dev/null 2>&1; then
    eval "$(oh-my-posh init bash --config /etc/ohmyposh/.mytheme.omp.json)"
fi

