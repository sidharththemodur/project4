// File name: Move.asm

// Runs an infinite loop that listens to the keyboard input.
// Draws a 16-by-16 square to the top left corner of the screen.
// When a key is pressed and released (any key), the rectangle is
// moved 16 pixels to the right.

// Challenge versions (please specify if you are doing one of these):
// (Only try these if they sound interesting to you.)
//   - Instead of moving in 16-pixel increments, move in 5-pixel increments.
//   - Instead of moving whenever a key is pressed and released,
//       move gradually while a key is pressed down.

// initialize tlpixel, which holds the top left pixel of the square
// to the top left corner of the screen and draw the square
(START)
@SCREEN
D=A
@tlpixel
M=D
// place square on screen
@PLACE
0;JMP

// infinite loop that moves square when kkey is pressed and released
(LOOP)

// Listens for changes at KBD, and jumps to the key release listener
// if a key is pressed
(KEYPRESSLISTENER)
@KBD
D=M
@KEYRELEASELISTENER
D;JNE
@KEYPRESSLISTENER
0;JMP

// Listens for the key to be released after being pressed,
// and after it is released, moves the square 16 pixels to the left
(KEYRELEASELISTENER)
@KBD
D=M
@KEYRELEASELISTENER
D;JNE


(MOVE)

// Clears by screen by drawing a white square over the 
// black one with the top left pixel at tlpixel
(CLEAR)
@color
M=0
@DRAW
0;JMP

// Draws either a white or a black square depending on the var color
(DRAW)
@tlpixel
D=M
// sets the write address to the first row of pixels in the square
@addr
M=D

// loops through and changes the color of a row of square at a time 
(DLOOP)

// if addr is past the last row of the square, exit the loop
@16896 // address of the last row of the square
D=A
@addr
D=D-M
@ENDDRAW
D;JLT

// color in the row with the specified color
@color // -1 if black, 0 if white
D=M
@addr
A=M
M=D

// increments the addr by 32, which is the next row in the same column
@32
D=A
@addr
M=M+D

// loops back
@DLOOP
0;JMP

// jumps back to loop if square was drawn, moves if square was cleared
(ENDDRAW)
@color
D=M
@LOOP
D;JLT

// increments the square to the next column by adding one to the top row
@tlpixel
M=M+1

// if the square is in the last column, return to starting position
D=M
@16416
D=D-A
@ENDLOOP
D;JEQ

// places a square on the screen with top left pixel at tlpixel
(PLACE)
@color
M=-1
@DRAW
0;JMP

// the end of the loop, jumps to start
(ENDLOOP)
@START
0;JMP
