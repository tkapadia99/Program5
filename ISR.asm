; ISR.asm
; Name:Tyler Kapadia & Ari Takvorian
; UTEid: tak2242 & abt734
; Keyboard ISR runs when a key is struck
; Checks for a valid RNA symbol and places it at x4600
               .ORIG x2600
ST R0, ST0
ST R1, ST1
ST R2, ST2
ST R7, ST7

LDI R1, KBDR
LD R2, A
ADD R2, R1, R2
BRz DONE

LD R2, U
ADD R2, R1, R2
BRz DONE

LD R2, C
ADD R2, R1, R2
BRz DONE

LD R2, G
ADD R2, R1, R2
BRz DONE

BRnp RETURN

DONE
STI R1, ISRSTACK

RETURN
LD R0, ST0
LD R1, ST1
LD R2, ST2
LD R7, ST7

RTI

A .FILL #-65
U .FILL #-85
C .FILL #-67
G .FILL #-71
KBDR .FILL xFE02
ISRSTACK .FILL x4600
ST0 .BLKW 1
ST1 .BLKW 1
ST2 .BLKW 1
ST7 .BLKW 1

		.END
