import serial
import os
import sys
s = serial.Serial('/dev/ttyUSB0')
s.baudrate = 9600
s.xonxoff = True

filename = 'test.bas'
raw = False
asm = False

firstarg = True
for arg in sys.argv:
	if firstarg == True:
		firstarg = False
		continue
	if arg == '-r':
		raw = True
	elif arg == '-a':
		asm = True
	else:
		filename = arg
if asm == False and filename.endswith('.asm'):
	asm = True
if filename.endswith('.mlc'):
	raw = True

f = open(filename, 'r')
lines = f.readlines()
linenum = 0
for line in lines:
	if len(line) == 0 or str.isspace(line):
		continue
	linenum += 10
	if not raw:
		if not asm:
			line = str(linenum) + ' ' + line
		else:
			line = str(linenum) + '\" ' + line
	line = line.replace('\t',' ')
	print(line.replace('\n',''))
	s.write(line.replace('\n','\r').encode())
	#os.system("echo \""+line+"\"|lpr -P devterm")

s.write(bytes.fromhex('1a'))

