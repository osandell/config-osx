#!/bin/bash

arg=$1

case $arg in
  "find-primary")
    script=$(cat <<END
tell application "System Events"
  set appName to name of first application process whose frontmost is true
  if appName is "kitty" then
      keystroke "f" using {control down}
  else
      keystroke "f" using {command down}
  end if
end tell
END
)
    osascript -e "$script"
    ;;
  "find-secondary")
    script=$(cat <<END
tell application "System Events"
  set appName to name of first application process whose frontmost is true
  if appName is "kitty" then
      keystroke "h" using {control down, shift down}
      delay 0.1
      keystroke "?"
  else
      keystroke "f" using {command down}
  end if
end tell
END
)
    osascript -e "$script"
    ;;
  "reload")
    osascript -e "tell application \"kmonad\" to quit" && sleep 1 && open -a /Applications/Kmonad.app
    ;;
  *)
    echo "Invalid argument: $arg"
    ;;
esac


