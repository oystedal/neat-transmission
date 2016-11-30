# /usr/bin/env bash

# -g: Use "runtime" as configuration (etc.) directory
# -w: Download files to the "runtime" directory
# -p: Use port 5011
./cli/transmission-cli -g runtime -w runtime -p 5011 ubuntu-16.10-desktop-amd64.iso.torrent
