#!/bin/bash

#limit pactl volume to 150%
max=$(pactl list sinks | awk -F '[^0-9]*' '/^[[:space:]]Volume:/ {print $3}')

if [[ $max -lt 150 ]] 
then
	pactl set-sink-volume @DEFAULT_SINK@ +5%
fi
