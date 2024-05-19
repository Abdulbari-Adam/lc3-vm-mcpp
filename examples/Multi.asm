.ORIG x3000

; Do the first multiplication
LDI R0, ADDR_A
LDI R1, ADDR_B
JSR MUL_SUB
STI R2, ADDR_RES_1

; Do the second multiplication
LDI R0, ADDR_C
LDI R1, ADDR_D
JSR MUL_SUB
STI R2, ADDR_RES_2

HALT

; Multiplication subroutine
MUL_SUB
    ; Prepare R2 to hold the result.
    AND R2, R2, #0
    mul_loop
        ADD R2, R2, R1
        ADD R0, R0, #-1
        BRp mul_loop
RET

ADDR_A .FILL x3100
ADDR_B .FILL x3101
ADDR_C .FILL x3110
ADDR_D .FILL x3111
ADDR_RES_1 .FILL x3102
ADDR_RES_2 .FILL x3112

.END