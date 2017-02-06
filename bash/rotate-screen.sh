#!/bin/bash

SCN=$(xrandr | grep ' connected' | awk '{print $0;}' | sed -e 's/\s.*$//')

export TYPE=$1
echo 'Rotating ' $SCN ' to ' $TYPE

xrandr --output $SCN --rotate $TYPE
