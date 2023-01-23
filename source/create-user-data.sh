#!/bin/bash

ID=$(id -u)

if [ "$ID" == "0" ]; then
    echo "This command should avoid super user privilege - please run without sudo"
    exit 1
fi

mkdir -p $SNAP_USER_COMMON/tmp
touch $SNAP_USER_COMMON/tmp/file.tmp

mkdir -p $SNAP_USER_COMMON/generic
touch $SNAP_USER_COMMON/generic/file.dat

mkdir -p $SNAP_USER_DATA/large-files
touch $SNAP_USER_DATA/large-files/large-file-not-used.bin
touch $SNAP_USER_DATA/large-files/large-file-not-used.dat
touch $SNAP_USER_DATA/large-files/large-file-used.bin
