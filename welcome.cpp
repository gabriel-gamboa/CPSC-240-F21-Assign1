//****************************************************************************************************************************
//Program name: "Assignment 1".  This program greets a user by their inputted name  *
//and title.  Copyright (C) 2021  Gabriel Gamboa                                                                                 *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
//****************************************************************************************************************************




// ;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
// ;Author information
// ;  Author name: Gabriel Gamboa
// ;  Author email: gabe04@csu.fullerton.edu
// ;
// ;Program information
// ; Program name: Assignment 1
// ;  Programming languages X86 with one module in C++
// ;  Date program began 2021-Sep-18
// ;  Date program completed 2021-Sep-19
// ;
// ;Purpose
// ;  This program greets users and asks them about their days.
// ;
// ;Project information
// ;  Files: welcome.cpp, hello.asm, r.sh
// ;  Status: The program has been tested extensively with no detectable errors.
// ;
// ;Translator information
// ;  Linux: nasm -f elf64 -l hello.lis -o hello.o hello.asm
//
//
// ;============================================================================================================================================================

#include <stdio.h>
#include <stdint.h>
#include <ctime>
#include <cstring>
#include <string>

extern "C" char* hello();

int main(int argc, char* argv[]){

  char* return_code;

  printf("%s","Welcome to this friendly ‘Hello’ program created by Gabriel Gamboa.\n");
  return_code = hello();
  printf("%s %s", "Stay away from viruses",return_code);
  printf(".\nBye. The integer zero will now be returned to the operating system.\n");
  return 0;                                                 //

}//End of main
//========================================================================================================
