/*
 * Filename: withinLimits.s
 * Author: Charles Li
 * Userid: cs30xdx
 * Description: Checks if num is within the limits defined by min and max,
 		inclusively.
 *		Called from isDivisible(), numOfDigits(), and main()
 * Date: April 17, 2017
 * Sources of Help: None
 */
 
 	.global withinLimits


	.section ".text"

/*
 * Function name: withinLimits()
 * Function prototype: long withinLimits( long num, long min, long max );
 * Description: Checks if num is within the limits of min and max, inclusive
 * Parameters:
 *	arg 1: long num - number to check.
 *	arg 2: long min - bottom boundary of limit
 *	arg 3: long max - top boundary of limit
 *
 * Side effects: None.
 * Error Conditins: min is greater than max
 * Return Value: If an error occurs, returns -1. Otherwise, returns 1 to
 *		 to represent true, or 0 to represent false.
 *
 * Registers Used:
 *     %i0 - arg 1 -- number to check; also used to return the result.
 *     %i1 - arg 2 -- minimum bound
 *     %i2 - arg 3 -- maximum bound
 */
 withinLimits:
 		save	%sp, -96, %sp


		mov	%i0, %o0
		mov	%i1, %o1
		mov	%i2, %o2

		cmp	%o1, %o2		! check for min > max
		bg	err			! return -1 if true
		nop

		cmp	%o0, %o1		! check if num < min
		bl	out_of_bound		! return 0 if true
		nop

		cmp	%o0, %o2		! check if num > max
		bg	out_of_bound		! return 0 if true
		nop

		mov	1, %i0			! never went out of bounds
		ret				! return 1 and exit
		restore
	
	err:					! return -1 if min > max
		mov	-1, %i0
		ret
		restore

	out_of_bound:				! return 0 if out of bounds
		mov	0, %i0
		ret
		restore


