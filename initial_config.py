#!/usr/bin/python
# -*- coding: utf-8 -*-

import subprocess

arquivo = "/tmp/test.txt"


def file_open(file):
	#fo because of file object
	fo = open( file , "w")
	if fo > 0:
		print "OK"
		fo.write( "\nO tamanho escolhido foi :%s...\n" %font)
	else:
		print "ERRO"

	fo.close()

	return 1

print """Ajuste o tamanho da fonte de acordo com as opções

tamanho :14

tamanho :16

tamanho :20x10

tamanho :22x11

tamanho :24x12

tamanho :28x14

tamanho :32x16"""

font = raw_input("Digite o tamanho:")

if font in ( '32x16' , '28x14' , '24x12' , '22x11' , '20x10' , '16' , '14' ):

	command = "/usr/share/consolefonts/Lat7-TerminusBold%s.psf" %font
        #because I don´t need to check the output
	subprocess.call(["setfont" , command ])
        abrir=file_open(arquivo)
        
else:
	print "Não foi posto nenhum dos tamanhos listados"


