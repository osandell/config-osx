#!/bin/bash

arg=$1

case $arg in
"find-primary")
  script=$(
    cat <<END
tell application "System Events"
  set frontApp to first application process whose frontmost is true
  set appID to bundle identifier of frontApp
  if appID is "net.kovidgoyal.kitty" or appID is "com.vscodium" or appID is "com.microsoft.vscode" then
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
  else if appID is "com.vscodium" or appID is "com.microsoft.vscode" then
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
  if appID is "com.vscodium" or appID is "com.microsoft.vscode" then
      keystroke "o" using {control down, option down}
  else
  say appID
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
  if appID is "com.vscodium" or appID is "com.microsoft.vscode" then
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
"lmet-w")
  script=$(
    cat <<END
    tell application "System Events"
      keystroke "s" using {command down}
    end tell
END
  )
  osascript -e "$script"
  ;;
"cmd-delete") 
  script=$(
    cat <<END
    tell application "System Events"
      keystroke "s" using {command down}
    end tell
END
  )
  osascript -e "$script"
  ;;
"lmet-z") 
  script=$(
    cat <<END
    tell application "System Events"
      keystroke "c" using {control down}
    end tell
END
  )
  osascript -e "$script"
  ;;
"q-w") 
  script=$(
    cat <<END
    tell application "System Events"
      keystroke "t" using {command down}
    end tell
END
  )
  osascript -e "$script"
  ;;
"toggle-window-in-app") 
  script=$(
    cat <<END
    tell application "System Events"
      keystroke tab using {command down, control down, shift down}    
      
    end tell
END
  )
  osascript -e "$script"
  ;;
"delete") 
  script=$(
    cat <<END
   tell application "System Events"
  set frontApp to first application process whose frontmost is true
  set appID to bundle identifier of frontApp
  if appID is "com.apple.finder" then
      keystroke (ASCII character 8) using command down  -- move to trash
  else  
      keystroke (ASCII character 127) -- delete
  end if
end tell
END
  )
  osascript -e "$script"
  ;;
*)
  echo "Invalid argument: $arg"
  ;;
esac

