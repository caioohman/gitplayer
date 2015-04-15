#!/bin/bash 

function rice()
{

HDMI_TERM="/dev/tty1"
DEBUG_TERM="/dev/tty0"
PEN_DIR="/mnt/pd"



if test -e /tmp/list1
then

clear

c="0"

#count the number of files
COMMAND="$(wc -l < /tmp/videolist2)"

#Internal Field Separator
IFS=$'\n' read -d '' -r -a lines < /tmp/list1

cd $PEN_DIR

while [ $c -lt "$COMMAND" ]
do

printf " %s\n" "$d -  ${lines[c]}"  > $HDMI_TERM
mediainfo "${lines[c]}" | sed -n ' /Track name/,/Genre/p'  > $HDMI_TERM

mplayer -really-quiet -ao alsa:device=hw=1.0 "${lines[c]}"

c=$[$c+1]
done

/home/ubuntu/bin/play.bash
else
/home/ubuntu/bin/play.bash

fi
}
rice





