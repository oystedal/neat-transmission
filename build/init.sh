#! /usr/bin/env bash

# I prefer building with ninja, specify -G Ninja to use this instead of make.

cmake \
    -DENABLE_DAEMON=0 \
    -DENABLE_UTILS=0 \
    -DENABLE_UTP=0 \
    -DENABLE_GTK=0 \
    -DENABLE_QT=0 \
    -DENABLE_CLI=1 \
    -DINSTALL_DOC=0 \
    ..

echo "============================================================"
echo "Make a symlink or copy libneat.so.0 from the neat directory"
echo "Example: ln -s ~/path/to/neat/libneat.so.0 ."
echo "============================================================"
