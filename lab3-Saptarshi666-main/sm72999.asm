.ORIG x3000

ld R0, ptr 
ld R1, mask 
STEP1   LDR R2, R0, #0 
        LD R3, mask2 
        AND R3, R2, R3 
        BRZ DONE 
        LD R2, ptr 
        STEP2   LDR R3, R2, #0 
                LD R5, mask2 
                AND R5, R3, R5 
                BRZ STEP5 
                LDR R4, R2, #1 ; 
                LD R5, mask2
                AND R5, R4, R5
                BRZ STEP4
                AND R3,R3, R1
                AND R4,R4, R1
                NOT R4, R4
                ADD R4, R4, #1
                ADD R3, R3, R4
                BRP STEP3
                BRNZ STEP4
                STEP3   LDR R3, R2, #0
                        LDR R4, R2, #1
                        STR R4, R2, #0
                        STR R3, R2, #1
                        ADD R2, R2, #1
                        BR STEP2
                STEP4   ADD R2, R2, #1
                        BR STEP2
                

STEP5 ADD R0, R0, #1
      BR STEP1
DONE    HALT
ptr     .fill x4004
mask    .fill x00FF
mask2   .fill xFF00 
.END



