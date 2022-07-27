'dump given section of memory and transfer via serial cable
goto *

*
cls:clear
open "9600,N,8,1,A,C,&1A,X,N" for output as #1
addr=0

print "Memory Dump Tool"
print "Please use with dumpmem.py"
input "Address:",addr
input "Length:",ll
l=0
for i=0 to ll-1
	s$=hex$(peek(addr+i))
	if len(s$)=1 then s$="0"+s$
	print #1,s$;
	'print s$;
	'l = l+1
	'if l=16 then print"":l=0
next i
print "Done."
close
beep 3
end
