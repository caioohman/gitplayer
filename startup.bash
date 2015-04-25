#!/bin/bash 


function app()
{

 #local variables
 HDMI_TERM="/dev/tty1"  
 DEBUG_TERM="/dev/ttyO0"
 


 #screen commands
  echo 0 > /sys/class/graphics/fbcon/cursor_blink #stop bliking cursor
 setterm -blank 0 > $HDMI_TERM                 #it sets screen blaked
 #check whether is necessary
 echo -e -n '\033[9]' > $DEBUG_TERM
 echo -e '\033[9;X]' > $HDMI_TERM                   #enter sleep mode
 echo 0 > /sys/class/graphics/fb0/blank #leave framebuffer sleep mode

 clear > $HDMI_TERM

#        first menu
# option 1 - play audios files
# option 2 - play video files
# option 3 - volume control
# option 4 - exit application
  
 
 echo '' > $HDMI_TERM  
 echo  '--------PLAYER DE AUDIO E VIDEO--------'  > $HDMI_TERM
 echo '' > $HDMI_TERM
 echo ' Digite o numero de acordo com a opção desejada' > $HDMI_TERM
 echo '' > $HDMI_TERM
 echo ' 1- executar arquivos de áudio de acordo com a lista de execução' > $HDMI_TERM
 echo ' 2- executar arquivos de vídeo de acordo com a lista de execução' > $HDMI_TERM
 echo '' > $HDMI_TERM
 echo '' > $HDMI_TERM
 echo ' 3-Se desejar alterar o volume antes da reprodução' > $HDMI_TERM
 echo ' 4-Se deseja sair' > $HDMI_TERM 
 echo '' > $HDMI_TERM
 echo ' 1- áudio' 
 echo ' 2- vídeo'
 echo ' 3- volume'
 echo ' 4- sair'
 #if necessary -- echo transdata | sudo -S 

 #store the option
 read number


case $number in 
 
 1)
 echo '' > $HDMI_TERM
 echo '' > $HDMI_TERM
 #choose audio options
 echo ' Você escolheu a opção áudio ' > $HDMI_TERM
 
 sleep 1
 
 clear  > $HDMI_TERM
 clear
 
#     second menu -audio player
# option 1 - list the files e give you options 
# option 2 - just play the list
# option 3 - back to first menu
 
echo ''  > $HDMI_TERM 
echo ''  > $HDMI_TERM
echo ' -- Agora selecione o modo de execução que voce deseja --  ' > $HDMI_TERM
echo ' Digite o numero de acordo com a opção desejada'  > $HDMI_TERM
echo ''  > $HDMI_TERM
echo ''  > $HDMI_TERM
echo ' 1- Listar os arquivos e escolher qual arquivo reproduzir '  > $HDMI_TERM
echo ' 2- Somente executar todos os arquivos '  > $HDMI_TERM
echo ' 3-Se deseja voltar ao menu inicial' > $HDMI_TERM
echo ' 1- escolher arquivos'
echo ' 2- somente executar todos os arquivos'
echo ' 3- voltar ao menu inicial'

read way
case $way in

1)
#list files and give you options
echo '' > $HDMI_TERM
echo '' > $HDMI_TERM
echo ' Você escolheu a opção 1 ' > $HDMI_TERM

sleep 1

/home/ubuntu/gitplayer/file.bash
;;

2)
# just play all audio files 
echo '' > $HDMI_TERM
echo '' > $HDMI_TERM
echo ' Você escolheu a opção 2 ' > $HDMI_TERM

sleep 1

/home/ubuntu/gitplayer/rice.bash
;;


3)
/home/ubuntu/gitplayer/startup.bash

;;


*)
echo '' > $HDMI_TERM
echo '' > $HDMI_TERM
echo 'Esta não é uma opção válida ' > $HDMI_TERM

sleep 1

exit 0
;;

esac


;;

 2)   
 
echo '' > $HDMI_TERM
echo '' > $HDMI_TERM
echo ' Você escolheu a opção video' > $HDMI_TERM
 
 
sleep 1

 clear > $HDMI_TERM
 clear 
 

#      third menu - video player
# option 1 - list the files e give you options
# option 2 - just play the list
# option 3 - back to first menu


echo '' > $HDMI_TERM
echo '' > $HDMI_TERM
echo ' -- Agora selecione o modo de execução que voce deseja --  ' > $HDMI_TERM
echo ' Digite o numero de acordo com a opção desejada' > $HDMI_TERM
echo ' 1- Listar os arquivos e escolher qual arquivo reproduzir ' > $HDMI_TERM
echo ' 2- Somente executar todos os arquivos ' > $HDMI_TERM
echo ' 3-Se deseja voltar ao menu inicial' > $HDMI_TERM
echo ' 1- escolher o arquivo'
echo ' 2-somente executar os arquivos' 
echo ' 3-voltar ao menu inicial'

read mode
case $mode in
1)
#list files and give you options
echo '' > $HDMI_TERM
echo '' > $HDMI_TERM
echo ' Você escolheu a opção 1 ' > $HDMI_TERM

sleep 1
 
/home/ubuntu/gitplayer/video.bash
;;
2)
# just play all audio files
echo '' > $HDMI_TERM
echo '' > $HDMI_TERM
echo '  Você escolheu a opção 2 ' > $HDMI_TERM

sleep 1

/home/ubuntu/gitplayer/exec.bash
;;


3)

/home/ubuntu/gitplayer/startup.bash
;;

*)
echo '' > $HDMI_TERM
echo '' > $HDMI_TERM
echo ' Esta não é uma opção válida ' > $HDMI_TERM


exit 0
;;
esac

;;

3)

#volume control

clear

echo '' > $HDMI_TERM
echo '' > $HDMI_TERM
echo 'Aperte as teclas com as setas para cima ou para baixo para alterar o volume' > $HDMI_TERM
echo 'Aperte as teclas com as setas para cima ou para baixo para alterar o volume'
sleep 1

#the output of the command can´t be redirected to the output ´cuz I don´t have  control over it
alsamixer -c 1 
/home/ubuntu/gitplayer/startup.bash

;;

4)

clear

echo '' > $HDMI_TERM
echo '' > $HDMI_TERM
echo ' Saindo do programa ...' > $HDMI_TERM
echo ' Saindo do programa ...'

sleep 1
exit 0

;;

*)
echo '' > $HDMI_TERM
echo '' > $HDMI_TERM
echo ' Esta não é uma opção válida ' > $HDMI_TERM


sleep 1

exit 0

;;

esac  
 

 # -slave nao recebe comando do teclado
 # -fs full screen 
 # ver para que serve o zoom
 # -framedrop
 sleep 5

}

if [ ! -e /tmp/list1 -a ! -e /tmp/videolist1 -a ! -e /tmp/lis2 -a ! -e /tmp/videolist2 ] 
then
#mount pendrive
/home/ubuntu/gitplayer/mount.bash
fi

clear

if [ ! -e /tmp/list1 -a ! -e /tmp/list2 ]
then 
echo '' > $HDMI_TERM
echo '' > $HDMI_TERM
echo 'Não foi detectado nenhum arquivo de áudio ' > $HDMI_TERM


sleep 3

if [ ! -e /tmp/videolist1 -a ! -e /tmp/videolist2 ]
then
echo '' > $HDMI_TERM
echo '' > $HDMI_TERM
echo 'Também não foi detectado nenhum arquivo de vídeo' > $HDMI_TERM


sleep 3
exit 0
else
app
fi
else
app
fi


