#!/bin/bash 


function files()
{

HDMI_TERM="/dev/tty1"
DEBUG_TERM="/dev/tty0"
PEN_DIR="/mnt/pd/"
PEN_SEC="/mnt/pd2/"

c="0" 
d="1"
e="1"

# test if it checks even subdirectories
COMMAND="$(find $PEN_DIR $PEN_SEC -maxdepth 1 -type f -iregex ".*\.\(aac\|flac\|mp3\|ogg\|wav\)$" | wc -l)"
clear

#print number of files
echo "numero de arquivos de audio listados - $COMMAND" 

#need to list subdirectories
cd $PEN_DIR && ls -1 *.{mp3,acc,flac,ogg}  >> /tmp/list  2> /dev/null
cd $PEN_SEC && ls -1 *.{mp3,acc,flac,ogg}  >> /tmp/list  2> /dev/null

IFS=$'\n' read -d '' -r -a lines < /tmp/list

echo "" 
echo "  -   Este menu é de escolha dos arquivos de audio desejados  - " 
echo "  -   A cada numero que escolher,  aperte enter - " 
echo "  -   Senão quiser nenhum dos listados, somente aperte enter ou espere aparecer a próxima tela" 
echo ""
echo ""

sleep 4

while [ $c -lt "$COMMAND" ]
do 

# sed command is not working properly ... but it is working!! 
printf " %s\n" "$d -  ${lines[c]}" 
mediainfo  "${lines[c]}" | sed -n ' /Track name/,/Genre/p'

echo ""
echo ""


if test $e -eq 4
then
#
echo "Digite os números desejados"

# -t is for timeout (seconds)
# -a parameter means array
read  -t 30 choice_one
read  -t 30 choice_two
read  -t 30 choice_three
read  -t 30 choice_four

first=$(($choice_one - 1))
second=$(($choice_two - 1))
third=$(( $choice_three - 1))
fourth=$(($choice_four - 1))
 

sleep 2

if test $first -gt -1
then
echo 'Executando primeira escolha'
sleep 1
mplayer -really-quiet -ao alsa:device=hw=1.0 "${lines[first]}"
fi

if test $second -gt -1
then
echo 'Executando segunda escolha'
sleep 1
mplayer -really-quiet -ao alsa:device=hw=1.0 "${lines[second]}"
fi

if test $third -gt -1
then
echo 'Executando terceira escolha'
sleep 1
mplayer -really-quiet -ao alsa:device=hw=1.0 "${lines[third]}"
fi

if test $fourth -gt -1
then
echo 'Executando quarta escolha'
sleep 1
mplayer -really-quiet -ao alsa:device=hw=1.0 "${lines[fourth]}"
fi

clear
e="0"
fi

sleep 1

c=$[$c+1]
d=$[$d+1]
e=$[$e+1]
done



}
files


