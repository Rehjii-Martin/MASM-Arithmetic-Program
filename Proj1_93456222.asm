TITLE Simple Arithmetic - CS271 Project 1

; Author: Rehjii L Martin
; Date: 01/26/2025
; Description:
; This program prompts the user to enter two integers (X > Y),
; calculates the sum, difference (both X-Y and Y-X if needed), product,
; and quotient/remainder. It repeats until the user chooses to quit.

INCLUDE Irvine32.inc

.data
    introMsg BYTE "Simple Arithmetic     by [Your Name]", 0
    instrMsg BYTE "Enter two numbers X > Y, and I'll work some math magic!", 0
    excMsg1   BYTE "**EC: Program verifies the numbers are in descending order.", 0
    excMsg2   BYTE "**EC: Program allows repeated calculations until user quits.", 0
    excMsg3   BYTE "**EC: Program computes Y - X when X - Y is negative.", 0
    excMsg4   BYTE "**EC: Program calculates quotient and remainder.", 0

    promptX  BYTE "First number X = ", 0
    promptY  BYTE "Second number Y = ", 0
    errorMsg BYTE "ERROR: X must be greater than Y!", 0
    quitMsg  BYTE "Press 'q' to quit or any key to continue: ", 0

    result1  BYTE " + ", 0
    result2  BYTE " = ", 0
    result3  BYTE " - ", 0
    result4  BYTE " * ", 0
    result5  BYTE " / ", 0
    result6  BYTE " remainder ", 0
    goodbye  BYTE "Thanks for using Simple Arithmetic! Goodbye!", 0

    X DWORD ?
    Y DWORD ?
    sumVal DWORD ?
    diffVal DWORD ?
    revDiffVal DWORD ?
    prodVal DWORD ?
    quotient DWORD ?
    remainder DWORD ?
    userInput BYTE ?

.code
main PROC
    ; Introduction
    CALL ClrScr
    MOV  EDX, OFFSET introMsg
    CALL WriteString
    CALL CrLf
    MOV  EDX, OFFSET instrMsg
    CALL WriteString
    CALL CrLf

    ; Display Extra Credit Features
    MOV  EDX, OFFSET excMsg1
    CALL WriteString
    CALL CrLf
    MOV  EDX, OFFSET excMsg2
    CALL WriteString
    CALL CrLf
    MOV  EDX, OFFSET excMsg3
    CALL WriteString
    CALL CrLf
    MOV  EDX, OFFSET excMsg4
    CALL WriteString
    CALL CrLf

repeat_program:
    ; Prompt for X
    MOV  EDX, OFFSET promptX
    CALL WriteString
    CALL ReadInt
    MOV  X, EAX

    ; Prompt for Y
    MOV  EDX, OFFSET promptY
    CALL WriteString
    CALL ReadInt
    MOV  Y, EAX

    ; Ensure X > Y
    CMP  X, Y
    JG   continue_input
    MOV  EDX, OFFSET errorMsg
    CALL WriteString
    CALL CrLf
    JMP  repeat_program

continue_input:
    ; Perform calculations
    MOV  EAX, X
    ADD  EAX, Y
    MOV  sumVal, EAX

    MOV  EAX, X
    SUB  EAX, Y
    MOV  diffVal, EAX

    MOV  EAX, Y
    SUB  EAX, X
    MOV  revDiffVal, EAX

    MOV  EAX, X
    IMUL Y
    MOV  prodVal, EAX

    ; Compute quotient and remainder
    MOV  EAX, X
    CDQ                     ; Sign-extend EAX into EDX for signed division
    IDIV Y                  ; Divide X by Y
    MOV  quotient, EAX      ; Store quotient
    MOV  remainder, EDX     ; Store remainder

    ; Display results
    CALL CrLf
    MOV  EAX, X
    CALL WriteInt
    MOV  EDX, OFFSET result1
    CALL WriteString
    MOV  EAX, Y
    CALL WriteInt
    MOV  EDX, OFFSET result2
    CALL WriteString
    MOV  EAX, sumVal
    CALL WriteInt
    CALL CrLf

    MOV  EAX, X
    CALL WriteInt
    MOV  EDX, OFFSET result3
    CALL WriteString
    MOV  EAX, Y
    CALL WriteInt
    MOV  EDX, OFFSET result2
    CALL WriteString
    MOV  EAX, diffVal
    CALL WriteInt
    CALL CrLf

    ; Handle negative difference and compute Y - X
    MOV  EAX, Y
    CALL WriteInt
    MOV  EDX, OFFSET result3
    CALL WriteString
    MOV  EAX, X
    CALL WriteInt
    MOV  EDX, OFFSET result2
    CALL WriteString
    MOV  EAX, revDiffVal
    CALL WriteInt
    CALL CrLf

    MOV  EAX, X
    CALL WriteInt
    MOV  EDX, OFFSET result4
    CALL WriteString
    MOV  EAX, Y
    CALL WriteInt
    MOV  EDX, OFFSET result2
    CALL WriteString
    MOV  EAX, prodVal
    CALL WriteInt
    CALL CrLf

    MOV  EAX, X
    CALL WriteInt
    MOV  EDX, OFFSET result5
    CALL WriteString
    MOV  EAX, Y
    CALL WriteInt
    MOV  EDX, OFFSET result2
    CALL WriteString
    MOV  EAX, quotient
    CALL WriteInt
    MOV  EDX, OFFSET result6
    CALL WriteString
    MOV  EAX, remainder
    CALL WriteInt
    CALL CrLf

    ; Ask user if they want to quit
    CALL CrLf
    MOV  EDX, OFFSET quitMsg
    CALL WriteString
    CALL ReadChar
    MOV  userInput, AL

    CMP  userInput, 'q'
    JE   exit_program
    JMP  repeat_program

exit_program:
    ; Goodbye message
    CALL CrLf
    MOV  EDX, OFFSET goodbye
    CALL WriteString
    CALL CrLf

    ; Exit program
    CALL WaitMsg
    EXIT
main ENDP

END main
