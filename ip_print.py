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
reboot_command = "/sbin/shutdown -r now" 

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

#write into wpa_supplicant.conf file to configure wi-fi connection
def add_net(netname , netkey):

        supplicantlist = []
        wpa_file = "/etc/wpa_supplicant/wpa_supplicant.conf"

        with open ( wpa_file , "a" ) as fd:

                if fd < 0 :
                        print "\nO arquivo não pode ser aberto"
                        return 1


                supplicantlist.append('\nnetwork={\n')
                supplicantlist.append('\nssid=%s\n' %netname)
                supplicantlist.append('psk="%s"\n' %netkey)
                supplicantlist.append('proto=WPA2\n')
                supplicantlist.append('scan_ssid=1\n')
                supplicantlist.append('key_mgmt=WPA-PSK\n')
                supplicantlist.append('}' + '\n')

                for content in supplicantlist: #store in content
                        if content.strip():
                                fd.write( "{}".format(content) )
                fd.close()
		return 0
        

#store the command iwlist scan into a file to check if there is net available
# the result is the number of the nets and its names
#soon i`m going to add error of subprocess command to handle errors.

#return 0 means ok
#retun 1 means problem

def iwlist_essid( ):

        result = []

        with open( "/tmp/iwlist.txt" , "w" ) as temp_write:
                command = subprocess.Popen ([ "iwlist" , "wlan0" , "scan"] , stdout=subprocess.PIPE )
                ( output , error ) = command.communicate()
                temp_write.write(output)

        with open("/tmp/iwlist.txt" , "r" ) as temp_read:
                for output in temp_read.readlines():
                        if "Cell" in output:
                                number = output.rsplit ( None , -1)
                                print number[1]
                                result.append(number[1])
                        if "ESSID" in output:
                                #strip is to take off the new line
                                line = output.strip()
                                essid = line.rsplit ( ":" , -1 )
                                print essid[1]
                                result.append(essid[1])

        #print result
        #check if there is a wi-fi net
        if result is []:
                print "\nNenhuma rede wi-fi foi encontrada\n"
                return 1

        quantity = int(result[-2])

        #print quantity

        name = raw_input("\nDigite o nome ou o número da sua rede wi-fi:\n")

        if name in result:

                value = 0

                while quantity > 0:

                        if name in (result[ value ], result[ value + 1 ]):
                                print result[ value + 1 ]
                                break
                        value += 2
                        quantity -= 1


                password = raw_input("\nDigite a senha:\n")
                success = add_net ( result[ value + 1 ] , password )
		
		if success is 0: return 0
		else: return 1
			
        else: 
		print "\nO nome digitado esta incorreto\n"
		return 1

#perform screen logs 
def screen_term(result):
	
	arquivo = "/dev/tty1"
	command = "/usr/share/consolefonts/Lat7-TerminusBold32x16.psf"
	tty = open( arquivo , "w+" )
        
	if tty > 0:
                sys.stdout = tty
                subprocess.call(["setterm" , "-background" , "white" , "-foreground" , "green" , "-store"] , stdout=tty )
                #screen clear
		print(chr(27) + "[2J")
		#set the cursor position to the beginning
		print(chr(27) + "[H" )

                subprocess.call(["setfont" , command ])
               	#found ip
		if result > 0:
			print "\nO ip para comunicaçao via SSH é : \n" 
			print "\n%s" %ip
			tty.close()
			return 1
		#ip was not found
		if not result: 
			print "\nNao foi detectada rede cadastrada, deseja cadastrar alguma rede?\n" 
		        test = int(raw_input("\n(1)Sim  (2)Não\n")) #check if it is correct
			
			if test is 2: 
				tty.close()
				return 0
			#screen clear and warning that is necessary to write the name insidde of quotes
			print(chr(27) + "[2J")
			#set the cursor position
			print(chr(27) + "[H" )

			print "Redes encontradas\n"
			print "O nome precisa ser digitado com as aspas\n"	
			#if there is any error restart
			output = 1
			while output > 0: 
				output = iwlist_essid( )
				if output is 0: break 
			#reboot sequence	
			
		        process = subprocess.Popen(reboot_command.split(), stdout=subprocess.PIPE)
    			output = process.communicate()[0]	
			
			print output		
		#the device is not plugged		
		if result < 0:
			print "\nDispositivo não conectado , iniciando no modo console\n"
			tty.close()
			return 0
                      

ip = get_ip_address('wlan0')
test = screen_term(ip)
#go back to console
console = open (console_term , "w+")

if console > 0:

	sys.stdout = console

	if test:
		 sys.exit(0) #successful termination
	else:
		sys.exit(1)
