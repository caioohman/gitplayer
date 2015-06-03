#!/usr/bin/python
# -*- coding: utf-8 -*-


#AF_INET ís Arpa Internet protocol
#DGRAM is datagram sockets
#UDP is User Datagram Protocol

import socket
import fcntl
import struct
import subprocess
import sys 

console_term = "/dev/ttyO0"

#get ip address
def get_ip_address(ifname):
	
	try:	
		s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) #second layer UDP	
		return socket.inet_ntoa(fcntl.ioctl(
        		s.fileno(), #file des
        		0x8915,  # SIOCGIFADDR device depend request
        		struct.pack('256s', ifname[:15])
       		)[20:24]) #read from element 20 to 24

	except IOError,e:
		if e.errno is 99:                
			return 0
		if e.errno is 19:
			return -1

def screen_term(result):
	
	arquivo = "/dev/tty1"
	command = "/usr/share/consolefonts/Lat7-TerminusBold32x16.psf"
	tty = open( arquivo , "w+" )
        
	if tty > 0:
                sys.stdout = tty
                subprocess.call(["setterm" , "-background" , "white" , "-foreground" , "green" , "-store"] , stdout=tty )
                print(chr(27) + "[2J")
                subprocess.call(["setfont" , command ])
               	
		if result > 0:
			print "\nO ip para comunicaçao via SSH é : " ,ip
			tty.close()
			return 1
		if not result: 
			print "Nao foi detectada rede cadastrada, iniciando no modo console"
		        tty.close()
			return 0
		if result < 0:
			print "Dispositivo não conectado , iniciando no modo console"
			tty.close()
			return 0
       

ip = get_ip_address('wlan0')
test = screen_term(ip)

console = open (console_term , "w+")

if console > 0:

	sys.stdout = console

	if test:
		 sys.exit(0) #successful termination
	else:
		sys.exit("error")
