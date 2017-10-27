// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// sets the block of 16 pixels to be written to the first 16 pixels
// on the screen
(START)
@SCREEN
D=A
@pixelblock
M=D

// listens to keyboard input, and if a key is pressed starts filling in
// the screen, and if it is released to clear it
(LOOP)

// if a key is being pressed, fill in the current block of pixels, else,
// clear it
@KBD
D=M
@CLEARSCREEN
D;JEQ
@COLORSCREEN
0;JMP

// clears the pixelblock and moves to the previous pixelblock
// (screen is cleaned RTL DTU)
(CLEARSCREEN)

// sets the current pixelblock to white
@pixelblock
A=M
M=0

// decrements the pixel block
@pixelblock
M=M-1

// if the screen is white, reset to the initial scrren state
@SCREEN
D=A
@pixelblock
D=M-D
@ENDLOOP
D;JLT

// jumps to beggining of loop
@LOOP
0;JMP

// colors the pixelblock and moves to the next one
// (screen is filled LTR and UTD)
(COLORSCREEN)

// if the scrren is filled, go to beggining of loop, without doing 
// anything else
@KBD
D=A
@pixelblock
D=D-M
@LOOP
D;JLE

// sets the current pixelblock to black
@pixelblock
A=M
M=-1

// increments to the next pixelblock
@pixelblock
M=M+1

// go back to beggining of the loop
@LOOP
0;JMP

// end of filling loop
(ENDLOOP)

// jump to START to return screen to initial state
@START
0;JMP

