; Main.asm
; Name:Tyler Kapadia & Ari Takvorian EE306 GIT GIT GIT
; UTEid: tak2242 & abt734
; Continuously reads from x4600 making sure its not reading duplicate
; symbols. Processes the symbol based on the program description
; of mRNA processing.
               .ORIG x4000
; initialize the stack pointer

LD R6, STACK

; set up the keyboard interrupt vector table entry

LD R0, ISR
STI R0, KBIVE

; enable keyboard interrupts

LD R0, KBIEN
STI R0, KBSR

; start of actual program

INIT		; no outputs, looks for A
LDI R0, STACK
BRz INIT	;loop until new input is detected
TRAP x21	;character is written to the console

AND R2, R2, 0	;clears x4600
STI R2, STACK

LD R1, A
ADD R1, R0, R1


BRz ASTATE	;branch to A if detected
BRnp INIT

ASTATE		;output A, looks for A or U
LDI R0, STACK
BRz ASTATE	;loop until new input is detected
TRAP x21

AND R2, R2, 0	;clears x4600
STI R2, STACK

LD R1, U
ADD R1, R0, R1

BRz AUSTATE	;branch to AU if U is detected

LD R1, A
ADD R1, R0, R1

BRz ASTATE		; if A is detected
BRnp INIT	;branch to init if anything else is detected

AUSTATE		;output U, looks for A or G
LDI R0, STACK
BRz AUSTATE	;loop until new input is detected
TRAP x21

AND R2, R2, 0	;clears x4600
STI R2, STACK

LD R1, G
ADD R1, R0, R1
BRz START	; branch to start if G is detected

LD R1, A
ADD R1, R0, R1
BRz ASTATE	; branch to A if A is detected

BRnp INIT	; branch to init if U or C is detected


START		;output AUG
LD R0, LINE
TRAP x21



USTATE		;output any, looks for U
LDI R0, STACK
BRz USTATE	;loop until new input is detected
TRAP x21

AND R2, R2, 0	;clears x4600
STI R2, STACK

LD R1, U
ADD R1, R0, R1

BRz UASTATE
BRnp USTATE

UASTATE ; output any, looks for A or G
LDI R0, STACK
BRz UASTATE	;loop until new input is detected
TRAP x21

AND R2, R2, 0	;clears x4600
STI R2, STACK

LD R1, A
ADD R1, R0, R1
BRz Final

LD R1, G
ADD R1, R0, R1
BRz Final2

LD R1, U
ADD R1, R0, R1
BRz UASTATE

BRnp USTATE

Final
LDI R0, STACK
BRz Final	;loop until new input is detected
TRAP x21

AND R2, R2, 0	;clears x4600
STI R2, STACK

LD R1, A
ADD R1, R0, R1
BRz DONE

LD R1, G
ADD R1, R0, R1
BRz DONE

LD R1, U
ADD R1, R0, R1
BRz UASTATE
BRnp USTATE

Final2
LDI R0, STACK
BRz Final2	;loop until new input is detected
TRAP x21

AND R2, R2, 0	;clears x4600
STI R2, STACK

LD R1, A
ADD R1, R0, R1
BRz DONE

LD R1, U
ADD R1, R0, R1
BRz UASTATE

LD R1, G
ADD R1, R0, R1
BRz USTATE
BRnp USTATE

DONE
TRAP x25

A .FILL #-65
U .FILL #-85
C .FILL #-67
G .FILL #-71
LINE .FILL #124

STACK .FILL x4600
KBIEN .FILL x4000
KBSR .FILL xFE00
KBIVE .FILL x0180
ISR .FILL x2600
		.END
