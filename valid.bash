#!/bin/bash

#time for ip address
sleep 20

clear

python /home/ubuntu/gitplayer/ip_print.py

output=$?

if [ $output -eq 0 ]
then
#time to connect
sleep 120

if [ `ps aux |grep ssh |wc -l` -eq 3 ]
then

clear > /dev/tty1


#once on a ssh terminal you need to type the command below
#and wait until leave the msg to execute.Otherwise the program will crash
echo 'Voce precisa digitar o comando: ' > /dev/tty1
setterm -foreground red > /dev/tty1
echo 'bash /home/ubuntu/gitplayer/startup.bash ' > /dev/tty1
setterm -foreground green > /dev/tty1
echo 'e executa-lo com a tecla enter' > /dev/tty1 
echo 'depois que este aviso sair da tela' > /dev/tty1

sleep 60
exit 0

else
bash /home/ubuntu/gitplayer/startup.bash
exit 0
fi

else
bash /home/ubuntu/gitplayer/startup.bash
fi
exit 0


















#once on a ssh terminal you need to type the command below
#and wait until leave the msg to execute.Otherwise the program will crash
echo 'Voce precisa digitar o comando ' > /dev/tty1
setterm -foreground red
echo 'bash /home/ubuntu/gitplayer/startup.bash ' > /dev/tt$
setterm -foreground green
echo 'e executa-lo com a tecla enter depois que este aviso sair da tela' > /dev$


