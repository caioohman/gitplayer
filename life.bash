#!/bin/bash 

function life()
{

HDMI_TERM="/dev/tty1"
PEN_SEC="/mnt/pd2/"

c="0" 
d="1"
e="1"
false="1"
two_files="0"
four_files="0"
three_files="0"

if test -e /tmp/videolist2
then

clear > $HDMI_TERM
clear

COMMAND="$(wc -l < /tmp/videolist2)"
IFS=$'\n' read -d '' -r -a lines < /tmp/videolist2 

echo '' > $HDMI_TERM
echo '  - Este menu é de escolha dos arquivos de vídeo desejados  - ' > $HDMI_TERM
echo '  - A cada numero que escolher,  aperte enter -  ' > $HDMI_TERM
echo '  - Senao quiser nenhum dos listados, somente aperte enter' > $HDMI_TERM
echo ' ou espere aparecer a próxima tela' > $HDMI_TERM
echo '' > $HDMI_TERM
echo '' > $HDMI_TERM

sleep 2
clear > $HDMI_TERM

grep -q two /tmp/test.txt
if [ $? -eq 0 ] 
then
two_files="2"
limiar="$two_files"
fi
grep -q three /tmp/test.txt
if [ $? -eq 0 ] 
then
three_files="3"
limiar="$three_files"
fi

grep -q four /tmp/test.txt
if [ $? -eq 0 ] 
then
four_files="4"
limiar="$four_files"
fi

cd $PEN_SEC

while [ $c -lt "$COMMAND" ]
do 

# sed command is not working properly ... but it is working!! 
printf " %s\n" "$d -  ${lines[c]}" > $HDMI_TERM
mediainfo "${lines[c]}" | sed -n ' /Complete name/,/Duration/p' > $HDMI_TERM

echo '' > $HDMI_TERM
echo '' > $HDMI_TERM

f=$(($c + 1 ))

if [ $e -eq $limiar ] || [ $e -lt $limiar -a $COMMAND -eq $f ] ||  [ $COMMAND -lt $limiar -a $e -eq $COMMAND ]
then
#
echo 'Digite os números desejados' > $HDMI_TERM

# -t is for timeout (seconds)
# -a parameter means array

clear

# when the size of the words are small enough for two file on the same screen

if [ $two_files -eq 2 ] || [ $three_files -eq 3 ] || [ $four_files -eq 4 ]
then
echo 'escolha alguma opção ou aperte o enter (1)'
read  -t 30 choice_one
first=$(($choice_one - 1))
echo 'escolha alguma opção ou aperte o enter (2)'
read  -t 30 choice_two
second=$(($choice_two - 1))

if test $first -gt -1
then
#repeat loop
while [ $false -eq 1 ]
do
echo 'Executando primeira escolha' > $HDMI_TERM
sleep 1

clear > $HDMI_TERM
nice --15 mplayer -really-quiet -vo fbdev2 -ao alsa:device=hw=1.0 -autosync 1 -framedrop "${lines[first]}"
clear > $HDMI_TERM

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

clear > $HDMI_TERM
nice --15 mplayer -really-quiet -vo fbdev2 -ao alsa:device=hw=1.0 -autosync 1 -framedrop "${lines[second]}"
clear > $HDMI_TERM

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

# when the size of the words are small enough for three file on the same screen

if [ $three_files -eq 3 ] || [ $four_files -eq 4 ]
then
echo 'escolha alguma opção ou aperte o enter (3)'
read  -t 30 choice_three
third=$(( $choice_three - 1))

if test $third -gt -1
then
#repeat loop
while [ $false -eq 1 ]
do
echo 'Executando terceira escolha' > $HDMI_TERM
sleep 1

clear > $HDMI_TERM
nice --15 mplayer -really-quiet -vo fbdev2 -ao alsa:device=hw=1.0 -autosync 1 -framedrop "${lines[third]}"
clear > $HDMI_TERM

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

# when the size of the words are small enough for four file on the same screen
if [ $four_files -eq 4 ]
then
echo 'escolha alguma opção ou aperte o enter (4)'
read  -t 30 choice_four
fourth=$(($choice_four - 1))

if test $fourth -gt -1
then
#repeat loop
while [ $false -eq 1 ]
do
echo 'Executando quarta escolha' > $HDMI_TERM
sleep 1

clear > $HDMI_TERM
nice --15 mplayer -really-quiet -vo fbdev2 -ao alsa:device=hw=1.0 -autosync 1 -framedrop "${lines[fourth]}"
clear > $HDMI_TERM

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

fi
fi
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
/home/ubuntu/gitplayer/startup.bash
#There is no audio file
else
/home/ubuntu/gitplayer/startup.bash

fi
}
life


