#!/bin/bash

function random()
{

HDMI_TERM="/dev/tty1"
DEBUG_TERM="/dev/tty0"
PEN_DIR="/mnt/pd"
PEN_SEC="/mnt/pd2/"

c="0"
 

COMMAND="$(find $PEN_DIR $PEN_SEC -maxdepth 1 -type f -iregex ".*\.\(mp4\|mkv\|avi\|mpg\)$" | wc -l)"
clear 

#print number of files
echo "numero de arquivos de vídeo listados - $COMMAND"

#need to list subdirectories
cd $PEN_DIR && ls -1 *.{mp4,mkv,avi,mpg} > /tmp/videolist  2> /dev/null
cd $PEN_SEC && ls -1 *.{mp3,acc,flac,ogg}  >> /tmp/list  2> /dev/null

#Internal Field Separator
IFS=$'\n' read -d '' -r -a lines < /tmp/videolist

while [ $c -lt "$COMMAND" ]
do 
 
printf " %s\n" "$d -  ${lines[c]}" 
mediainfo  "${lines[c]}" | sed -n ' /Complete name/,/Duration/p'

nice -15 mplayer -really-quiet -vo fbdev2 -ao alsa:device=hw=1.0 -autosync 1 -framedrop "${lines[first]}" &

}

random
