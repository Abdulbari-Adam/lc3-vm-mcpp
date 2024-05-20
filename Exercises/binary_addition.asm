.ORIG x3000

TRAP 0x31 
ST R0, PLAYER_X ;-20
ST R1, PLAYER_Y ;-61
ST R2,PLAYER_Z  ;79
LD R6, COUNT
LD R7, BIT_MASK

ADD R0,R0,#15
ADD R0,R0,#1
ADD R2,R2,#1

LOOP
ADD R0,R0,#-1
LD R1 , PLAYER_Y
TRAP 0x33 
AND R4,R3,R7
BRz ISZERO
ADD R5,R5,R4 
ISZERO ; Shift it and skip to the next bit without adding 1
ADD R6,R6,#-1 ; this first count is 15 instead of 16 change it at the bottom.
BRz DONE
ADD R5,R5,R5
ADD R4,R4,R4
TRAP 0x36
BRnzp LOOP
DONE
TRAP 0x36

ST R5, LINE1 ; storing the first binary.

AND R5,R5,#0 ;clearing the registers
AND R4,R4,#0
ADD R6,R6,#15 ;count for the 2nd line here is 16 which worked/ maybe - need to test.
ADD R6,R6,#1
ADD R2,R2,#1 ; shifting this 1 more to the right.
ADD R0,R0,#15 ;Adding another 16 so we can decrement 
ADD R0,R0,#1
; this loop is perfect 
LOOP1
ADD R0,R0,#-1
LD R1 , PLAYER_Y
TRAP 0x33 
AND R5,R3,R7
BRz ISZERO1
ADD R4,R4,R5 
ISZERO1 ; Shift it and skip to the next bit without adding 1
ADD R6,R6,#-1
BRz DONE1
ADD R5,R5,R5
ADD R4,R4,R4
TRAP 0x36
BRnzp LOOP1
DONE1
TRAP 0x36
ST R4,LINE2 ;storing the first line in R4
LD R5,LINE1 ;storing the 2nd line in R5 then adding them in R4 to convert the number and place blocks 
ADD R4,R4,R5
TRAP 0x36

; here onwards is Assignment 2 Code

AND R5, R5,#0
ADD R5,R5,#1
AND R6,R6,#0 
ADD R6,R6,#15 ; setting a counter for 16 for the 16 bits
ADD R6,R6,#1

LD R7, BIT_MASK
; begin the looping 
PLACING_LOOP
BRz DONE2 ; if R3 is zero all bits have been accounted for 
AND R3,R7,R4
BRz IS_ZERO3
AND R3,R3,#0
LD R3, BLOCK_STONE
BRnzp SET_BLOCK

IS_ZERO3
AND R3,R3,#0
LD R3, BLOCK_AIR

SET_BLOCK
LD R0,PLAYER_X
ADD R0,R0,R5
LD R1,PLAYER_Y
LD R2,PLAYER_Z
ADD R2,R2,#3
TRAP 0x34

ADD R7,R7,R7
ADD R5,R5,#1 ; increment R5 by one so the next block is 2 to the right and so on
ADD R6,R6,#-1 ; decrement the 16 bit holder until it reaches 0
TRAP 0x36
BRnzp PLACING_LOOP
DONE2

HALT
LINE2 .FILL #0
LINE1 .FILL #0
COUNT .FILL #15
BIT_MASK .FILL x0001
PLAYER_X .BLKW 1
PLAYER_Y .BLKW 1
PLAYER_Z .BLKW 1
BLOCK_STONE      .FILL #1      ; Block ID for stone
BLOCK_AIR        .FILL #0  
.END