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
    a db 1, -2, -3, 4 ;1 FE FD 4
    len_a equ $-a
    b db -10, 1, 13, -1 ; F6 1 0D FF
    len_b equ $-b
    rez times (len_a+ len_b) db 0 ;rez= FE FD F6 FF

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov eax,0
        mov ebx, 0
        mov ecx,0
        mov edx,0
        mov esi, 0
        mov edi, 0
        mov ecx, len_a
        
        Repeta:
            mov al, [a+esi]
            cmp al, 0
            jge pozitive
            jl negative
                pozitive:
                   inc esi
                negative:
                    mov al, [a+esi]
                    mov [rez+edi], al
                    inc esi
                    inc edi
        loop Repeta
        
        
        mov esi, 0
        mov ecx, len_b
        Repeta1:
            mov al, [a+esi]
            cmp al, 0
            jge pozitive1
            jl negative1
                pozitive1:
                   inc esi
                negative1:
                    mov al, [b+esi]
                    mov [rez+edi], al
                    inc esi
                    inc edi
        loop Repeta1
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
