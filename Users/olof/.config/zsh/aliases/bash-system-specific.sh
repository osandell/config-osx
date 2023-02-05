#!/bin/sh

################################################################################
# Fork                                                                         #
################################################################################
fUpdate() {
    osascript <<END
	tell application "System Events"
		set originalAppPid to the unix id of first process where it is frontmost
	end tell
    tell application "Fork" to activate
    delay 0.5
    tell application "System Events"
		set theprocs to every process whose unix id is originalAppPid
		repeat with proc in theprocs
			
			set frontmost of proc to true
		end repeat
	end tell
END
}

fUpdateMove() {
    osascript <<END
	tell application "System Events"
		set originalAppPid to the unix id of first process where it is frontmost
	end tell
    tell application "Fork" to activate
    delay 0.3
    tell application "System Events" to keystroke "0" using command down
        delay 0.1    
    repeat 10 times
        tell application "System Events" to key code 125
        delay 0.01
    end repeat
    repeat 20 times
        tell application "System Events" to key code 126
        delay 0.01
    end repeat
    delay 0.01
    tell application "System Events" to keystroke "0" using command down
    tell application "System Events"
		set theprocs to every process whose unix id is originalAppPid
		repeat with proc in theprocs
			
			set frontmost of proc to true
		end repeat
	end tell
END
}

repo() {
    REPO_PATH=""
    case "$1" in
    # Work
    ab)
        REPO_PATH="~/dev/olofgrebban/active-brands-frontend"
        ;;
    bb)
        REPO_PATH="~/dev/olofgrebban/bjorn-borg-frontend"
        ;;
    djerf)
        REPO_PATH="~/dev/olofgrebban/djerf-frontend"
        ;;
    rd)
        REPO_PATH="~/dev/olofgrebban/royal-web"
        ;;
    rd2)
        REPO_PATH="~/dev/olofgrebban/royal-web-2"
        ;;
    rd3)
        REPO_PATH="~/dev/olofgrebban/royal-web-3"
        ;;
    zoo)
        REPO_PATH="~/dev/olofgrebban/zoo-frontend"
        ;;

    # Personal
    default-browser-launcher)
        REPO_PATH="~/dev/osandell/default-browser-launcher"
        ;;
    scripts-osx)
        REPO_PATH="~/dev/osandell/scripts-osx"
        ;;
    set-window-boundaries)
        REPO_PATH="~/dev/osandell/set-window-boundaries"
        ;;
    *)
        echo $"Usage: $0 {name of repo}\n\nPress tab to see available repos"
        ;;
    esac

    bar="Fork"
    if [[ "$REPO_PATH" != "" ]]; then
        osascript -e '
        on run repoPath
            tell application "System Events"
                keystroke "open -a Fork " & repoPath
                key code 36                                       # 36 = enter
            end tell
        end run
        ' "$REPO_PATH" &
        osascript -e '
        on run repoPath
            delay 0.3
            tell application "iTerm"
                activate
            end tell
            # delay 0.3
            tell application "System Events"
                key code 17 using {command down}                # 17 = t
                key code 2 using {command down, shift down}     # 2 = n
                delay 0.5
                key code 126 using {command down, option down}  # 126 = up arrow
                keystroke repoPath
                key code 36                                     # 36 = enter
            end tell
            tell application "fork"
                activate
            end tell
            # delay 0.3
            tell application "iTerm"
                activate
            end tell
         end run
        ' "$REPO_PATH" &
    fi
}
complete -W "ab bb rd rd2 rd3 default-browser-launcher djerf zoo scripts-osx set-window-boundaries" repo
