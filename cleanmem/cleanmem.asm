    processor 6502

    seg code        ; code segment
    org $F000       ; Define the code origin at $F000

Start:              ; Lable to a memory address (in this case $F000)
    sei             ; Disable interrups
    cld             ; Disable the BCD decimal math mode
    ldx #$FF        ; Load the X register with the literal #$FF
    txs             ; Transfer the X regiter to the (S)tack pointer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Clear page zero region (from registers 00 through FF)
; Clear the entire RAM and the TIA resgisters
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda #0          ; A = 0
    ldx #$FF        ; X = #$FF (now I have 0 in the acum and I have FF in the X register)
    sta $FF         ; Make sure that the $FF is zeroed befor the loop starts
MemLoop:
    dex             ; x--
    sta $0,X        ; Store value of A into memory addr $0 added to whaterver is in X (to be able to interact with the ALU)
    bne MemLoop     ; branch if not equal (Z Flag) to MemLoop (loop until X == 0)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Fill the ROM size to 4Kb
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    org $FFFC
    .word Start     ; Reset vector at $FFFC (where the program starts)
    .word Start     ; Interrupt Vector $FFFE (2 bytes further) (won't be used in VCS)




