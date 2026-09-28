#!/bin/bash

# Download vim package 
# The apt (advanced package tool) package manager is a high-level package manager that acts as a # # front end for dpkg. It handles all dependencies for you.
# dpkg (debian package) is a low-level tool that is used for advanced troubleshooting. Fine grain control. You have to install dependencies yourself.

# This script must be ran with admin privilges.
if [[ ! $EUID -eq 0 ]]; then
    echo "Permission denied. Only root level users can execute this script."
    exit 1
fi

# Check if vim package is installed.
# command -v vim checks if I can execute vim and that it is located in my PATH. Whereas dpkg -s vim (alternative) checks if the package is installed debian based systems. command -v vim is the perferred portable option between linux distro.
if ! command -v vim &>/dev/null; then # &>/dev/null takes stdout & stderr and redirects it to /dev/null, linuxs' version of a trash bin. 2>&1 is POSIX compliant way to go.
    # we do not need to use sudo here. We have the root privilege check at
    # the beginning of the script. So this command will be executed by a user with EUID=0.
    if apt install vim; then # Here we are installing vim and checking the exit code for 0 before preceeding.
        echo "Install successful"
        exit 0
    else
        echo "Install failed"
        exit 1
    fi
else
    echo "Vim package already installed"
    exit 0
fi 


