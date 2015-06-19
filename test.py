#!/usr/bin/env python

import subprocess

teste = subprocess.Popen( ["find /root/ -iname player" ] , shell=True ,  stdout=subprocess.PIPE )
( output , error ) = teste.communicate()

result = output.split()

if not result: 
	symlink = subprocess.Popen(["ln -s /home/ubuntu/gitplayer/startup.bash player"] , shell=True , stdout=subprocess.PIPE)	 
	( out , err ) = symlink.communicate()
	#print symlink
else: print "\nOK\n"
