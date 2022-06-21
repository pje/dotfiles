#!/bin/bash
# braindump of things I can never remember

# sort all directories by size
find . -mindepth 1 -maxdepth 1 -type d | parallel du -s | sort -rn

# list all open ports
sudo lsof -i -P | grep -i "listen"

# like strace for open files, without slowing down target
sudo opensnoop -p

# unix timestamp
date +%s
