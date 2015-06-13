#!/bin/bash  


function device()
{

 HDMI_TERM="/dev/tty1"
 PEN_DIR="/mnt/pd"
 PEN_SEC="/mnt/pd2"
 names=("sda1" "sdb1" "sdc1")
 
 clear > $HDMI_TERM

 echo '' > $HDMI_TERM
 echo '' > $HDMI_TERM
 echo '  -- CONFIGURAÇAO DOS DISPOSITIVOS DE ARMAZENAMENTO --' > $HDMI_TERM
 echo '' > $HDMI_TERM
 echo '' > $HDMI_TERM

 cat /proc/partitions |grep sd > /dev/null

 if [ $? = 1 ]
 then
 echo 'Insira um dispositivo de armazenamento' > $HDMI_TERM
 sleep 3
 cat /proc/partitions |grep sd > /dev/null
 
 #loop to wait the mass storage device detection
 # if exist the return is "0" if nor is" 1"

while [ $? = 1 ]  
 do
 cat /proc/partitions |grep sd > /dev/null
 done
 fi

 #echo "${names[0]}"
 #the program only accept 2.
 
 for (( c=0 ; c<2 ; c++ ))
 do
  cat /proc/partitions |grep "${names[c]}" > /dev/null 
  if [ $? -eq 0 ]
  then
  mount |grep $PEN_DIR > /dev/null
  
  #check if it was already mounted

 if [ $? -eq 1 ] 
 then
 
 mount /dev/"${names[c]}" $PEN_DIR
 
 COMMAND_ONE="$(find $PEN_DIR -maxdepth 1 -type f -iregex ".*\.\(aac\|flac\|mp3\|ogg\|wav\)$" | wc -l)"
 #check if it has audio´s files and redirect then into a list file  
 if test $COMMAND_ONE -gt 0
 then
 echo '' > $HDMI_TERM
 echo '' > $HDMI_TERM
 echo "Pendrive 1 : Foram encontrados $COMMAND_ONE arquivos de áudio de extensoes" > $HDMI_TERM 
 echo 'aac,flac,mp3,ogg,wav' > $HDMI_TERM

 
 sleep 3
  
 cd $PEN_DIR && ls -1 *.{mp3,acc,flac,ogg,wav}  > /tmp/list1  2> /dev/null
 fi
 
 COMMAND_THREE="$(find $PEN_DIR -maxdepth 1 -type f -iregex ".*\.\(mp4\|mkv\|avi\|mpg\)$" | wc -l)"
 #check if it has video´s files and redirect then into a videolist file
 if test $COMMAND_THREE -gt 0
 then
 echo ''
 echo ''
 echo "Pendrive 1 : Foram encontrados $COMMAND_THREE arquivos de vídeo de extensoes mp4,mkv,avi,mpg" > $HDMI_TERM
 
 
 sleep 3

 cd $PEN_DIR && ls -1 *.{mp4,mkv,avi,mpg} > /tmp/videolist1  2> /dev/null  
 fi

 #if 1 mass storage was already mounted and there is another
 else  
 echo '' > $HDMI_TERM
 echo '' > $HDMI_TERM
 echo 'Detectou um segundo dispositivo de armazenamento' > $HDMI_TERM
 
 sleep 3

 mount /dev/"${names[c]}" $PEN_SEC
 
 COMMAND_TWO="$(find $PEN_SEC -maxdepth 1 -type f -iregex ".*\.\(aac\|flac\|mp3\|ogg\|wav\)$" | wc -l)"
 #check if it has audio´s files and redirect 
 if test $COMMAND_TWO -gt 0 
 then
 echo '' > $HDMI_TERM
 echo '' > $HDMI_TERM
 echo "Pendrive 2 : Foram encontrados $COMMAND_TWO arquivos de áudio de extensoes" >$HDMI_TERM 
 echo 'aac,flac,mp3,ogg,wav' > $HDMI_TERM
 
 
 sleep 3

 cd $PEN_SEC && ls -1 *.{mp3,acc,flac,ogg,wav}  > /tmp/list2  2> /dev/null
 fi
 
 COMMAND_FOUR="$(find $PEN_SEC -maxdepth 1 -type f -iregex ".*\.\(mp4\|mkv\|avi\|mpg\)$" | wc -l)"
 #check if it has video´s files and redirect
 if test $COMMAND_FOUR -gt 0
 then
 echo '' > $HDMI_TERM
 echo '' > $HDMI_TERM
 echo "Pendrive 2 : Foram encontrados $COMMAND_FOUR arquivos de vídeo de extensoes " > $HDMI_TERM
 echo 'aac,flac,mp3,ogg,wav' > $HDMI_TERM
 
 sleep 10

 cd $PEN_SEC && ls -1 *.{mp4,mkv,avi,mpg} >> /tmp/videolist2  2> /dev/null
 fi

 fi
 fi   
 done

 

}

device
