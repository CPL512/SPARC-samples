/*
 * Filename: numOfDigits.s
 * Author: Charles Li
 * Userid: cs30xdx
 * Description: Counts the number of digits in num in the given base.
 *		Called from drawTriangles()
 * Date: April 18, 2017
 * Sources of Help: None
 */

 	.global numOfDigits


	.section ".text"
	MIN_BASE = 2
	MAX_BASE = 36

/*
 * Function name: numOfDigits()
 * Function prototype: long isDivisible( long num, long base );
 * Description: Counts the number of digits in num in the given base
 * Parameters:
 *	arg 1: long num  - number whose digits are counted.
 *	arg 2: long base - base in which digits are counted.
 *
 * Side effects: None.
 * Error Conditions: base is not within [2 - 36]
 * Return Value: If an error occurs, returns -1. Otherwise, returns the number
 		 of digits in num of the given base.
 *
 * Registers Used:
 *     %i0 - arg 1 -- number to check; also used to return the result.
 *     %i1 - arg 2 -- base in which num's digits are counted
 */
 numOfDigits:
 		save	%sp, -96, %sp

		mov	%i0, %l0		! save args in local registers
		mov	%i1, %l1

		mov	%l1, %o0		! check if base is in bounds
		mov	MIN_BASE, %o1		! using withinLimits
		mov	MAX_BASE, %o2		! (base, minBase, maxBase)

		call	withinLimits		! returns in o0
		nop

		cmp	%o0, 0			! base not between 2 and 36
		be	err			! means error, return -1
		nop

		mov	0, %i0			! map count to i0
		mov	%l0, %o0		! map num to o0
		mov	%l1, %o1		! map base to o1

	loop:	call	.div			! calculate num/base
		nop

		inc	%i0			! minimum 1 digit
		
		cmp	%o0, 0
		bne	loop			! end of loop
		nop

		ret				! count is already in i0
		restore

	err:					! divisor is not between 2 and
		mov	-1, %i0			! 36 so return -1
		ret
		restore
