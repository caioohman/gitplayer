#!/bin/bash

function exec()
{

HDMI_TERM="/dev/tty1"
DEBUG_TERM="/dev/tty0"
PEN_DIR="/mnt/pd"

c="0"
d="1"

if test -e /tmp/videolist1
then

clear > $HDMI_TERM


 
#counter the number of files
COMMAND="$(wc -l < /tmp/videolist1)"

#Internal Field Separator
IFS=$'\n' read -d '' -r -a lines < /tmp/videolist1

cd $PEN_DIR

while [ $c -lt "$COMMAND" ]
do 
 

echo '' > $HDMI_TERM
echo '' > $HDMI_TERM


printf " %s\n" "$d de $COMMAND  -  ${lines[c]}"  > $HDMI_TERM
mediainfo  "${lines[c]}" | sed -n ' /Complete name/,/Duration/p'  > $HDMI_TERM

sleep 1
clear > $HDMI_TERM
nice -15 mplayer -really-quiet -vo fbdev2 -ao alsa:device=hw=1.0 -autosync 1 -framedrop "${lines[first]}" 

c=$[$c+1]
d=$[$c+1]

done
/home/ubuntu/bin/death.bash
else
/home/ubuntu/bin/death.bash

fi
}
exec
