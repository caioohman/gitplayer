#!/bin/bash  


function app()
{

 #local variables
 HDMI_TERM="/dev/tty1"  
 DEBUG_TERM="/dev/tty0"
 PEN_DIR="/mnt/pd"


 #screen commands
 # echo 0 > /sys/class/graphics/fbcon/cursor_blink #stop bliking cursor
 #setterm -blank 0 > $HDMI_TERM                 #it sets screen blaked
 # check whether is necessary
 #echo -e -n '\033[9]' > $DEBUG_TERM
 #echo -e '\033[9;X]' > $HDMI_TERM                   #enter sleep mode
 #echo 0 > /sys/class/graphics/fb0/blank #leave framebuffer sleep mode


 clear
#first menu  
 echo 
 echo  "--------PLAYER DE AUDIO E VIDEO--------" 
 echo 
 echo "Digite o numero de acordo com a opção desejada"
 echo 
 echo "1- executar arquivos de áudio de acordo com a lista de execução" 
 echo "2- executar arquivos de vídeo de acordo com a lista de execução"
 echo 
 echo 
 echo "3-Se desejar alterar o volume antes da reprodução" 
 echo 

 #if necessary -- echo transdata | sudo -S 

 #store the option
 read number


case $number in 
 
 1)
 echo " Você escolheu a opção vídeo" #chose video option
 clear 
 
#second menu -audio player 
echo '' 
echo '' 
echo ' -- Agora selecione o modo de execução que voce deseja --  ' 
echo ' Digite o numero de acordo com a opção desejada' 
echo ' 1- Listar os arquivos e escolher qual arquivo reproduzir ' 
echo ' 2- Somente executar todos os arquivos ' 
read way
case $way in

1)
#list files and give you options
echo ' Você escolheu a opção 1 '
/home/ubuntu/bin/file.bash
;;

2)
# just play all audio files 
echo ' Você escolheu a opção 2 '
/home/ubuntu/bin/play.bash
;;

*)
echo 'Esta não é uma opção válida '
;;

esac


;;

 2)  #third menu - video player 
 
 echo " Você escolheu a opção audio" 
 clear 
 
echo '' 
echo '' 
echo ' -- Agora selecione o modo de execução que voce deseja --  '
echo ' Digite o numero de acordo com a opção desejada' 
echo ' 1- Listar os arquivos e escolher qual arquivo reproduzir ' 
echo ' 2- Somente executar todos os arquivos ' 
read mode
case $mode in
1)
#list files and give you options
echo ' Você escolheu a opção 1 ' 
/home/ubuntu/bin/video.bash
;;
2)
# just play all audio files
echo '  Você escolheu a opção 2 '
/home/ubuntu/bin/exec.bash
;;
*)
echo ' Esta não é uma opção válida '
;;
esac

;;

3)
#volume control
alsamixer -c 1
;;

*)
echo ' Esta não é uma opção válida '
;;

esac  
 

 # -slave nao recebe comando do teclado
 # -fs full screen 
 # ver para que serve o zoom
 # -framedrop
 sleep 5

}

#mount pendrive
#/home/ubuntu/bin/mount.bash

sleep 5

app


