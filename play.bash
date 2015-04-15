#!/bin/bash  


function play()
{
 

HDMI_TERM="/dev/tty1"
DEBUG_TERM="/dev/tty0"
PEN_SEC="/mnt/pd2/"

if test -e /tmp/list2
then

clear > $HDMI_TERM


c="0"
d="1"

#count the number of files
COMMAND="$(wc -l < /tmp/list2)"

#Internal Field Separator
IFS=$'\n' read -d '' -r -a lines < /tmp/list2

cd $PEN_SEC

while [ $c -lt "$COMMAND" ]
do 

echo '' > $HDMI_TERM
echo '' > $HDMI_TERM

printf " %s\n" "$d de $COMMAND -  ${lines[c]}"  > $HDMI_TERM
mediainfo  "${lines[c]}" | sed -n ' /Track name/,/Genre/p'  > $HDMI_TERM

mplayer -really-quiet -ao alsa:device=hw=1.0 "${lines[c]}" 

c=$[$c+1]
d=$[$c+1]
done
/home/ubuntu/bin/startup.bash
fi
/home/ubuntu/bin/startup.bash
}
play
