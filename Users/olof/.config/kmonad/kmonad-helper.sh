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
  else if appID is "com.google.Chrome" then
      keystroke "p" using {command down, shift down}
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
  script=$(
    cat <<END
    tell application "System Events"
      set frontApp to first application process whose frontmost is true
      set appID to bundle identifier of frontApp
      if appID is "com.google.Chrome" then 
          keystroke "l" using {command down}
      else
          keystroke "s" using {command down}   
      end if
    end tell
END
  )
  execute_script "$script"
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
      set frontApp to first application process whose frontmost is true
      set appID to bundle identifier of frontApp
      if appID is "com.google.Chrome" or appID is "org.mozilla.firefox" then
          keystroke "[" using {command down}
      end if
    end tell
END
  )
  execute_script "$script"
  ;;

"lmet-d")
  script=$(
    cat <<END
    tell application "System Events"
      set frontApp to first application process whose frontmost is true
      set appID to bundle identifier of frontApp
       if appID is "com.google.Chrome" or appID is "org.mozilla.firefox" then
          keystroke "]" using {command down}
      end if
    end tell
END
  )
  execute_script "$script"
  ;;

"lmet-q-f")
  script=$(
    cat <<END
tell application "System Events"
  set frontApp to first application process whose frontmost is true
  set appID to bundle identifier of frontApp
  if appID is "com.google.Chrome" then
        key code 33 using {command down} # å on swe, [ on eng
  end if
end tell
END
  )
  execute_script "$script"
  ;;

"lmet-q-p")
  script=$(
    cat <<END
    tell application "System Events"
      set frontApp to first application process whose frontmost is true
      set appID to bundle identifier of frontApp
      if appID is "com.google.Chrome" or appID is "com.microsoft.vscode" then
          keystroke "]" using {command down}
      end if
    end tell
END
  )
  execute_script "$script"
  ;;

"new-tab")
  script=$(
    cat <<END
tell application "System Events"
  set frontApp to first application process whose frontmost is true
  set appID to bundle identifier of frontApp
  if appID is "com.microsoft.vscode" then
       key code 45 using command down
  else if appID is "com.google.Chrome" then
      key code 41 using command down # ;
  else if appID is "net.kovidgoyal.kitty" then
      keystroke "t" using {control down, shift down} 
  else
      keystroke "t" using {command down} 
  end if
end tell
END
  )
  execute_script "$script"
  ;;

"duplicate-tab")
  script=$(
    cat <<END
tell application "System Events"
  set frontApp to first application process whose frontmost is true
  set appID to bundle identifier of frontApp
  if appID is "com.google.Chrome" then
     tell application "Google Chrome"
         tell front window to make new tab with properties {URL:URL of active tab}
     end tell
  else if appID is "org.mozilla.firefox" then
    keystroke "d" using {option down, shift down}   
  end if
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

"toggle-notifications")
  sudo -u olof touch /Users/olof/Library/Application\ Support/show-notification
  ;;

"rmet-i")
  script=$(
    cat <<END
tell application "System Events"
  set frontApp to first application process whose frontmost is true
  set appID to bundle identifier of frontApp
  if appID is "com.google.Chrome" then
      keystroke "i" using {option down, command down}
  end if
end tell
END
  )
  execute_script "$script"
  ;;

"volume-up")
  script=$(
    cat <<END
    tell application "Noteland" to volup
END
  )
  execute_script "$script"
  ;;

"volume-down")
  script=$(
    cat <<END
    tell application "Noteland" to voldown
END
  )
  execute_script "$script"
  ;;

"mute")
  script=$(
    cat <<END
    tell application "Noteland" to mute
END
  )
  execute_script "$script"
  ;;

*)
  echo "Invalid argument: $arg"
  ;;
esac
