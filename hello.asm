;****************************************************************************************************************************
;Program name: "Assignment 1".  This program greets a user by their inputted name  *
;and title.  Copyright (C) 2021  Gabriel Gamboa                                                                                 *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.                                                                    *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;****************************************************************************************************************************



;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
;Author information
;  Author name: Gabriel Gamboa
;  Author email: gabe04@csu.fullerton.edu
;
;Program information
; Program name: Assignment 1
;  Programming languages X86 with one module in C++
;  Date program began 2021-Sep-18
;  Date program completed 2021-Sep-19
;
;Purpose
;  This program greets users and asks them about their days.
;
;Project information
;  Files: welcome.cpp, hello.asm, r.sh
;  Status: The program has been tested extensively with no detectable errors.
;
;Translator information
;  Linux: nasm -f elf64 -l hello.lis -o hello.o hello.asm


;============================================================================================================================================================



extern printf

extern scanf

extern fgets

extern strlen

extern stdin

global hello                                          ;hello is calling point for functions outside hello.asm

segment .data                                               ;segment .data is for initialized arrays (data)

;=========================================================================================================================================================
;identifiers are pointers to strings

align 16                                                   ;starts next data declartion on a 16-byte boundary

hello.promptname db "Please enter your first and last names: ", 0

hello.prompttitle db "Please enter your title (Ms, Mr, Engineer, Programmer, Mathematician, Genius, etc): ", 0

hello.hello_day db "Hello %s %s. How has your day been so far? ", 0

;hello.daystatus db ". How has your day been so far? ", 0

hello.dayresponse db " is really nice.", 10, 0

conclusion db "This concludes the demonstration of the Hello program written in x86 assembly.", 10, 0

stringformat db "%s", 0                                     ;typical way to format string
align 64                                                    ;starts next data declartion on a 64-byte boundary
segment .bss                                                ;un-initialized arrays in this segment.

hello.programmers_name resb 32                        ;32 byte space created
hello.programmers_title resb 32                        ;32 byte space created
hello.programmers_day resb 32                        ;32 byte space created

;==========================================================================================================================================================================
;==========================================================================================================================================================================
;==========================================================================================================================================================================

segment .text                                               ;executable instructions go here

hello:                                                ;This is where execution starts

;Push and move that should be at the start of every assembly program.
push       rbp                                              ;new stack frame for this functions execution
mov        rbp, rsp                                         ;rbp has address of the start of the new stack frame. original Rbp value should be restored when function returns to caller


;=========== Show the initial message =====================================================================================================================================
;no important data in registers to be saved rn.  Two pushes because of this

;=========== Prompt for user's name =================================================================================================================================

mov qword  rax, 0                                           ;No floats used
mov        rdi, stringformat                                ;
mov        rsi, hello.promptname                            ;"Please enter your first and last names: "
call       printf                                           ;C++ printf() function handles the output

;===== Obtain the programmer's name =============================================================================================================================================


mov qword rax, 0                                            ;no floats in scanf?
mov       rdi, hello.programmers_name                       ;Start of array address to rdi
mov       rsi, 32                                           ;Size of input available to fgets for inputs
mov       rdx, [stdin]                                      ;rdx gets the inputting thing
call      fgets                                             ;gets a line of text less than 31 chars or stops when NULL is reached

;remove new line character from input of programmer name
mov rax, 0                                              ;No floats used
mov rdi, hello.programmers_name                         ;Once the name is in rdi we can call strlen to get the length of the name. rdi is parameter in strlen
call strlen                                             ;call the C function strlen to get length
mov r14, rax                                            ;r14 contains the length of the string. I guess it's stored in rax after strlen is called
mov r15, 0                                              ;i was having bugs and heard this helps, not sure if this was ultimately what did the trick
mov [hello.programmers_name + r14 -1],r15               ;new line character is 1 less than the last character in the string so that's where the -1 comes in
                                                        ;we replace it with 0 so that's why we do the ,r15
                                                        ;i don't know why we have to put in the [hello.programmers_name + r14 - 1]
                                                        ;or what the brackets are for. I'd think it would work without the hello.programmers_name, assuming the length is stored in r14
;=========== Prompt for programmer's title =================================================================================================================================

