.ORIG x3000       ; Start of program in memory

LD R1, NUM        ; Load the number to be divided into R1
LD R2, DIVISOR    ; Load the divisor into R2
AND R0, R0, #0    ; Clear R0, which will hold the quotient
AND R3, R3, #0    ; Clear R3, which will hold the remainder

DIVLOOP
    ADD R3, R1, R2   ; Subtract divisor from number (R1 + (-R2))
    BRn DONE         ; If result is negative, branch to DONE
    ADD R1, R3, #0   ; Otherwise, store the result back in R1
    ADD R0, R0, #1   ; Increment the quotient
    BRnzp DIVLOOP    ; Repeat the loop

DONE
    HALT             ; Halt the program

NUM      .FILL #8    ; The number to be divided
DIVISOR  .FILL #-2   ; The divisor (note it is negative for subtraction)
.END
