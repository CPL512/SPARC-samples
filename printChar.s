/*
 * Filename: printChar.s
 * Author: Charles Li
 * Userid: cs30xdx
 * Description: Prints the character argument to stdout
 *		Called from drawTriangles()
 * Date: April 23, 2017
 * Sources of Help: None
 */

 	.global printChar


	.section ".data"
fmt:						! format string to print char
	.asciz "%c"


	.section ".text"

/*
 * Function name: printChar()
 * Function prototype: void printChar( char c );
 * Description: Prints the char arg to stdout
 * Parameters:
 *	arg 1: char c  - character to print
 *
 * Side effects: None
 * Error Conditions: None
 * Return Value: None
 *
 * Registers Used:
 *     %i0 - arg 1 -- character to print
 */
 printChar:

		save	%sp, -96, %sp

		set	fmt, %o0		! set format string as param 1
		mov	%i0, %o1		! char to print is param 2
		call	printf			! printf(fmt, c)
		nop

		ret
		restore


