#!/bin/bash

# Verify root user
if [[ ! $EUID -eq 0 ]]; then
    echo "Permissio denied. Script can only be executed by root user"
    exit 1
fi

# Verify connection to google DNS IP (8.8.8.8)
if ! ping -c5 8.8.8.8 &>/dev/null; then
    echo "ERROR: System unable to connect to google DNS 8.8.8.8"
    exit 1
else
    echo "SUCCESS: System was able to connect to google DNS 8.8.8.8"
    exit 0
fi
