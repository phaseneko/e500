'4x4 character maker for RotG
*BOOT GOTO *

*SETCHAR
LOCATE 19,0
INPUT CHAR$
A=ASC(CHAR$)
INDEX=PEEK(MT+A)
IF INDEX<>0 THEN *GOTINDEXC
FOR I=1 TO 99
	B=CT+(I-1)*4
	IF PEEK(B)+PEEK(B+1)+PEEK(B+2)+PEEK(B+3)=0 THEN INDEX=I: POKE MT+A,INDEX: GOTO *GOTINDEXC
NEXT I
*GOTINDEXC CADDR=CT+INDEX*4
GOSUB *LOAD: GOSUB *DRAWUI
RETURN

*SETASC
LOCATE 31,0
INPUT A
IF A<0 OR A>255 THEN *SETASC
CHAR$=CHR$(A)
INDEX=PEEK(MT+A)
IF INDEX<>0 THEN *GOTINDEXA
FOR I=1 TO 99
	B=CT+(I-1)*4
	IF PEEK(B)+PEEK(B+1)+PEEK(B+2)+PEEK(B+3)=0 THEN INDEX=I: POKE MT+A,INDEX: GOTO *GOTINDEXC
NEXT I
*GOTINDEXA CADDR=CT+INDEX*4
GOSUB *LOAD: GOSUB *DRAWUI
RETURN

*SAVE
POKE &BFCA1,&40: LOCATE 10,2: PRINT "[S]ave": POKE &BFCA1,0
D=PX(&0)+PX(&1)*2+PX(&2)*4+PX(&3)*8: POKE CADDR,D
D=PX(&4)+PX(&5)*2+PX(&6)*4+PX(&7)*8: POKE CADDR+1,D
D=PX(&8)+PX(&9)*2+PX(&A)*4+PX(&B)*8: POKE CADDR+2,D
D=PX(&C)+PX(&D)*2+PX(&E)*4+PX(&F)*8: POKE CADDR+3,D
GOSUB *DRAWUI
RETURN

*LOAD
FOR I=0 TO 15: PX(I)=0: NEXT I
D=PEEK(CADDR): PX(&0)=D AND &1:PX(&1)=(D AND &2)/2:PX(&2)=(D AND &4)/4:PX(&3)=(D AND &8)/8
D=PEEK(CADDR+1): PX(&4)=D AND &1:PX(&5)=(D AND &2)/2:PX(&6)=(D AND &4)/4:PX(&7)=(D AND &8)/8
D=PEEK(CADDR+2): PX(&8)=D AND &1:PX(&9)=(D AND &2)/2:PX(&A)=(D AND &4)/4:PX(&B)=(D AND &8)/8
D=PEEK(CADDR+3): PX(&C)=D AND &1:PX(&D)=(D AND &2)/2:PX(&E)=(D AND &4)/4:PX(&F)=(D AND &8)/8
RETURN

*CLR
FOR I=0 TO 15: PX(I)=0: NEXT I
GOSUB *DRAWUI
RETURN

*RST
POKE &BFCA1,&40: LOCATE 25,2: PRINT "[R]eset": POKE &BFCA1,0
FOR I=0 TO 255: POKE MT+I,0: NEXT I
FOR I=0 TO 99: POKE CT+I*4,0,0,0,0: NEXT I
GOSUB *DRAWUI
RETURN

*DRAWUI
'PX ORDERS
'0  4  8  12
'1  5  9  13
'2  6  10 14
'3  7  11 15
LOCATE 0,0: IF PX(&0) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B0);CHR$(&B0) 
LOCATE 0,1: IF PX(&1) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B1);CHR$(&B1) 
LOCATE 0,2: IF PX(&2) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B0);CHR$(&B0) 
LOCATE 0,3: IF PX(&3) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B1);CHR$(&B1) 
LOCATE 2,0: IF PX(&4) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B1);CHR$(&B1) 
LOCATE 2,1: IF PX(&5) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B0);CHR$(&B0) 
LOCATE 2,2: IF PX(&6) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B1);CHR$(&B1) 
LOCATE 2,3: IF PX(&7) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B0);CHR$(&B0) 
LOCATE 4,0: IF PX(&8) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B0);CHR$(&B0) 
LOCATE 4,1: IF PX(&9) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B1);CHR$(&B1) 
LOCATE 4,2: IF PX(&A) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B0);CHR$(&B0) 
LOCATE 4,3: IF PX(&B) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B1);CHR$(&B1) 
LOCATE 6,0: IF PX(&C) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B1);CHR$(&B1) 
LOCATE 6,1: IF PX(&D) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B0);CHR$(&B0) 
LOCATE 6,2: IF PX(&E) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B1);CHR$(&B1) 
LOCATE 6,3: IF PX(&F) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B0);CHR$(&B0) 
LOCATE 10,0: PRINT "[C]har: '";CHAR$;"' [A]scii:";ASC(CHAR$)
LOCATE 10,1: PRINT "Address: &";HEX$(CADDR);" [";INDEX;"]"
LOCATE 10,2: PRINT "[S]ave c[L]ear [R]eset [T]est"
RETURN

