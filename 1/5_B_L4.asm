bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data

;Se da un sir A de dwords 
;Construiti doua siruri de octeti
    ;B1: contine ca elemente partea inferioara a cuvintelor inferioare din A 
    ;B2: contine ca elemente partea superioara a cuvintelor superioare din A  

    a dd 11223344h, 1A2B3C4Dh     ; in memory: 44 | 33 | 22 | 11 | 4D | 3C | 2B | 1A
                                             ; s+0  s+1  s+2  s+3  s+4  s+5  s+6  s+7
    len_a equ ($-a)/4
    b1 times len_a db -1    ;b1 = 44, 4D
    b2 times len_a db -1    ;b2 = 11, 1A
    
; our code starts here
segment code use32 class=code
    start:
        ;b1
        mov ecx, len_a   ; pentru loop
        mov esi, 0      ;primul elem pe care il vrem in b1
        mov edi, 0
        
        repeta_b1:
            mov al, [a + esi]
            mov [b1 + edi], al
            add esi, 4
            add edi, 1
        loop repeta_b1
        
        ;b2
        mov ecx, len_a  ; pentru loop
        mov esi, 3      ;prmiul elem pe care il vrem in b2
        mov edi, 0
        repeta_b2:
            mov al, [a + esi]
            mov [b2 + edi], al
            add esi, 4
            add edi, 1
        loop repeta_b2
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
