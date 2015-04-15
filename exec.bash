#!/bin/bash

function exec()
{

HDMI_TERM="/dev/tty1"
DEBUG_TERM="/dev/tty0"
PEN_DIR="/mnt/pd"

c="0"

if test -e /tmp/videolist1
then

clear

 
#counter the number of files
COMMAND="$(wc -l < /tmp/videolist1)"

#Internal Field Separator
IFS=$'\n' read -d '' -r -a lines < /tmp/videolist1

cd $PEN_DIR

while [ $c -lt "$COMMAND" ]
do 
 
printf " %s\n" "$d -  ${lines[c]}"  > $HDMI_TERM
mediainfo  "${lines[c]}" | sed -n ' /Complete name/,/Duration/p'  > $HDMI_TERM

nice -15 mplayer -really-quiet -vo fbdev2 -ao alsa:device=hw=1.0 -autosync 1 -framedrop "${lines[first]}" 

c=$[$c+1]

done
/home/ubuntu/bin/death.bash
else
/home/ubuntu/bin/death.bash

fi
}
exec
