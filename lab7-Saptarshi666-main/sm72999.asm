;OPERATING SYSTEM CODE

.ORIG x500
        
        LD R0, VEC
        LD R1, ISR
        
        ; (1) Initialize interrupt vector table with the starting address of ISR.
        STR R1,R0,#0

        ; (2) Set bit 14 of KBSR. [To Enable Interrupt]

	    LDI R0, KBSR
        LD R1, MASK
        AND R0, R0,R1
        NOT R1,R1
        ADD R0,R1,R0
        STI R0,KBSR
        ; (3) Set up system stack to enter user space. So that PC can return to the main user program at x3000.
	; R6 is the Stack Pointer. Remember to Push PC and PSR in the right order. Hint: Refer State Graph
        LD R6, SYSSTACK
        LD R0, PSR
        ADD R6,R6,#-1
        STR R0,R6,#0
        LD R0, PC
        ADD R6,R6,#-1
        STR R0,R6,#0


        ; (4) Enter user Program.
        RTI
        
VEC     .FILL x0180
ISR     .FILL x1700
KBSR    .FILL xFE00
MASK    .FILL xBFFF
PSR     .FILL x8002
PC      .FILL x3000
SYSSTACK .FILL x3000
.END


; INTERRUPT SERVICE ROUTINE

.ORIG x1700
ST R0, SAVER0
ST R1, SAVER1
ST R2, SAVER2
ST R3, SAVER3
ST R7, SAVER7
ST R4, SAVER4
LDI R1, KBDR
; CHECK THE KIND OF CHARACTER TYPED AND PRINT THE APPROPRIATE PROMPT
LD R2, ASCII_NUM
ADD R2,R1,R2
BRZP STEP1
BRN STEP2 
STEP1   LD R2, ASCII_NUM
        ADD R2, R2, x-9
        ADD R2, R1,R2
        BRNZ STEP3
        BRP STEP4
        STEP3   LEA R0,STRING3
                PRIN    LDR R3,R0,#0
                        BRZ end1
                        POLL    LDI R4, DSRPtr
                                BRZP POLL
                                STI R3, DDRPtr
                                ADD R0, R0, #1
                                BR PRIN
                        end1 LDI R4, DSRPtr
                             BRZP end1
                             LD R3, ENTER
                             STI R3, DDRPtr
                             BR end
STEP4   LD R2, ASCII_UC
        ADD R2, R1,R2
        BRZP STEP5
        BRN STEP2
            STEP5   LD R2, ASCII_UC1
                    
                    ADD R2, R1, R2
                    BRNZ STEP6
                    BRP STEP7
                    STEP6 LEA R0,STRING1
                PRIN1    LDR R3,R0,#0
                        BRZ end2
                        POLL1    LDI R4, DSRPtr
                                BRZP POLL1
                                STI R3, DDRPtr
                                ADD R0, R0, #1
                                BR PRIN1
                    end2    LDI R4, DSRPtr
                             BRZP end2
                             LD R3, ENTER
                             STI R3, DDRPtr
                             BR end
STEP7 LD R2, ASCII_LC
      ADD R2, R1, R2
      BRZP STEP8
      BRN STEP2
                STEP8 LD R2, ASCII_LC1
                    
                    ADD R2, R1, R2
                    BRNZ STEP9
                    BRP STEP2
                    STEP9 LEA R0,STRING2
                PRIN2    LDR R3,R0,#0
                        BRZ end3
                        POLL2    LDI R4, DSRPtr
                                BRZP POLL2
                                STI R3, DDRPtr
                                ADD R0, R0, #1
                                BR PRIN2
                    end3    LDI R4, DSRPtr
                             BRZP end3
                             LD R3, ENTER
                             STI R3, DDRPtr
                             BR end
STEP2 LEA R0,STRING4
                PRIN3    LDR R3,R0,#0
                        BRZ end4
                        POLL3    LDI R4, DSRPtr
                                BRZP POLL3
                                STI R3, DDRPtr
                                ADD R0, R0, #1
                                BR PRIN3
                    end4    LDI R4, DSRPtr
                             BRZP end4
                             LD R3, ENTER
                             STI R3, DDRPtr
                            HALT
                             BR end

end LD R0, SAVER0
    LD R1, SAVER1
    LD R2, SAVER2
    LD R3, SAVER3 
    LD R7, SAVER7
    LD R4, SAVER4
    RTI



ASCII_NUM .FILL x-30
ASCII_LC  .FILL x-61
ASCII_UC  .FILL x-41
ASCII_LC1 .FILL x-7A
ASCII_UC1 .FILL x-5A
ENTER .FILL x0A
KBDR .FILL xFE02
STRING1 .STRINGZ "\nPractice Social Distancing\n"
STRING2 .STRINGZ "\nWash your Hands frequently\n"
STRING3 .STRINGZ "\nStay Home, Stay Safe\n"
STRING4 .STRINGZ "\n ---------- END OF EE306 LABS -------------\n"
SAVER0 .BLKW x1
SAVER1 .BLKW x1
SAVER2 .BLKW x1
SAVER3 .BLKW x1
SAVER7 .BLKW x1
SAVER4 .BLKW x1
DSRPtr	.FILL xFE04
DDRPtr	.FILL xFE06

.END




; USER PROGRAM

.ORIG x3000

; MAIN USER PROGRAM
; PRINT THE MESSAGE "WHAT STARTS HERE CHANGES THE WORLD" WITH A DELAY LOGIC

LOOP1   
        ADD R5,R5,#-1
        BRZ STOP
        LD R1,CNT
       
        
        LOOP2   ADD R1,R1,#-1
                BRP LOOP2
                
        LEA R0, MESSAGE       
        PUTS
        BR LOOP1
STOP HALT



CNT .FILL x7FFF
MESSAGE .STRINGZ  "WHAT STARTS HERE CHANGES THE WORLD\n"
.END