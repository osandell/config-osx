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
    rd)
        REPO_PATH="~/dev/olofgrebban/royal-web"
        ;;
    rd2)
        REPO_PATH="~/dev/olofgrebban/royal-web-2"
        ;;
    rd3)
        REPO_PATH="~/dev/olofgrebban/royal-web-3"
        ;;
    djerf)
        REPO_PATH="~/dev/olofgrebban/djerf-frontend"
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

    if [[ "$REPO_PATH" != "" ]]; then
        osascript -e '
        on run repoPath
            tell application "System Events"
                key code 17 using {command down}
                key code 2 using {command down, shift down}
                delay 0.5
                key code 126 using {command down, option down}
                keystroke repoPath
                key code 36
                delay 2
                keystroke "open -a Fork ."
                key code 36
                delay 0.5
                key code 48 using {command down}
                delay 1
                keystroke "gu"
                key code 36
                delay 5
                key code 40 using {command down}
            end tell
        end run
        ' "$REPO_PATH"
    fi
}
complete -W "ab rd rd2 rd3 default-browser-launcher djerf scripts-osx set-window-boundaries" repo
