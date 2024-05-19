.ORIG x3000
AND R2, R2, #0
AND R3, R3, #0
LD R0, N0
LD R1, N1

BRz endOfProg ; checks if R0 is zero if its zero pro ends
NOT R1, R1
ADD R1, R1, #1
ADD R0, R0, R1
TRAP 0x36 ; until here is normal subtracting

BRn endOfProg ; if the result of the first sub is negative pro ends
div_loop
ADD R2, R2, #1 ; adds 1 everytime the loop works
ADD R0, R0, R1; here we subtract R0 from R1 until it becomes zero or negaive
TRAP 0x36
BRzp div_loop ; loop ends
LD R4, N1
ADD R3, R0, R4
BRz endOfProg
AND R3, R3, #0
ADD R3, R3, #1
endOfProg

TRAP 0x36
HALT
N0 .FILL #42
N1 .FILL #2
.END