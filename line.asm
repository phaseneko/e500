       ORG     0BE000H
BX     EQU     0D4H
CX     EQU     0D6H
DX     EQU     0D8H
DOTSOP EQU     0BFC96H
LINPTN EQU     0BFC2AH
IOCS   EQU     0FFFE8H
       PRE 32H MVW (CX),0
       MV      X,0
       MV      Y,0
       PRE 32H MVW (BX),239
       PRE 32H MVW (DX),31
       MV      IL,0
       MV      [DOTSOP],IL
       DEC     I
       MV      [LINPTN],I
       MV      IL,4EH
       CALLF   IOCS
       RETF
