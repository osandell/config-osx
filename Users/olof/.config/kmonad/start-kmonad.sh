#!/usr/bin/env bash

# killall kmonad

# script_dir=$(dirname "$0")

# config_file=~/.config/kmonad/defcfg.part

# output=$(timeout 0.5 evtest 2>&1)
# keyboard_line=$(echo "$output" | grep "Olof – Magic Keyboard")
# event_id=$(echo "$keyboard_line" | awk -F ':' '{print $1}')

# echo "$event_id" >"${script_dir}/bt-keyboard-id.txt"

# Check if the BT keyboard is connected
#if ls $event_id >/dev/null 2>&1; then
# If the device exists, check if the line is commented in the file
#   if grep -q ";; input (device-file \"$event_id\")" $config_file; then
# If so we activate BT keyboard by uncommenting both lines then comment internal kb line
#      sed -i -e "s|;; input (device-file \"$event_id\")|input (device-file \"$event_id\")|" -e 's/input (device-file "\/dev\/input\/by-id\/usb-Apple_Inc._Apple_Internal_Keyboard___Trackpad_FM710660210HYYKCP+RVZ-if01-event-kbd")/;; &/' $config_file
# fi
#else
# If BT keyboard is disconnected we make sure to activate internal
#   sed -i -e "s|;; input (device-file \"$event_id\")|input (device-file \"$event_id\")|" -e 's/input (device-file "\/dev\/input\/by-id\/usb-Apple_Inc._Apple_Internal_Keyboard___Trackpad_FM710660210HYYKCP+RVZ-if01-event-kbd")/;; &/' $config_file
#fi

cat "/Users/olof/.config/kmonad/defcfg.part" "/Users/olof/.config/kmonad/system-specific.part" "/Users/olof/.config/kmonad/shared.part" > "/Users/olof/.config/kmonad/kmonad.kbd"


/Users/olof/dev/osandell/kmonad/bin/kmonad "/Users/olof/.config/kmonad/kmonad.kbd"
