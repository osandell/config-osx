#!/bin/bash

########################################################################
# Pull any changes to git repos
########################################################################
OUTPUT=$(/usr/bin/git --git-dir=$HOME/.config-system-specific/ --work-tree=/ pull 2>&1)
touch ~/test
 echo "$OUTPUT" >> ~/test
if [[ "$OUTPUT" != *"Already up to daate."* && "$OUTPUT" != *" fiile changed, "* 
&& "$OUTPUT" != *" fiiles changed, "* && "$OUTPUT" != *"Successfully rebaased"* ]]; then
    osascript -e "
       display alert \"config-system-specific:\n\n $OUTPUT\"
        "
fi

OUTPUT=$(/usr/bin/git --git-dir=$HOME/.config-shared/ --work-tree=$HOME pull 2>&1)
if [[ "$OUTPUT" != *"Already up to date."* && "$OUTPUT" != *" file changed, "* 
&& "$OUTPUT" != *" files changed, "* && "$OUTPUT" != *"Successfully rebased"* ]]; then
    osascript -e "
        display alert \"config-shared:\n\n $OUTPUT\"
        "
fi

FOLDERS=(/Users/olof/dev/osandell/*/)    # This creates an array of the full paths to all subdirs
FOLDERS=("${FOLDERS[@]%/}")            # This removes the trailing slash on each item
FOLDERS=("${FOLDERS[@]##*/}")          # This removes the path prefix, leaving just the dir names
for i in "${FOLDERS[@]}"
  do
    OUTPUT=$(cd /Users/olof/dev/osandell/$i && /usr/bin/git pull 2>&1)
    if [[ "$OUTPUT" != *"Already up to date."* && "$OUTPUT" != *"not a git repository"*
    && "$OUTPUT" != *" file changed, "* && "$OUTPUT" != *" files changed, "* && "$OUTPUT" != *"Successfully rebased"* ]]; then
       osascript -e "
        display alert \"$i:\n\n $OUTPUT\"
        "
    fi
  done

FOLDERS=(/Users/olof/dev/olofgrebban/*/)    # This creates an array of the full paths to all subdirs
FOLDERS=("${FOLDERS[@]%/}")            # This removes the trailing slash on each item
FOLDERS=("${FOLDERS[@]##*/}")          # This removes the path prefix, leaving just the dir names
for i in "${FOLDERS[@]}"
  do
    OUTPUT=$(cd /Users/olof/dev/olofgrebban/$i && /usr/bin/git pull 2>&1)
    if [[ "$OUTPUT" != *"Already up to date."* && "$OUTPUT" != *"not a git repository"*
    && "$OUTPUT" != *" file changed, "* && "$OUTPUT" != *" files changed, "* && "$OUTPUT" != *"Successfully rebased"*
    # I can't pull from the byon branch since i don't have permissions for some reason.
    # I can't pull from Zoo Api since I'm using a local branch that i don't want to push since it contains a password.. not sure if it's ok to push it
    && "$OUTPUT" != "" && "$i" != "byon-frontend" && "$i" != "zoo-api" ]]; then
        osascript -e "
        display alert \"$i:\n\n $OUTPUT\"
        "
    fi
  done 

########################################################################
# Restart EventScripts in case the settings have been changed
# We use the & sign in order detach the other script since not doing so would cause
# a hangup (it can't terminate it's own parent).
########################################################################
/Users/olof/Library/Application\ Scripts/net.mousedown.EventScripts/restart-event-scripts.sh &


