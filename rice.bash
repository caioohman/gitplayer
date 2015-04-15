#!/bin/bash 

function rice()
{

HDMI_TERM="/dev/tty1"
DEBUG_TERM="/dev/tty0"
PEN_DIR="/mnt/pd"



if test -e /tmp/list1
then

clear > $HDMI_TERM


c="0"
d="1"

#count the number of files
COMMAND="$(wc -l < /tmp/list1)"

#Internal Field Separator
IFS=$'\n' read -d '' -r -a lines < /tmp/list1

cd $PEN_DIR

while [ $c -lt "$COMMAND" ]
do

echo '' > $HDMI_TERM
echo '' > $HDMI_TERM

printf " %s\n" "$d de $COMMAND -  ${lines[c]}"  > $HDMI_TERM
mediainfo "${lines[c]}" | sed -n ' /Track name/,/Genre/p'  > $HDMI_TERM
 


mplayer -really-quiet -ao alsa:device=hw=1.0 "${lines[c]}"

c=$[$c+1]
d=$[$d+1]
done

/home/ubuntu/bin/play.bash
else
/home/ubuntu/bin/play.bash

fi
}
rice





