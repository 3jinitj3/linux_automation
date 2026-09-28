#!/bin/bash

# Verify root user.
if [[ ! $EUID -eq 0 ]]; then
    echo "PERMISSION DENIED: Only a root user can execute this file"
    exit 1
fi 

# Original size of /etc | -b=bytes, -s=summarize
etc_current_size=$(du -sb /etc | awk '{print $1}')

# File size function.
fileSize(){
    local file="$1"
    # stat is used to display file system status
    stat -c%s "$file" 2>/dev/null # -c=format, %s=total size in bytes
}

# Getting the size of file; bzip2 | j=bzip2 compressin, c=create, f=archive file
echo "Archiving and compressing /etc directory with bzip2..."; echo
tar -cjf $HOME/etc_archive.tar.bz2 /etc # Used for ceating, extracting and managing archive files.
bz2_size=$(fileSize "$HOME/etc_archive.tar.bz2")
sleep 5


# Getting the size of file; gzip
echo "Archiving and compressing /etc directory with gzip..."; echo
tar -czf "$HOME/etc_archive.tar.gz" /etc
gzip_size=$(fileSize "$HOME/etc_archive.tar.gz")
sleep 5

# Format block printing for organization. 
echo
printf "%-15s %-15s %-20s\n" "Command" "Original_Size" "Compressed_Size"
printf "%-15s %-15s %-20s\n" "---------------" "---------------" "--------------------"

printf "%-15s %-15s %-20d\n" "bzip2" "$etc_current_size" "$bz2_size"
printf "%-15s %-15s %-20d\n" "gzip" "$etc_current_size" "$gzip_size"
echo

echo "Calculating compression size ratios to determine the tool with the best performance..."; echo
sleep 5

# Create compression ratios for each tool
bz2_ratio=$(( (etc_current_size - bz2_size) * 100 / etc_current_size ))
gzip_ratio=$(( (etc_current_size - gzip_size)* 100 / etc_current_size ))

# The difference in size of the two compression algorithms.
if ((bz2_size < gzip_size)); then
    diff=$(( gzip_size - bz2_size ))
    echo "bzip2 produced a smaller archive by $diff bytes."; echo
else
    diff=$(( bz2_size - gzip_size ))
    echo "gzip produced a smaller archive by $diff bytes."; echo
fi
    

# Decision logic based on the lowest ratio.
if [[ "$bz2_ratio" -gt "$gzip_ratio" ]]; then
    echo "The tool with the best compression ratio is bzip2 with $bz2_ratio% reduction."; echo
else
    echo "The tool with the best compression ratio is gzip with $gzip_ratio% reduction."; echo
fi

