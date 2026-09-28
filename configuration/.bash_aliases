#1/bin/bash
# ~/.bash_aliases: Executed for personal aliases separation from main .bashrc file.
# This file is referenced in ~/.bashrc with (if [ -f ~/.bash_aliasses]; then . ~/.bash_aliases fi)

# ALIASES
if [ -x /usr/bin/dircolors ]; then # test if dircolors is an binary
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)" # -r test if readable and exist. If yes then load from the personal config, if not the eval commands load system defaults. dircolor is responsible for the LS_COLORS $ENV variables.
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
# export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='eza -alF --icons'
alias l='eza -CF --icons'
alias lr='eza -lrt created'
alias la='eza -A --icons'
alias lt='eza --tree --icons'
alias c='clear'
alias desktop='cd ~/Desktop'
alias documents='cd ~/Documents'
alias downloads='cd ~/Downloads'
alias python='python3'
alias posh="code /etc/ohmyposh/.mytheme.omp.json"


# Add an "alert" alias for long running commands.  Use like so:
# sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
