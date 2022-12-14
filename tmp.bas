10 *BOOT GOTO *START
20 *UPPERCASE
30 'convert TMP$ to upper case
40 TMP2$ = ""
50 FOR I=1 TO LEN(TMP$)
60  IF (ASC(MID$(TMP$,I,1))>=97) THEN TMP2$=TMP2$+CHR$(ASC(MID$(TMP$,I,1))-32) ELSE TMP2$=TMP2$+MID$(TMP$,I,1)
70 NEXT I
80 TMP$ = TMP2$
90 RETURN
100 *CONVHEX
110 'convert TMP$ to TMP; TMP$ must be uppercase
120 TMP = 0
130 J=0
140 FOR I = LEN(TMP$) TO 1 STEP -1
150  C$ = MID$(TMP$,I,1)
160  V = ASC(C$)
170  if V>=48 AND V<=57 THEN V=V-48 ELSE IF V>=65 AND V<=90 THEN V=V-55 ELSE V=0
180  'print v:input y$
190  TMP = TMP + V * 16^J
200  J=J+1
210 NEXT I
220 RETURN
230 *START
240 CLEAR:CLS
250 PRINT "Please allocate 8K machine code space first!"
260 PRINT ""
270 'request address input
280 INPUT "Set install address: ";ADDR$
290 *ADDRLEN
300 IF LEN(ADDR$)<6 THEN ADDR$="0"+ADDR$:GOTO*ADDRLEN
310 TMP$=ADDR$: GOSUB *UPPERCASE: GOSUB *CONVHEX
320 ADDR=TMP
330 SADDR=ADDR
340 'PRINT "Install to ";HEX$(ADDR);: INPUT"? [Y]";Y$
350 'IF Y$<>"Y" THEN PRINT "Aborted.": END
360 'request serial input
370 PRINT "Waiting for transfer..."
380 ADDR = TMP
390 OPEN "9600,N,8,1,A,C,&1A,X,N" FOR INPUT AS #1
400 LINUM=0
410 *PROCDAT
420 TMP$ = LEFT$(INPUT$(3, #1), 2)
430 IF LEFT$(TMP$,1)="Q" THEN *ENDFILE
440 GOSUB *CONVHEX
450 POKE ADDR, TMP
460 IF LINUM=0 THEN PRINT "&";HEX$(ADDR);": ";
470 IF LINUM=15 THEN TMP2$=HEX$(TMP): IF TMP < 16 THEN PRINT "....&0";TMP2$; ELSE PRINT "....&";TMP2$;
480 ADDR = ADDR + 1
490 LINUM = LINUM + 1
500 IF LINUM=16 THEN INPUT #1,TMP2$: PRINT " ": LINUM=0
510 'IF EOF(1) THEN *ENDFILE
520 GOTO *PROCDAT
530 *ENDFILE
540 'finish
550 PRINT "Finished."
560 PRINT "End address: &";HEX$(ADDR-1)
570 PRINT "Size: &";HEX$(ADDR-SADDR)
580 CLOSE
590 BEEP 8
600 END
