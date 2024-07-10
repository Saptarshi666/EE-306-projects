.orig x3000
LEA R0, MSG
PUTS
LD R1, NEGENTER
LD R2, PTR
WRITE   GETC ;GETS THE CHARACTER FROM USER
        ADD R3, R0, R1
        BRZ DONE
        OUT
        STR R0, R2, #0 ; THE STRING TO BE SEARCHED IS STORED FROM THE MEMORY LOCATION x3050
        ADD R2, R2, #1
        BR WRITE
DONE    AND R3,R3,#0
        STR R3,R2,#0
        LDI R0, HEADPTR; R0 IS MY MAIN POINTER
        BRZ STEP6
        AND R7, R7 , #0
        LDR R1, R0,#1
        BRZ LEAVE
        LDR R1, R0,#0 ; R1 CONTAINS THE VALUE TO THE NEXT POINTER, R1 CAN HAVE THE NUL PTR
;for the linked list. WE ALREADY HAVE THE NEXTPOINTER AND CURRENT POINTER REGISTERS NOW WE HAVE TO LOAD A REGISTER WITH THE MEMORY ADDRESS OF THE
;FIRST LOCATION OF THE EID
        LOOP1   LDR R2,R0,#1 ; R2 BECOMES MY EID POINTER IN LIST
                LD R3, PTR; R3 BECOMES MY CHECKING EID POINTER
                AND R7,R7,#0 ; R7 IS MY REGISTER TO CHECK IF EACH CHARACTER MATCHES AND MUST BE CLEARED FOR EACH NEW NODE
;NOW THE CHECKING PROCESS FOR THE EID BEGINS THAT IS THIS IS A NEW LOOP
                LOOP2   LDR R4,R2,#0; R4 BECOMES MY EID CHARACTER REGISTER IN LIST
                        BRZ EXIT
                        LDR R5,R3,#0; R5 BECOMES MY TEST EID CHARACTER REGISTER
                        NOT R4, R4 ; CHECKING IF THE CHARACTER IN R4 AND R5 ARE THE SAME
                        ADD R4, R4, #1
                        ADD R4,R5,R4
                        BRZ STEP1
                        BRNP STEP2
                        STEP1   ADD R7,R7,#1
                                BR INCREMENT
                        STEP2   AND R7,R7,#0
                        INCREMENT   ADD R2,R2,#1`
                                    ADD R3,R3,#1
                                    BR LOOP2        
                        EXIT    ADD R7,R7,#-5
                                BRZ LEAVE
                                BRN STEP4
                                STEP4   ADD R0,R1,#0
                                        BRZ LEAVE
                                        LDR R1,R0,#0
                                BR LOOP1

LEAVE       ADD R7,R7,#0
             BRZ STEP5
             BRN STEP6
             STEP5   LD R0,SPACE
                     out
                    LD R0, PTR
                    PUTS
                    LEA R0, MSG2
                    PUTS
                    BR STOP
            STEP6   LD R0,SPACE
                    out
                    LD R0, PTR
                    PUTS
                    LEA R0, MSG1
                    PUTS
                    BR STOP
STOP HALT
MSG .STRINGZ "Type EID and press Enter: "
NEGENTER .fill x-0A
PTR .fill x3100
HEADPTR .fill x4000
SPACE .fill x000A
MSG1 .STRINGZ " is not in the main room." 
MSG2 .STRINGZ " is already in the main room."
.end