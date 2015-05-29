#!/bin/bash

function files()
{

HDMI_TERM="/dev/tty1"
PEN_DIR="/mnt/pd/"

c="0" 
d="1"
e="1"
false="1"

if test -e /tmp/list1
then

clear > $HDMI_TERM
clear

COMMAND="$(wc -l < /tmp/list1)"
IFS=$'\n' read -d '' -r -a lines < /tmp/list1 

echo '' > $HDMI_TERM
echo '  -   Este menu é de escolha dos arquivos de audio desejados  - ' > $HDMI_TERM
echo '  -   A cada numero que escolher,  aperte enter -  ' > $HDMI_TERM
echo '  -   Senao quiser nenhum dos listados, somente aperte enter ou espere aparecer a próxima tela' > $HDMI_TERM
echo '' > $HDMI_TERM
echo '' > $HDMI_TERM

sleep 2
clear > $HDMI_TERM

cd $PEN_DIR

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
#
echo 'Digite os números desejados' > $HDMI_TERM

# -t is for timeout (seconds)
# -a parameter means array

clear

echo 'escolha alguma opção ou aperte o enter (1)'
read  -t 30 choice_one
echo 'escolha alguma opção ou aperte o enter (2)'
read  -t 30 choice_two
echo 'escolha alguma opção ou aperte o enter (3)'
read  -t 30 choice_three
echo 'escolha alguma opção ou aperte o enter (4)'
read  -t 30 choice_four

first=$(($choice_one - 1))
second=$(($choice_two - 1))
third=$(( $choice_three - 1))
fourth=$(($choice_four - 1))
 
sleep 2

if test $first -gt -1
then
#repeat loop
while [ $false -eq 1 ]
do
echo 'Executando primeira escolha' > $HDMI_TERM
sleep 1

mplayer -really-quiet -ao alsa:device=hw=1.0 "${lines[first]}"

#1 - no
#2 - yes
echo 'Repetir : (1)Nao (2)Sim' > $HDMI_TERM
echo 'Repetir : (1)Não (2)Sim' 

read -t 10 answer
result=$(($answer - 1))

if [ $result -lt 1 ]
then
false=0
fi
done
false=1
fi

if test $second -gt -1
then
#repeat loop
while [ $false -eq 1 ]
do
echo 'Executando segunda escolha' > $HDMI_TERM
sleep 1

mplayer -really-quiet -ao alsa:device=hw=1.0 "${lines[second]}"

#1 - no
#2 - yes
echo 'Repetir : (1)Nao (2)Sim'> $HDMI_TERM
echo 'Repetir : (1)Não (2)Sim' 

read -t 10 answer
result=$(($answer - 1))

if [ $result -lt 1 ]
then
false=0
fi
done
false=1
fi

if test $third -gt -1
then
#repeat loop
while [ $false -eq 1 ]
do
echo 'Executando terceira escolha' > $HDMI_TERM
sleep 1

mplayer -really-quiet -ao alsa:device=hw=1.0 "${lines[third]}"

#1 - no
#2 - yes
echo 'Repetir : (1)Nao (2)Sim' > $HDMI_TERM
echo 'Repetir : (1)Não (2)Sim' 

read -t 10 answer
result=$(($answer - 1))

if [ $result -lt 1 ]
then
false=0
fi
done
false=1
fi

if test $fourth -gt -1
then
#repeat loop
while [ $false -eq 1 ]
do
echo 'Executando quarta escolha' > $HDMI_TERM
sleep 1

mplayer -really-quiet -ao alsa:device=hw=1.0 "${lines[fourth]}"

#1 - no
#2 - yes
echo 'Repetir : (1)Nao (2)Sim' > $HDMI_TERM
echo 'Repetir : (1)Não (2)Sim' 

read -t 10 answer
result=$(($answer - 1))

if [ $result -lt 1 ]
then
false=0
fi
done
false=1
fi

echo 'Deseja voltar ao menu inicial (1)Não  (2)Sim'
read -t 10 test
definitive=$(($test -1))

if [ $definitive -eq 1 ]
then
/home/ubuntu/gitplayer/startup.bash
exit 0
fi

clear > $HDMI_TERM
e="0" # because it will increment before start the loop again

fi

c=$[$c+1]
d=$[$d+1]
e=$[$e+1]
done
/home/ubuntu/gitplayer/pendrive.bash
#There is no audio file
else
/home/ubuntu/gitplayer/pendrive.bash

fi
}
files


