/*
 * Filename: isDivisible.s
 * Author: Charles Li
 * Userid: cs30xdx
 * Description: Checks if num is evenly divisible by divisor. Divisor must
 		also be within the limits of 2 and LONG_MAX.
 *		Called from main()
 * Date: April 17, 2017
 * Sources of Help: None
 */
 	
 	 
 	.global isDivisible



	.section ".text"

	BOT_BOUND = 2 
	LONG_MAX = 0x7FFFFFFF

/*
 * Function name: isDivisible()
 * Function prototype: long isDivisible( long num, long divisor );
 * Description: Checks if divisor is between 2 and LONG_MAX, and if num is
 		evenly divisible by divisor.
 * Parameters:
 *	arg 1: long num     - number to check.
 *	arg 2: long divisor - number by which num is divided
 *
 * Side effects: None.
 * Error Conditions: divisor is not within [2 - LONG_MAX]
 * Return Value: If an error occurs, returns -1. Otherwise, returns 1 to
 *		 to represent true, or 0 to represent false.
 *
 * Registers Used:
 *     %i0 - arg 1 -- number to check; also used to return the result.
 *     %i1 - arg 2 -- divisor with which num's divisibility is checked
 */
 isDivisible:
 		save	%sp, -96, %sp

		mov	%i0, %l0
		mov	%i1, %l1

		mov	%l1, %o0		! set up for withinLimits
		mov	BOT_BOUND, %o1		! ( num, 2, LONG_MAX )
		set	LONG_MAX, %o2

		call	withinLimits
		nop	!checks if divisor is between 2 and LONG_MAX

		cmp	%o0, 0			! if divisor is out of bounds
		be	err			! return -1
		nop

		mov	%l0, %o0
		mov	%l1, %o1
		call	.rem			! calculate num % divisor
		nop

		cmp	%o0, 0			! if num/divisor has remainder
		bne	not_divis		! then not divisible
		nop

		mov	1, %i0			! divisor is in bounds and
		ret				! num is divisible by divisor
		restore

	err:					! divisor is not between 2 and
		mov	-1, %i0			! LONG_MAX so return -1
		ret
		restore
	
	not_divis:				! num not divisible by divisor
		mov	0, %i0			! so return 0
		ret
		restore

