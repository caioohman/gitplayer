#!/usr/bin/python
# -*- coding: utf-8 -*-

import subprocess
import sys
import termios

arquivo = "/tmp/test.txt"


def file_open(file,size):
	#fo because of file object
	fo = open( file , "w")
	if fo > 0:
		print "\nOK\n"
		

		fo.write( "\nA quantidade de arquivos que serão listados :%s\n" %size)
	else:
		print "\nERRO\n"

	fo.close()

	return 1

termios.tcflush( sys.stdin, termios.TCIOFLUSH )

print(chr(27) + "[2J")

print """Ajuste o tamanho da fonte de acordo com as opções

tamanho :14

tamanho :16

tamanho :20x10

tamanho :22x11

tamanho :24x12

tamanho :28x14

tamanho :32x16"""

font = raw_input("\nDigite o tamanho:")

if font in ( '32x16' , '28x14' , '24x12' , '22x11' , '20x10' , '16' , '14' ):

	command = "/usr/share/consolefonts/Lat7-TerminusBold%s.psf" %font
        #because I don´t need to check the output
	subprocess.call(["setfont" , command ])
        if font in ( '32x16' , '28x14' ):
		result = "two files"
		abrir=file_open(arquivo,result)
        if font in ('24x12' , '22x11' ):
		result = "three files"
		abrir=file_open(arquivo,result)
	if font in ( '20x10' , '16' , '14' ):
		result = "four files"
		abrir=file_open(arquivo,result)
else:
	print "Não foi posto nenhum dos tamanhos listados"


