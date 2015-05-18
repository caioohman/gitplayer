#!/usr/bin/python
# -*- coding: utf-8 -*-

import subprocess

print """Ajuste o tamanho da fonte de acordo com as opções

tamanho :14

tamanho :16

tamanho :20x10

tamanho :22x11

tamanho :24x12

tamanho :28x14

tamanho :32x16"""

font = raw_input("Digite o tamanho:")

command = "/usr/share/consolefonts/Lat7-TerminusBold%s.psf" %font
#print command

#because I don´t need to check the output
subprocess.call(["setfont" , command ])

