#!/bin/bash

# Ping google
if ! ping -c5 google.com &>/dev/null; then
    echo "ERROR: Unable to reach google.com"
    exit 1
else
    echo "Success: Network is up."
    exit 0
fi

