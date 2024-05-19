.ORIG x3000
; Loads constant values in respetive Registers
AND R3,R3,x0
AND R4,R4,x0
AND R5,R5,x0

LD R3,G_X 
LD R4, G_Y
LD R5,G_Z 
LD R6, GOAL_DIST
TRAP 0x36 ;1

; get my coordinates then load it into Registors R0-R2, Output Register contents 
; ask if trap comes first or LD comes first?

AND R0,R0,x0
AND R1,R1,x0
AND R2,R2,x0

TRAP 0x31
TRAP 0x36 ;2


; Negate all G values so that i can (-) 
;; this will check if players position is negative/positive, if negative ignore, if positive make negative

;-x
BRzp minusgx
NOT R3,R3
ADD R3,R3,#1
minusgx
;-y
BRzp minusgy
NOT R4,R4
ADD R4,R4,#1
minusgy
;-z
BRzp minusgz
NOT R5,R5
ADD R5,R5,#1
minusgz

TRAP 0x36 ;3
; begin calculation

; Store the difference for ; mylocation - g_x
ADD R0,R0,R3
; Store the difference for ; mylocation - g_y
ADD R1,R1,R4
; Store the difference for ; mylocation - g_z
ADD R2,R2,R5
TRAP 0x36 ;4

ADD R0,R0,x0    ; storing the absolute value of the difference |barix - g_x|
BRzp absx
NOT R0,R0
ADD R0,R0,x1
absx

ADD R1,R1,x0    ; storing the absolute value of the difference |bariy - g_y|
BRzp absy
NOT R1,R1
ADD R1,R1,x1
absy

ADD R2,R2,x0    ; storing the absolute value of the difference |bariz - g_z|
BRzp absz
NOT R2,R2
ADD R2,R2,x1
absz
TRAP 0x36 ;5

; calculating  the abs value of for the manhattan distance 

ADD R0,R0,R1
ADD R0,R0,R2
TRAP 0x36 ;6

; condition needed check if Distance is > 10

; makes goal distance a (-)

NOT R6, R6
ADD R6,R6,#1
TRAP 0x36
ADD R0,R0,R6
TRAP 0x36 ;7
BRp OUT_BOUND

; IN BOUND
LEA R0, OPT_ONE
TRAP 0x30
HALT

OUT_BOUND
LEA R0, OPT_TWO
TRAP 0x30





HALT


OPT_ONE .STRINGZ "The player is within Manhattan distance of the goal"
OPT_TWO .STRINGZ "The player is outside the goal bounds"

; Note: Please do not change the names of the constants below
G_X .FILL #-10
G_Y .FILL #-8
G_Z .FILL #-12
GOAL_DIST .FILL #265



.END