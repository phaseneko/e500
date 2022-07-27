import serial
import os
import sys
s = serial.Serial('/dev/ttyUSB0')
s.baudrate = 9600
s.xonxoff = True

filename = 'test.mlc'

firstarg = True
for arg in sys.argv:
	if firstarg == True:
		firstarg = False
		continue
	filename = arg

f = open(filename, 'w')
l = 0
while (True):
	b = s.read()
	if b[0]==26: #26=&1A
		break
	text = b.decode('UTF-8')
	l += 1
	f.write(text)
	print(text,end='')
	if l==32:
		f.write('\n')
		print('')
		l = 0
	elif l%2==0:
		f.write(' ')
		print(' ',end='')
f.write('\nQ\n\n')
f.flush()
f.close()

print('Done.')

