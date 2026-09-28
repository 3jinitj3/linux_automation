#!/bin/bash

# Verify root user.
if [[ ! $EUID -eq 0 ]]; then
	echo "Permission Denied: Root privileges only."
	exit 1
fi

# Free disk space variable.
rootfs_free=$(df /root | sed -n '2p' | awk '{print $4}')

# Define clean directory function.
cleanDir(){
	local dir=$1

	rm -rf "$dir"/* "$dir"/.[!.]* "$dir"/..?*
}

# Subdirectories variable.
subdir=('/var/log' '$HOME/.cache')

# Echo current disk space before cleaning.
echo "Current root file system free disk space BEFORE cleaning: $rootfs_free"; echo

# Loop to delete directories.
for dir in "${subdir[@]}";do #Expands the element inside the array while preserving spaces with ""
	echo "Cleaning subdirectory $dir...."
	echo
	cleanDir "$dir"
	sleep 5;
done

# New disk space variable.
new_disk_space=$(df /root | sed -n '2p' | awk '{print $4}')

# Disk difference variable.
disk_diff=$(($new_disk_space - $rootfs_free))
echo "Previous disk space available: '$rootfs_free'"
echo "New disk space available: '$new_disk_space'"; echo

# Final print logic
if [[ $disk_diff -gt 0 ]]; then
	echo "Disk space recovered: '$disk_diff'"
else
	echo "No significant disk space was freed"
fi





