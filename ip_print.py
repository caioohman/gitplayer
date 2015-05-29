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


arquivo = "/dev/tty1"
command = "/usr/share/consolefonts/Lat7-TerminusBold32x16.psf" 


def get_ip_address(ifname):
	s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) #second layer UDP
	return socket.inet_ntoa(fcntl.ioctl(
        	s.fileno(), #file des
        	0x8915,  # SIOCGIFADDR device depend request
        	struct.pack('256s', ifname[:15])
        )[20:24]) #read from element 20 to 24

ip = get_ip_address('wlan0')

#print ip for connection over ssh
print "\nO ip para comunicaçao via SSH é : " ,ip

#send to a screen(for me it´s always /dev/tty1)
tty = open( arquivo , "w+" )
if tty > 0:
	sys.stdout = tty
	subprocess.call(["setterm" , "-background" , "white" , "-foreground" , "green" , "-store"], stdout=tty )
        print(chr(27) + "[2J")
        subprocess.call(["setfont" , command ])
	print "\nO ip para comunicaçao via SSH é : " ,ip

tty.close()
