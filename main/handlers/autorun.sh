#!/bin/sh
run() { if ! pgrep -f "$1"; then "$@" & fi }

run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
# run oneko
run xcape -e Caps_Lock=Escape
run ibus-daemon -drx
run imwheel -b 0
# run picom -b
