// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
// *R(X) represents the value stored at R(X)

// Multiplies R0 and R1 and stores the result in R2 by adding *R1
// to itself and storing the sum in R2


// Initialize R2
@R2
M=0

// loop through *R0 times
(loop)

// jump to out of loop if *R0 is 0
@R0
D=M
@end
D;JEQ

// add *R1 to *R2
@R1
D=M 
@R2
M=M+D

// Decrement *R0
@R0
M=M-1
@loop
0;JMP

(end)