#!/bin/bash

# Verify DNS for example website by resolving IP address.
if nslookup example.com 2>/dev/null; then
    echo
    echo "DNS resolution successful."
    exit 0
else
    ech0
    echo "DNS resolution for www.example.com FAILED."
    exit 1
fi

