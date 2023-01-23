#!/bin/bash

ID=$(id -u)

if [ "$ID" != "0" ]; then
    echo "This command requires super user privilege - please run with sudo"
    exit 1
fi

mkdir -p $SNAP_COMMON/.cache
touch $SNAP_COMMON/.cache/file.dat

mkdir -p $SNAP_COMMON/generic
touch $SNAP_COMMON/generic/file.dat

mkdir -p $SNAP_DATA/excl-1
touch $SNAP_DATA/excl-1/file.log

mkdir -p $SNAP_DATA/excl-2
touch $SNAP_DATA/excl-2/file.log

mkdir -p $SNAP_DATA/state-info
touch $SNAP_DATA/state-info/state.dat



