#!/bin/bash

execute_script() {
  sudo -u olof osascript -e "$1"
}

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
  else if appID is "com.tinyspeck.slackmacgap" or appID is "com.vscodium" or appID is "com.microsoft.vscode" then
  	tell process "Slack"
		  click menu item "Search" of menu "Edit" of menu bar 1
	  end tell
  else
      keystroke "f" using {command down}
  end if
end tell
END
  )
  execute_script "$script"
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
  execute_script "$script"
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
  execute_script "$script"
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
  execute_script "$script"
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
  execute_script "$script"
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
  else if appID is "com.vscodium" or appID is "com.microsoft.vscode" then
      keystroke "r" using {control down}
  else
      keystroke "o" using {command down}
  end if
end tell
END
  )
  execute_script "$script"
  ;;
"increase-brightness")
  brightness $(echo "scale=2; ((64 * $(brightness -l | grep 'brightness' | awk '{print $4}')) + 6.4)/64" | bc)
  ;;
"decrease-brightness")
  brightness $(echo "scale=2; ((64 * $(brightness -l | grep 'brightness' | awk '{print $4}')) - 6.4)/64" | bc)
  ;;
"reload")
  sudo -u olof osascript -e "tell application \"kmonad\" to quit" && sleep 1 && open -a /Applications/Kmonad.app
  ;;
"lmet-w")
  sudo -u olof osascript -e "tell application \"System Events\" to keystroke \"s\" using {command down}"
  ;;
"lmet-z")
  sudo -u olof osascript -e "tell application \"System Events\" to keystroke \"c\" using {control down}"
  ;;
"lmet-x")
  script=$(
    cat <<END
    set originalApp to name of (info for (path to frontmost application) as alias)
    tell application "Google Chrome" to activate
    tell application "System Events"
      keystroke "r" using {command down}
    end tell
    tell application originalApp to activate
END
  )
  execute_script "$script"
  ;;
"lmet-c")
  script=$(
    cat <<END
    tell application "System Events"
      #  key code 26 using {shift down, option down}"   TODO: fix this
    end tell
END
  )
  execute_script "$script"
  ;;
"lmet-d")
  script=$(
    cat <<END
    tell application "System Events"
      keystroke "ä" using {command down}
    end tell
END
  )
  execute_script "$script"
  ;;
"q-w")
  script=$(
    cat <<END
    tell application "System Events"
      keystroke "t" using {command down}
    end tell
END
  )
  execute_script "$script"
  ;;
"toggle-window-in-app")
  script=$(
    cat <<END
    tell application "System Events"
      keystroke tab using {command down, control down, shift down}    
      
    end tell
END
  )
  execute_script "$script"
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
  execute_script "$script"
  ;;
"to-internal-screen")
  sudo -u olof /Users/olof/dev/osandell/scripts-osx/eventscripts-helper/position-all-windows.sh
  /Users/olof/.config/kmonad/switch-to-internal-keyboard.sh
  ;;
"to-external-screen")
  sudo -u olof /Users/olof/dev/osandell/scripts-osx/eventscripts-helper/position-all-windows.sh
  /Users/olof/.config/kmonad/switch-to-external-keyboard.sh
  ;;
"screenshot")
  script=$(
    cat <<END
   tell application "System Events"
    key code 21 using {command down, shift down}
   end tell
END
  )
  execute_script "$script"
  ;;
"backslash")
  script=$(
    cat <<END
  tell application "System Events"
      key code 27 using {command down, shift down}
  end tell
END
  )
  execute_script "$script"
  ;;

*)
  echo "Invalid argument: $arg"
  ;;
esac