mov qword  rax, 0                                           ;No floats used
mov        rdi, stringformat                                ;
mov        rsi, hello.prompttitle                           ;"Please enter your title (Ms, Mr, Engineer, Programmer, Mathematician, Genius, etc): "
call       printf                                           ;C++ printf() function handles the output

;===== Obtain the programmer's title =============================================================================================================================================


mov qword rax, 0                                            ;no floats in scanf?
mov       rdi, hello.programmers_title                      ;Start of array address to rdi
mov       rsi, 32                                           ;Size of input available to fgets for inputs
mov       rdx, [stdin]                                      ;rdx gets the inputting thing
call      fgets                                             ;gets a line of text less than 31 chars or stops when NULL is reached

;remove new line character from input of programmer title
mov rax, 0                                              ;No floats used
mov rdi, hello.programmers_title                        ;Once the title is in rdi we can call strlen to get the length of the name. rdi is parameter in strlen
call strlen                                             ;call the C function strlen to get length
mov r14, rax                                            ;r14 contains the length of the string. I guess it's stored in rax after strlen is called
mov r15, 0                                              ;i was having bugs and heard this helps, not sure if this was ultimately what did the trick
mov [hello.programmers_title + r14 -1],r15              ;new line character is 1 less than the last character in the string so that's where the -1 comes in
                                                        ;we replace it with 0 so that's why we do the ,r15
                                                        ;i don't know why we have to put in the [hello.programmers_title + r14 - 1]
                                                        ;or what the brackets are for. I'd think it would work without the hello.programmers_name, assuming the length is stored in r14

;===== Reply to the user w/ title and name and ask about their day ==================================================================================================================================================
mov        rax, 0                                           ;No floats used
;mov        rdi, stringformat
mov        rdi, hello.hello_day
mov        rsi, hello.programmers_title                      ;"Hello %s %s. How has your day been so far? "
mov        rdx, hello.programmers_name
call       printf                                           ;C++ printf() function handles the output

;===== Obtain the programmer's day status =============================================================================================================================================


mov qword rax, 0                                            ;no floats in scanf?
mov       rdi, hello.programmers_day                        ;Start of array address to rdi
mov       rsi, 32                                           ;Provide to fgets the size of the storage made available for input
mov       rdx, [stdin]                                      ;rdx gets the inputting thing
call      fgets                                             ;gets a line of text less than 31 chars or stops when NULL is reached

;remove new line character from input of programmer title
mov rax, 0                                              ;No floats used
mov rdi, hello.programmers_day                          ;Once the day status repsonse is in rdi we can call strlen to get the length of the name. rdi is parameter in strlen
call strlen                                             ;call the C function strlen to get length
mov r14, rax                                            ;r14 contains the length of the string. I guess it's stored in rax after strlen is called
mov r15, 0                                              ;i was having bugs and heard this helps, not sure if this was ultimately what did the trick
mov [hello.programmers_day + r14 -1],r15                ;new line character is 1 less than the last character in the string so that's where the -1 comes in
                                                        ;we replace it with 0 so that's why we do the ,r15
                                                        ;i don't know why we have to put in the [hello.programmers_title + r14 - 1]
                                                        ;or what the brackets are for. I'd think it would work without the hello.programmers_day, assuming the length is stored in r14

;===== Reply to user's day response ==================================================================================================================================================
mov        rax, 0                                           ;No floats used
mov        rdi, stringformat                                ;
mov        rsi, hello.programmers_day                       ;Place a pointer to the programmer's name in rsi
call       printf                                           ;C++ printf() function handles the output

mov        rax, 0                                           ;No floats used
mov        rdi, stringformat                                ;
mov        rsi, hello.dayresponse                           ;" is really nice "
call       printf                                           ;C++ printf() function handles the output



;======= Concluding message ============================================================================================================================================

mov qword rax, 0                                            ;No floats used
mov       rdi, stringformat                                 ;
mov       rsi, conclusion                                   ;"This concludes the demonstration of the Hello program written in x86 assembly."
call      printf                                            ;C++ printf() function handles the output

;=========== Return programmer's name to the calling program ========================================================================================================

mov       rax, hello.programmers_name                           ;Programmer's name to be passed back into C++ file


;===== pointer is restored ==============================================================================

pop        rbp                                              ;returned to same state

ret                                                         ;return to calling program
;========== End of program hello.asm ================================================================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
