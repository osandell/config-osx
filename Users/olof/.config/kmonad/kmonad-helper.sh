#!/bin/bash

arg=$1

case $arg in
"find-primary")
  script=$(
    cat <<END
tell application "System Events"
  set frontApp to first application process whose frontmost is true
  set appID to bundle identifier of frontApp
  if appID is "net.kovidgoyal.kitty" or appID is "com.vscodium" or appID is "com.vscode" then
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
  script=$(
    cat <<END
tell application "System Events"
  set frontApp to first application process whose frontmost is true
  set appID to bundle identifier of frontApp
  if appID is "net.kovidgoyal.kitty" then
      keystroke "h" using {control down, shift down}
      delay 0.1
      keystroke "?"
  else if appID is "com.vscodium" or appID is "com.vscode" then
      keystroke "f" using {control down, option down}
  else
      keystroke "f" using {command down}
  end if
end tell
END
  )
  osascript -e "$script"
  ;;
"open")
  script=$(
    cat <<END
tell application "System Events"
  set frontApp to first application process whose frontmost is true
  set appID to bundle identifier of frontApp
  if appID is "com.vscodium" or appID is "com.vscode" then
      keystroke "o" using {control down, option down}
  else
      keystroke "o" using {command down}
  end if
end tell
END
  )
  osascript -e "$script"
  ;;
"close-tab")
  script=$(
    cat <<END
tell application "System Events"
  set frontApp to first application process whose frontmost is true
  set appID to bundle identifier of frontApp
      keystroke "w" using {command down}
end tell
END
  )
  osascript -e "$script"
  ;;
"command-palette")
  script=$(
    cat <<END
tell application "System Events"
  set frontApp to first application process whose frontmost is true
  set appID to bundle identifier of frontApp
  if appID is "com.vscodium" or appID is "com.vscode" then
      keystroke "p" using {control down}
  end if
end tell
END
  )
  osascript -e "$script"
  ;;
"rmeta-h")
  script=$(
    cat <<END
tell application "System Events"
  set frontApp to first application process whose frontmost is true
  set appID to bundle identifier of frontApp
  if appID is "net.kovidgoyal.kitty" then
      -- open command history
      keystroke "r" using {control down}
  else
      keystroke "o" using {command down}
  end if
end tell
END
  )
  osascript -e "$script"
  ;;
"increase-brightness")
  brightness $(echo "scale=2; ((64 * $(brightness -l | grep 'brightness' | awk '{print $4}')) + 6.4)/64" | bc)
  ;;
"decrease-brightness")
  brightness $(echo "scale=2; ((64 * $(brightness -l | grep 'brightness' | awk '{print $4}')) - 6.4)/64" | bc)
  ;;
"reload")
  osascript -e "tell application \"kmonad\" to quit" && sleep 1 && open -a /Applications/Kmonad.app
  ;;
*)
  echo "Invalid argument: $arg"
  ;;
esac
