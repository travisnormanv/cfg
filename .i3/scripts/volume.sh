#!/bin/bash

# get volume w/ pactl
vol=$(pactl list sinks | awk -F '[^0-9]*' '/^[[:space:]]Volume:/ {print $3}')

mute=$(pactl list sinks | awk '/^[[:space:]]Mute:/ {print $2}')
mute_yes="yes"

icon_mu=""
icon_up=""
icon_dn=""
icon_no=""
icon=""

vol_ch=50
vol_no=0

if [ $vol -lt $vol_ch ] && [ $vol -ne $vol_no ]
then
	icon=$icon_dn
elif [ $vol -ge $vol_ch ] && [ $vol -ne $vol_no ]
then
	icon=$icon_up
else
	icon=$icon_no
fi

if [ "$mute" = "$mute_yes" ]
then
	echo "$icon_mu $vol%"
else
	echo "$icon $vol%"
fi
