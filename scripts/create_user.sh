#!/bin/bash

# Create username variable
username=$1

# Verify that EUID -eq 0
if [[ ! $EUID -eq 0 ]]; then
    echo "Permission Denied: Only the root user can execute this script"
    exit 1
fi

# Verify that variable is provided
if [[ $# -eq 0 ]]; then 
    echo "ERROR: <username> argument is not provided."
    exit 1
fi

# Verify dev_group exist; if missing add it
if ! getent group dev_group &>/dev/null; then
    echo 'dev_group does not exist, creating it now...'
    sleep 3
else
    echo "dev_group already exist."
    echo
fi

# Add user and assign password
echo 'Adding user $username and creating home directory....'
sleep 3
useradd -m $username
echo
echo "Create $username temporary password"
echo
passwd $username

# Display /etc/passwd file
echo "Human readable verification is below."
echo
cat /etc/passwd
echo
echo "Also, I have provided the system search results for user $username below."
echo
grep "$username" /etc/passwd
echo

# Demostration of user creation.
echo "SWITCH TO NEW USER, AND FORCE A CHANGE OF PASSWORD, MY WORK HERE IS DONE."



        
    