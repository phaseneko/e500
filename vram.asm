ORG 0BDC00H
BEGIN:
MV X,02000H
MV Y,0BBC00H
MV I,01E00H
LOOP:
MV A,[X++]
MV [Y++],A
DEC I
JRNZ LOOP
RETF

