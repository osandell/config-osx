#!/bin/bash

[ ! -f /usr/local/bin/switchaudiosource ] && /usr/local/bin/brew install switchaudio-osx

KEYWORD='nothing to commit'

OUTPUT=$(/usr/bin/git --git-dir=$HOME/.config-system-specific/ --work-tree=/ status)
if [[ "$OUTPUT" != *"$KEYWORD"* ]]; then
  /usr/local/bin/switchaudiosource -s "Högtalare i MacBook Pro"
  osascript -e '
    set Volume 3
    say "Dont forget to push system specific config!"
    '
fi

OUTPUT=$(/usr/bin/git --git-dir=$HOME/.config-shared/ --work-tree=$HOME status)
if [[ "$OUTPUT" != *"$KEYWORD"* ]]; then
  /usr/local/bin/switchaudiosource -s "Högtalare i MacBook Pro"
  osascript -e '
    set Volume 3
    say "Dont forget to push shared config!"
    '
fi

OUTPUT=$(cd /Users/olof/dev/osandell/default-browser-launcher && /usr/bin/git status)
if [[ "$OUTPUT" != *"$KEYWORD"* ]]; then
  /usr/local/bin/switchaudiosource -s "Högtalare i MacBook Pro"
  osascript -e '
    set Volume 3
    say "Dont forget to push default browser launcher!"
    '
fi

OUTPUT=$(cd /Users/olof/dev/osandell/scripts-osx && /usr/bin/git status)
if [[ "$OUTPUT" != *"$KEYWORD"* ]]; then
  /usr/local/bin/switchaudiosource -s "Högtalare i MacBook Pro"
  osascript -e '
    set Volume 3
    say "Dont forget to push mac os scripts!"
    '
fi



