#!/bin/bash

# Create user variable.
username=$1

# Verify root user.
if [[ ! $EUID -eq 0 ]]; then
    echo "PERMISSION DENIED: Only the root user can execute this script"
    exit 1
fi

# Verify argument requirement is provided.
if [[ $# -eq 0 ]]; then
    echo "ERROR: <username> argument is not provided. Existing script."
    exit 1
fi

#Verify that the user exist.
if ! id "$username" &>/dev/null; then
    echo "User $username does not exist."
    echo
fi

# Confirmation to delete the user.
echo "Are you sure you want to delete user $username."
read -rp "Confirm: [Y/N]" ynYN
if [[ "$ynYN" =~ ^[yY]$ ]]; then
    echo "Confirmation received."
    echo
    echo "Deleting user $username..."
    sleep 3
    deluser --remove-home "$username"
    echo
elif [ "$ynYN" =~ ^[nN]$ ]; then
    echo "User deletion canceled."
fi

# Display /etc/passwd to confirm deletion.
echo "Confirmation of user deletion is below."
echo
cat /etc/passwd
echo

# Final demo
echo "RUN SCRIPT WITHOUT ARGUMENTS, WITH ARGUMENTS AND SWITCH TO DELETED USER TO CONFIRM DELETION."