*TEST
CLS
FOR I=0 TO 99
	X=I-60*INT(I/60) 'X MOD 60
	Y=INT(I/60)
	GCURSOR(X*4,(Y+1)*5+3)
	FOR J=0 TO 3
		GCURSOR(X*4+J,(Y+1)*5+3)
		GPRINT PEEK(CT+I*4+J)
	NEXT J
NEXT I
INPUT Z
CLS
GOSUB *DRAWUI
RETURN

*RECOVER
CLS
PRINT "Recovering...";
INPUT ALLCHAR$
L=LEN(ALLCHAR$)
FOR I=1 TO L
	S = ASC(MID$(ALLCHAR$,I,1))
	POKE MT+S,I
NEXT I
BEEP 3
GOSUB *DRAWUI
RETURN

*
CLS:CLEAR
POKE &BFCBF, PEEK(&BFCBF) AND NOT (2^7) 'disable key repeat
MT=&BBC00: CT=&BBD00
DIM PX(16): FOR I=0 TO 15: PX(I)=0: NEXT I
CADDR=CT: CHAR$=" "

GOSUB *DRAWUI

*MAINLOOP
*GETINPUT
'KEY CODES
'55 56 57 47
'52 53 54 42
'49 50 51 45
'48 26 46 43
IF KC<>0 THEN OLDKC=KC
KC=ASC(INKEY$)
IF KC=0 THEN OLDKC=0
IF KC=OLDKC THEN GOTO *GETINPUT
IF KC=67 THEN GOSUB *SETCHAR
IF KC=83 THEN GOSUB *SAVE
IF KC=76 OR KC=2 THEN GOSUB *CLR
IF KC=65 THEN GOSUB *SETASC
IF KC=82 THEN GOSUB *RST
IF KC=55 THEN PX(&0)=1-PX(&0): LOCATE 0,0: IF PX(&0) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B0);CHR$(&B0): GOTO*GETINPUT
IF KC=52 THEN PX(&1)=1-PX(&1): LOCATE 0,1: IF PX(&1) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B1);CHR$(&B1): GOTO*GETINPUT
IF KC=49 THEN PX(&2)=1-PX(&2): LOCATE 0,2: IF PX(&2) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B0);CHR$(&B0): GOTO*GETINPUT
IF KC=48 THEN PX(&3)=1-PX(&3): LOCATE 0,3: IF PX(&3) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B1);CHR$(&B1): GOTO*GETINPUT 
IF KC=56 THEN PX(&4)=1-PX(&4): LOCATE 2,0: IF PX(&4) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B1);CHR$(&B1): GOTO*GETINPUT
IF KC=53 THEN PX(&5)=1-PX(&5): LOCATE 2,1: IF PX(&5) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B0);CHR$(&B0): GOTO*GETINPUT
IF KC=50 THEN PX(&6)=1-PX(&6): LOCATE 2,2: IF PX(&6) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B1);CHR$(&B1): GOTO*GETINPUT 
IF KC=26 THEN PX(&7)=1-PX(&7): LOCATE 2,3: IF PX(&7) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B0);CHR$(&B0): GOTO*GETINPUT
IF KC=57 THEN PX(&8)=1-PX(&8): LOCATE 4,0: IF PX(&8) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B0);CHR$(&B0): GOTO*GETINPUT
IF KC=54 THEN PX(&9)=1-PX(&9): LOCATE 4,1: IF PX(&9) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B1);CHR$(&B1): GOTO*GETINPUT
IF KC=51 THEN PX(&A)=1-PX(&A): LOCATE 4,2: IF PX(&A) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B0);CHR$(&B0): GOTO*GETINPUT
IF KC=46 THEN PX(&B)=1-PX(&B): LOCATE 4,3: IF PX(&B) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B1);CHR$(&B1): GOTO*GETINPUT
IF KC=47 THEN PX(&C)=1-PX(&C): LOCATE 6,0: IF PX(&C) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B1);CHR$(&B1): GOTO*GETINPUT
IF KC=42 THEN PX(&D)=1-PX(&D): LOCATE 6,1: IF PX(&D) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B0);CHR$(&B0): GOTO*GETINPUT
IF KC=45 THEN PX(&E)=1-PX(&E): LOCATE 6,2: IF PX(&E) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B1);CHR$(&B1): GOTO*GETINPUT
IF KC=43 THEN PX(&F)=1-PX(&F): LOCATE 6,3: IF PX(&F) THEN PRINT CHR$(&DB);CHR$(&DB); ELSE PRINT CHR$(&B0);CHR$(&B0): GOTO*GETINPUT
IF KC=84 THEN GOSUB *TEST
IF KC=90 THEN GOSUB *RECOVER
GOTO *MAINLOOP

*FIN

END
