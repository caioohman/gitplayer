#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys

qualquer = "qualquer"
coisa = "coisa"



def add_net(netname , netkey):

	supplicantlist = []
	wpa_file = "/etc/wpa_supplicant/wpa_supplicant.conf"

	fd = open ( wpa_file , "a")
	if fd < 0 :
		print "\nO arquivo não pode ser aberto"
		sys.exit(1)
	
	supplicantlist.append('\n' + '\n')
	supplicantlist.append('\nnetwork={\n')
	supplicantlist.append('\n' + '\n')
	supplicantlist.append('ssid=%s\n' %netname)
	supplicantlist.append('psk=%s\n' %netkey)
	supplicantlist.append('proto=WPA2\n')
	supplicantlist.append('scan_ssid=1\n')
	supplicantlist.append('key_mgmt=WPA-PSK\n')
	supplicantlist.append('}' + '\n')	

	for content in supplicantlist: #store in content 
		if content.strip(): 
			fd.write( "{}".format(content) )
			#print content
	fd.close()
	

add_net( qualquer , coisa )
