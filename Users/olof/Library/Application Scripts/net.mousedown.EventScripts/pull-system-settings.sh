#!/bin/bash

/usr/bin/git --git-dir=$HOME/.config-system-specific/ --work-tree=/ pull
/usr/bin/git --git-dir=$HOME/.config-shared/ --work-tree=$HOME pull
cd /Users/olof/dev/osandell/default-browser-launcher && /usr/bin/git pull
cd /Users/olof/dev/osandell/scripts-osx/ && /usr/bin/git pull

# Restart EventScripts in case the settings have been changed
# We use the & sign in order detach the other script since not doing so would cause
# a hangup (it can't terminate it's own parent).
/Users/olof/Library/Application\ Scripts/net.mousedown.EventScripts/restart-event-scripts.sh &


