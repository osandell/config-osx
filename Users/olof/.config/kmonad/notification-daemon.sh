#!/usr/bin/env bash

while true; do
    if [ -f "/Users/olof/Library/Application Support/show-notification" ]; then
        formatted_datetime=$(printf "%-36s %22s" "$(date "+%a %d %b")" "$(date "+%H:%M")")
        terminal-notifier -message "⠀"$'\n'"$(cat "/Users/olof/Library/Application Support/tomatoland")" -title "$formatted_datetime"
        rm "/Users/olof/Library/Application Support/show-notification"
    else
        sleep 0.1
    fi
done
