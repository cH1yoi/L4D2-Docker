#!/bin/bash

echo "Starting L4D2 Server Update..."

cd /home/hana
./steamcmd.sh +force_install_dir ./l4d2 \
    +@sSteamCmdForcePlatformType linux \
    +login anonymous \
    +app_update 222860 validate \
    +quit

echo "Update completed!"
