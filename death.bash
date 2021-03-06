#!/bin/bash 

function death ()
{
HDMI_TERM="/dev/tty1"
DEBUG_TERM="/dev/tty0"
PEN_SEC="/mnt/pd2"

c="0"
d="1"


if test -e /tmp/videolist2
then

clear > $HDMI_TERM


#count the number of files
COMMAND="$(wc -l < /tmp/videolist2)"

#Internal Field Separator
IFS=$'\n' read -d '' -r -a lines < /tmp/videolist2

cd $PEN_SEC

while [ $c -lt "$COMMAND" ]
do

echo '' > $HDMI_TERM
echo '' > $HDMI_TERM


printf " %s\n" "$d de $COMMAND -  ${lines[c]}"  > $HDMI_TERM
mediainfo  "${lines[c]}" | sed -n ' /Complete name/,/Duration/p'  > $HDMI_TERM

sleep 1
clear > $HDMI_TERM
nice -15 mplayer -really-quiet -vo fbdev2 -ao alsa:device=hw=1.0 -autosync 1 -framedrop "${lines[first]}"

c=$[$c+1]
c=$[$c+1]
done
/home/ubuntu/bin/startup.bash
else
/home/ubuntu/bin/startup.bash

fi
}
death
