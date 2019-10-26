#!/bin/bash
ARTIST=$(playerctl metadata | grep 'xesam:artist' | cut -d' ' -f5- | sed 's/^[ \t]*//')
TITLE=$(playerctl metadata title)

if [ -n "$ARTIST" ]; then
	echo "$ARTIST - $TITLE"
else
	echo "$TITLE"
fi
