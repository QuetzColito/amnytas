#!/usr/bin/env bash
path=$(fzf --walker=file,hidden)
current=$(pwd)

echo
echo "Target: "
echo "\"$current/$path\""
echo "Start In: "
echo "\"$current/$(echo $path | rev | cut -d '/' -f2- | rev)\""
echo

echo "Saving Target to Clipboard"
wl-copy "\"$current/$path\""
