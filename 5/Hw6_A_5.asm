bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf               ; tell nasm that exit exists even if we won't be defining it
import scanf msvcrt.dll
import printf msvcrt.dll
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
 a dd 0
 b dd 0
 quotient dd 0
 remainder dd 0
 
 format_print_insertA db 'Insert a value for a = ', 0
 format_print_insertB db 'Insert a value for b = ', 0
 format_read_number db '%d', 0
 format_print_rezultat db 'Quotient = %d, remainder = %d.', 0 


; our code starts here
segment code use32 class=code
    start:
        
        push dword format_print_insertA
        call[printf]
        add esp, 4*1
        
        
        push dword a
        push dword format_read_number
        call[scanf]
        add esp, 4*2
        
       
        push dword format_print_insertB
        call[printf]
        add esp, 4*1
        
     
        push dword b
        push dword format_read_number
        call[scanf]
        add esp, 4*2        
        
        mov eax, [a]
        cdq
        mov ebx, [b]
        idiv ebx
        mov [quotient], eax
        mov [remainder], edx
       
        push dword [remainder]
        push dword [quotient]
        push dword format_print_rezultat
        call [printf]
        add esp, 4*3
        
       
        push    dword 0 
        call    [exit]       

