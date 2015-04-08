#!/bin/bash

function videos()
{

HDMI_TERM="/dev/tty1"
DEBUG_TERM="/dev/tty0"
PEN_DIR="/mnt/pd"

c="0" 
d="1"
e="1"
 

COMMAND="$(find /mnt/pd/ -maxdepth 1 -type f -iregex ".*\.\(mp4\|mkv\|avi\|mpg\)$" | wc -l)"
 
clear

#print number of files
echo "numero de arquivos de vídeo listados - $COMMAND"

#need to list subdirectories
cd /mnt/pd/ && ls -1 *.{mp4,mkv,avi,mpg} > /tmp/videolist  2> /dev/null


IFS=$'\n' read -d '' -r -a lines < /tmp/videolist

echo "" 
echo "  -   Este menu é de escolha dos arquivos de vídeo desejados  - " 
echo "  -   A cada numero que escolher,  aperte enter - " 
echo "  -   Senão quiser nenhum dos arquivos listados, somente aperte enter ou espere aparecer a próxima tela" 
echo ""
echo ""


sleep 4

while [ $c -lt "$COMMAND" ]
do 
 
printf " %s\n" "$d -  ${lines[c]}" 
mediainfo  "${lines[c]}" | sed -n ' /Complete name/,/Duration/p'

echo ""
echo ""

# this  will wait for  5 audio files
if test $e -eq 2
then
#
echo "Digite os números desejados"

# -t is for timeout (seconds)
# -a parameter means array
read  -t 30 choice_one
read  -t 30 choice_two

first=$(($choice_one - 1))
second=$(($choice_two - 1))

sleep 2

if test $first -gt -1
then
echo 'Executando primeira escolha'
sleep 2
nice -15 mplayer -really-quiet -vo fbdev2 -ao alsa:device=hw=1.0 -autosync 1 -framedrop "${lines[first]}" &
fi

if test $second -gt -1
then
echo 'Executando segunda escolha'
sleep 2
nice -15 mplayer -really-quiet -vo fbdev2 -ao alsa:device=hw=1.0 -autosync 1 -framedrop "${lines[second]}" &
fi

clear
e="0"
fi

sleep 5

c=$[$c+1]
d=$[$d+1]
e=$[$e+1]


done



}
videos





