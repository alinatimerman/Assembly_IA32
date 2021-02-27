bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data

;Se da un sir S de dublucuvinte.  
;Sa se obtina sirul D format din octetii inferiori ai cuvintelor inferioare din elementele sirului de dublucuvinte,
;care sunt multipli de 7  

    s dd 11223344h, 1A2B3C4Dh, 0A1B2C3D4h, 11223377h     ; in memory: 44 | 33 | 22 | 11 | 4D | 3C | 2B | 1A | D4 | C3 | B2 | A1
                                                         ;           s+0  s+1  s+2  s+3  s+4  s+5  s+6  s+7  s+8  s+9  s+10 s+11
    len_s equ ($-s)/4
    d times len_s db -1    ;b1 = D4 C3 


; our code starts here
segment code use32 class=code
    start:
        cld
        mov ecx, len_s ;pregatim in ecx lungimea sirului s pentru loop
        mov esi, 0 ;registru contor pentru parcurgerea sirului s
        mov edi, d ;registru contor pentru parcurgerea sirului rezultat d
        
        repeta:
            mov al, [s + esi]            
            cbw 
            mov bl, 7
            idiv bl  ;in al-cat si ah-rest
            cmp ah, 0
            je adauga
            jne nu_adauga
                    
                    adauga:
                        mov al, [s + esi]
                        stosb
            nu_adauga:
                add esi, 4
        loop repeta
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
