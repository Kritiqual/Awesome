#!/bin/sh

run() { if ! pgrep -f "$1"; then "$@" & fi }
run lxpolkit
# run oneko
run xcape -e Caps_Lock=Escape
run xset r rate 175 60
run ibus-daemon -drx
run imwheel -b 0
# run picom -b --config ~/.dots/home/.config/picom/picom.conf --experimental-backends
