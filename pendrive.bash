#!/bin/bash -xv

function pendrive()
{

HDMI_TERM="/dev/tty1"
DEBUG_TERM="/dev/tty0"
PEN_SEC="/mnt/pd2/"

c="0"
d="1"
e="1"

if test -e /tmp/list2
then

clear > $HDMI_TERM

COMMAND="$(wc -l < /tmp/list2)"
IFS=$'\n' read -d '' -r -a lines < /tmp/list2

echo '' > $HDMI_TERM
echo '  -   Este menu é de escolha dos arquivos de audio desejados  - ' > $HDMI_TERM
echo '  -   A cada numero que escolher,  aperte enter -  ' > $HDMI_TERM
echo '  -   Senão quiser nenhum dos listados, somente aperte enter ou espere aparecer a próxima tela ' > $HDMI_TERM
echo '' > $HDMI_TERM
echo '' > $HDMI_TERM

sleep 2

cd $PEN_SEC

while [ $c -lt "$COMMAND" ]
do

# sed command is not working properly ... but it is working!!
printf " %s\n" "$d -  ${lines[c]}" > $HDMI_TERM
mediainfo "${lines[c]}" | sed -n ' /Track name/,/Genre/p' > $HDMI_TERM

echo '' > $HDMI_TERM
echo '' > $HDMI_TERM

f=$(($c + 1 ))

if [ $e -eq 4 ] || [ $e -lt 4 -a $COMMAND -eq $f ] ||  [ $COMMAND -lt 4 -a $e -eq $COMMAND ]
then

echo 'Digite os números desejados' > $HDMI_TERM


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
echo 'Executando primeira escolha' > $HDMI_TERM
sleep 1
mplayer -really-quiet -ao alsa:device=hw=1.0 "${lines[first]}"
fi

if test $second -gt -1
then
echo 'Executando segunda escolha' > $HDMI_TERM
sleep 1
mplayer -really-quiet -ao alsa:device=hw=1.0 "${lines[second]}"
fi

if test $third -gt -1
then
echo 'Executando terceira escolha' > $HDMI_TERM

sleep 1
mplayer -really-quiet -ao alsa:device=hw=1.0 "${lines[third]}"
fi

if test $fourth -gt -1
then
echo 'Executando quarta escolha' > $HDMI_TERM

sleep 1
mplayer -really-quiet -ao alsa:device=hw=1.0 "${lines[fourth]}"
fi

clear
e="0" # because it will increment before start the loop again

fi

c=$[$c+1]
d=$[$d+1]
e=$[$e+1]
done
/home/ubuntu/bin/startup.bash
#There is no audio file
else

/home/ubuntu/bin/startup.bash

fi
}
pendrive
