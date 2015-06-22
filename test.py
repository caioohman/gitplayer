#!/usr/bin/env python

import subprocess

teste = subprocess.Popen( ["find /root/ -iname player" ] , shell=True ,  stdout=subprocess.PIPE )
( output , error ) = teste.communicate()

result = output.split()

#print result

if not result: 
	symlink = subprocess.Popen(["ln -s /home/ubuntu/gitplayer/startup.bash /root/player"] , shell=True , stdout=subprocess.PIPE)	 
	( out , err ) = symlink.communicate()
	#print symlink
else: print "\nOK\n"
