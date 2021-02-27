bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
;Se dau 2 siruri de octeti A si B. Sa se construiasca sirul R care sa contina doar elementele impare si pozitive din cele 2 siruri.  
    ;Exemplu: 
    ;A: 2, 1, 3, -3 
    ;B: 4, 5, -5, 7 
    ;R: 1, 3, 5, 7 
    
    a db 2, 1, 3, -3
    len_a equ $-a
    b db 4, 5, -5, 7
    len_b equ $-b
    r times (len_a+len_b) db -1

; our code starts here
segment code use32 class=code
    start:
        
        mov ecx, len_a ;pregatim in ecx lungimea sirului a/b pentru loop
        mov esi, 0 ;registru contor pentru parcurgerea sirului a/b 
        mov edi, 0 ;registru contor pentru parcurgerea sirului rezultat r
        
        ;accesam element cu element din sirul a/b verificam daca e pozitiv si impar, afirmativ => adaugam in sir rezultat r
        Repeta_a:
            mov al, [a + esi]
            cmp al, 0
            jge pozitiv_a
            jl nu_adauga_a
            
            pozitiv_a:
              
                cbw 
                mov bl, 2
                div bl  ;in al-cat si ah-rest
                cmp ah, 0
                jne impar_a
                je nu_adauga_a
                    
                    impar_a:
                        mov al, [a + esi]
                        mov [r + edi], al
                        inc edi
            nu_adauga_a:
                inc esi
        loop Repeta_a
        
        
        mov ecx, len_b ;pregatim in ecx lungimea sirului a/b pentru loop
        mov esi, 0 ;registru contor pentru parcurgerea sirului a/b 

        Repeta_b:
            mov al, [b + esi]
            cmp al, 0
            jge pozitiv_b
            jl nu_adauga_b
            
            pozitiv_b:
                cbw 
                mov bl, 2
                div bl  ;in al-cat si ah-rest
                cmp ah, 0
                jne impar_b
                je nu_adauga_b
                    
                    impar_b:
                        mov al, [b + esi]
                        mov [r + edi], al
                        inc edi
            nu_adauga_b:
                inc esi
        loop Repeta_b
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
