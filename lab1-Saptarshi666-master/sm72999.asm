.ORIG x3000
LD R0, x00F
LDR R1, R0, x1F ; Load number 1 into R1
LD R0, x00E
LDR R2, R0, X1F ; LOAD NUMBER 2 INTO R2
LD R3,x00D; load bit mask into the register
AND R1, R1, R3 ; Apply bit mask to number 1
AND R2, R2, R3 ; Apply bit maks to number 2
ADD R4, R1, R2 ; Add number 1 and number 2
NOT R2, R2 ; Make R2 negative
ADD R2, R2, #1 ; part of the previous function
ADD R5, R1, R2 ; Subtract number 2 from number 1
LD R0, x007
STR R4, R0, x1F ; load sum into memory
LD R0, x006
STR R5, R0, x1F ; load difference into memory
HALT
.FILL x32E1
.FILL x32E2
.FILL x00FF
.FILL x32E3
.FILL x32E4
.END
