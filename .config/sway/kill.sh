#!/bin/bash

n=$(swaymsg -t get_tree | jq '.. | select(.type?) | select(.focused==true).name')

# if curr_name starts with "mutt" or neomutt
if [[ $n == \"neomutt* ]] || [[ $n == \"mutt* ]]; then
	exit 0
fi

swaymsg kill

