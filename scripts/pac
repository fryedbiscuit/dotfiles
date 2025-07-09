#!/bin/bash

list=$(paru -Sl --color=always|fzf -m --ansi|cut -d" " -f2)

if [ -n "$list" ]; then
        echo "$list" | paru -S -
fi
