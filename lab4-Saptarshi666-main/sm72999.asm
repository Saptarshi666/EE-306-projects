.orig x3000
ld R0, ptr;
JSR RANGEMEAN
ADD R1, R1, #0
BRN TRANSFER
AND R4, R4, #0
ADD R4, R4, #8
BITSHIFT    BRZ SUM
            ADD R1, R1, R1
            ADD R4, R4, #-1
            BR BITSHIFT
SUM     ADD R1, R1,R3
TRANSFER    STI R1, ptr1
STI R2, ptr2
JSR COUNT
ST R1, SAVEF
ST R2, SAVES
ST R3, SAVEJ
ST R4, SAVEG
LD R1, ASCF
LD R2, ASCS
LD R3, ASCJ
LD R4, ASCG
LD R5, SAVEF
ADD R1, R1, R5
LD R5, SAVES
ADD R2, R2, R5
LD R5, SAVEJ
ADD R3, R3, R5
LD R5, SAVEG
ADD R4, R4, R5
STI R1, ptr3
STI R2, ptr4
STI R3, ptr5
STI R4, ptr6
HALT
ptr .fill x4004
ptr1 .fill x6000
ptr2 .fill x6001
SAVEF  .FILL #0
SAVES .FILL #0
SAVEJ .FILL #0
SAVEG .FILL #0
ASCF .FILL x4600
ASCS .FILL x5300
ASCJ .FILL x4A00
ASCG .FILL x4700
ptr3 .fill x4000
ptr4 .fill x4001
ptr5 .fill x4002
ptr6 .fill x4003
SAVER0 .fill #0
       mask2 .fill xFF00
       mask3 .fill x00FF
;return the greatest value
RANGEMEAN   ST R0, SAVER0
        AND R6, R6, #0
        AND R5 R5, #0
        LDR R1, R0, #0
        LD R2, mask2 ; R2 IS MY MASK REGISTER
        AND R1, R1,R2
        BRZ DONE
        LD R2, mask3
        LDR R4,R0,#0
        AND R4, R4, R2
        ADD R1, R4,#0 ; R1 IS MY GREATEST VALUE
        ADD R3, R4, #0 ; R3 IS MY LEAST VALUE
        LOOP1    LD R2, mask2
                LDR R4, R0, #0
                 AND R2, R2, R4 ; R4 IS MY VALUE REGISTER
                 BRZ FINISH1
                 LD R2, mask3
                 LDR R4, R0, #0
                 AND R4, R4, R2
                 ADD R2, R4, #0; COPY CONTENTS OF R4 INTO R2
                 NOT R2, R2
                 ADD R2, R2, #1
                 ADD R2, R1, R2; BASICALLY DOES R1-R4
                 BRZP SKIP1
                 ADD R1, R4, #0
                 BR SKIP1
                 SKIP1      ADD R2, R4, #0
                            NOT R2, R2
                            ADD R2, R2, #1
                            ADD R2, R3, R2; BASICALLY DOES R3-R4
                            BRNZ SKIP2
                            ADD R3, R4, #0
                            BR SKIP2
                            SKIP2       ADD R5,R5,R4 ; R5 CONTAINS MY RUNNING SUM
                                        ADD R6, R6, #1; R6 CONTAINS THE NUMBER OF ELEMENTS
                                        ADD R0, R0, #1
                                        LDR R4, R0, #0
                                        BR LOOP1
        DONE    AND R1, R1, #0
                ADD R1, R1, #-1
        FINISH1 AND R2, R2, #0
                ADD R5, R5, #0
                BRZ FINISH2
                NOT R6, R6
                ADD R6, R6, #1
            MEANLOOP    ADD R5, R5, #0
                        ADD R5, R5,R6
                        BRN FINISH
                        ADD R2,R2,#1
                        BR MEANLOOP
            FINISH2 ADD R2, R2, #-1
        FINISH  LD R0, SAVER0
                RET
SAVER1 .FILL #0
 mask4 .fill xFF00
 mask5 .fill x00FF
 F .FILL #-29
 S .FILL #-60
 J .FILL #-90
COUNT   ST R0, SAVER1
        LDR R5, R0, #0 ; R5 I SMY VALUE REGISTER
        LD R6, mask4
        AND R6, R5, R6
        BRZ LOOP4
        AND R1, R1, #0 ; FOR F
        AND R2, R2, #0; FOR S
        AND R3, R3, #0; FOR J
        AND R4, R4, #0; FOR G
        LOOP3   LD R6, mask4
                AND R6, R5, R6
                BRZ LOOP2
                LD R6, mask5
                AND R5, R5, R6
                LD R6, F
                ADD R6, R5, R6
                BRP STEP1
                ADD R1, R1, #1
                BR STEP4
                STEP1   LD R6, S
                        ADD R6, R5, R6
                        BRP STEP2
                        ADD R2, R2, #1
                        BR STEP4
                        STEP2   LD R6, J
                                ADD R6, R5, R6
                                BRP STEP3
                                ADD R3, R3, #1
                                BR STEP4
                                STEP3   ADD R4, R4, #1
                             STEP4   ADD R0, R0, #1
                                     LDR R5, R0, #0
                                     BR LOOP3
        LOOP4   AND R1, R1, #0
                AND R2, R2, #0
                AND R3, R3, #0
                AND R4, R4, #0
        LOOP2 LD R0, SAVER1
        RET
                .END