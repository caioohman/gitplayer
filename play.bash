#!/bin/bash -xv 


function random()
{

c="0" 

HDMI_TERM="/dev/tty1"
DEBUG_TERM="/dev/tty0"
PEN_DIR="/mnt/pd"
PEN_SEC="/mnt/pd2/"

# test if it checks even subdirectories
COMMAND="$(find $PEN_DIR $PEN_SEC -maxdepth 1 -type f -iregex ".*\.\(aac\|flac\|mp3\|ogg\|wav\)$" | wc -l)"
clear

#print number of files
echo "numero de arquivos de audio listados - $COMMAND" 

#need to list subdirectories
cd $PEN_DIR && ls -1 *.{mp3,acc,flac,ogg}  > /tmp/list  2> /dev/null
cd $PEN_SEC && ls -1 *.{mp3,acc,flac,ogg}  >> /tmp/list  2> /dev/null


IFS=$'\n' read -d '' -r -a lines < /tmp/list

while [ $c -lt "$COMMAND" ]
do 
printf " %s\n" "$d -  ${lines[c]}" 
mediainfo  "${lines[c]}" | sed -n ' /Track name/,/Genre/p'

mplayer -really-quiet -ao alsa:device=hw=1.0 "${lines[c]}" 

c=$[$c+1]
done

}
random
