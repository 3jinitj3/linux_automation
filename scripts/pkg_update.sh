#!/bin/bash

# Check if root user
if [[ ! $EUID -eq 0 ]]; then
    echo "Permission denied. Script can only be executed by root user"
    exit 1
fi

# Update packages. {} groups commands below for redirection.
# The (;) signals the end of an command, also the brace syntax requires a (;) before the closing }.
{ apt-get update && apt-get full-upgrade -y; } 2>&1 |
    tee -a "/var/log/apt/upgrade-$(date +%F).log" # tee reads from stdin and write to stdout and files, -a mean append.

