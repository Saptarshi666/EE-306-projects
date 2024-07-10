.orig x3000
;load numbers into register 
ld R0, PTR1
LDR R1, R0, #0
LD R0, PTR2
LDR R2, R0, #0
LDR R3, R0, #0 
;convert R2 to -ve
NOT R2, R2
ADD R2, R2, #1
; ADD R1 AND R2 AND STORE IN R4
ADD R4, R1, R2
; check if R4 is positive negative or equal and basis of this put the greatest value in x3302
BRP STEP1
BRN STEP2
BRZ STEP3
STEP1      LD R0, PTR3
           STR R1, R0, #0
           BRNZP STOP
STEP2       LD R0, PTR3
            STR R3, R0, #0
            BRNZP STOP
STEP3       LD R0, PTR3
            STR R1, R0, #0
            BRNZP STOP
STOP        HALT
PTR1 .fill x3300
PTR2 .fill x3301
PTR3 .fill x3302
.end

