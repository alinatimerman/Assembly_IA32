bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
;Se dau 2 siruri de octeti A si B. Sa se construiasca sirul R care sa contina doar elementele pare si negative din cele 2 siruri.  
;Exemplu: 
    ;A: 2, 1, 3, -3, -4, 2, -6 
    ;B: 4, 5, -5, 7, -6, -2, 1 
    ;R: -4, -6, -6, -2 
    
    a db 2, 1, 3, -3, -4, 2, -6
    len_a equ $-a
    b db 4, 5, -5, 7, -6, -2, 1 
    len_b equ $-b
    r times (len_a+len_b) db -1

; our code starts here
segment code use32 class=code
    start:
        cld
        mov ecx, len_a ;pregatim in ecx lungimea sirului a/b pentru loop
        mov esi, 0 ;registru contor pentru parcurgerea sirului a/b 
        mov edi, r ;registru contor pentru parcurgerea sirului rezultat r
        
        ;accesam element cu element din sirul a/b verificam daca e negativ si par, afirmativ => adaugam in sir rezultat r
        Repeta_a:
            mov al, [a + esi]
            cmp al, 0
            jl negativ_a
            jge nu_adauga_a

            negativ_a:
                cbw 
                mov bl, 2
                idiv bl  ;in al-cat si ah-rest
                cmp ah, 0
                je par_a
                jne nu_adauga_a

                    par_a:
                        mov al, [a + esi]
                        stosb
            nu_adauga_a:
                inc esi
        loop Repeta_a
        
        
        mov ecx, len_b ;pregatim in ecx lungimea sirului a/b pentru loop
        mov esi, 0 ;registru contor pentru parcurgerea sirului a/b 

        Repeta_b:
            mov al, [b + esi]
            cmp al, 0
            jl negativ_b
            jge nu_adauga_b

            negativ_b:
                cbw 
                mov bl, 2
                idiv bl  ;in al-cat si ah-rest
                cmp ah, 0
                je par_b
                jne nu_adauga_b

                    par_b:
                        mov al, [b + esi]
                        stosb
            nu_adauga_b:
                inc esi
        loop Repeta_b
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
