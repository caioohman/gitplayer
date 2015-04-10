#!/bin/bash  


function device()
{

 HDMI_TERM="/dev/tty1"
 PEN_DIR="/mnt/pd"
 PEN_SEC="/mnt/pd2"
 names=("sda1" "sdb1" "sdc1")
 

 cat /proc/partitions |grep sd > /dev/null

 if [ $? = 1 ]
 then
 echo "Insira um dispositivo de armazenamento" > $HDMI_TERM
 cat /proc/partitions |grep sd > /dev/null

 #loop to wait the mass storage device detection
 while [ $? = 1 ]  # if exist the return is "0" if nor is" 1"
 do
 cat /proc/partitions |grep sd > /dev/null
 done
 fi

 #echo "${names[0]}"

 for (( c=0 ; c<2 ; c++ ))
 do
  cat /proc/partitions |grep "${names[c]}" > /dev/null  # maybe is necessary to use ""
  if [ $? > 0 ]
  then
 

 mount |grep $PEN_DIR > /dev/null
  
 if [ $? -eq 1 ] #check if it was already mounted
 then
 
 mount /dev/"${names[c]}" $PEN_DIR
 else  # if yes
 echo 'Detectou um segundo dispositivo de armazenamento' > $HDMI_TERM
 
 mount /dev/"${names[c]}" $PEN_SEC
     
  fi
  fi   
 done

 

}

device
