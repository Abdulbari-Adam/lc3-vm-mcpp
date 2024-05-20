.ORIG x3000

; loading the numbertoconvert in R4

LD R4, NUMBER_TO_CONVERT

; player location
; Storing in memory
TRAP 0x31 
ST R0, PLAYER_X
ST R1, PLAYER_Y
ST R2,PLAYER_Z

; initalising counter

AND R6,R6,#0
ADD R6,R6,#15 ; setting a counter for 16 for the 16 bits
ADD R6,R6,#1

AND R5, R5 ,#0
ADD R5,R5,#1
LD R7, BIT_MASK
; begin the looping 
LOOP
BRz DONE ; if R3 is zero all bits have been accounted for 
AND R3,R7,R4
BRz IS_ZERO

AND R3,R3,#0
LD R3, BLOCK_STONE
BRnzp SET_BLOCK

IS_ZERO
AND R3,R3,#0
LD R3, BLOCK_AIR

SET_BLOCK
LD R0,PLAYER_X
ADD R0,R0,R5
LD R1,PLAYER_Y
LD R2,PLAYER_Z
TRAP 0x34


ADD R7,R7,R7
ADD R5,R5,#1 ; increment R5 by one so the next block is 2 to the right and so on
ADD R6,R6,#-1 ; decrement the 16 bit holder until it reaches 0
TRAP 0x36
BRnzp LOOP

DONE
HALT
PLAYER_X .BLKW 1
PLAYER_Y .BLKW 1
PLAYER_Z .BLKW 1
NUMBER_TO_CONVERT .FILL #297 ; Note: Please do not change the name of this constant
BIT_MASK         .FILL x0001   ; Initial bit mask (0000 0000 0000 0001)
BLOCK_STONE      .FILL #1      ; Block ID for stone
BLOCK_AIR        .FILL #0      ; Block ID for air
.END



