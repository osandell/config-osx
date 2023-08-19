#!/usr/bin/env bash

# touch /tmp/tomatoland.log

RUNTIME_DIR="/Users/olof/Library/Application Support"

# echo "Runtime directory: $1" >>/tmp/tomatoland.log

if [ -f "$RUNTIME_DIR/show-notification.pid" ]; then
    # This will just trigger the trap in notification-daemon.sh. It's not meant to kill the process.
    sudo -u olof kill -USR1 $(cat "$RUNTIME_DIR/show-notification.pid")
else
    echo "PID file not found"
    exit 1
fi
