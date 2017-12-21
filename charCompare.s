/*
 * Filename: charCompare.s
 * Author: Charles Li
 * Userid: cs30xdx
 * Description: Compares two characters and returns -1 if the first char is
 *		smaller, 0 if the char's are the same, or 1 if the first char
 *		is bigger.
 * Date: May 15 2017
 * Sources of Help: None
 */

 		.global charCompare

		.section ".text"

/*
 * Function name: charCompare()
 * Function prototype: int charCompare( void const * p1, void const * p2 );
 * Description: Compares two characters and returns the comparison value
 * Parameters:
 *	arg 1: void const * p1 - pointer to the first char
 *	arg 2: void const * p2 - pointer to the second char
 *
 * Side effects: None.
 * Error Conditions: None.
 * Return Value: -1 if the first char is smaller, 0 if the char's are the same,
 *		 or 1 if the first char is bigger.
 *
 * Registers Used:
 *	%o0 - arg 1 -- pointer to first char to compare
 *	%o1 - arg 2 -- pointer to second char to compare
 *	%o2 - hold the char arg 1 points to
 *	%o3 - hold the char arg 2 points to
 */
 charCompare:
 		! no save because leaf subroutine

		ldub	[%o0], %o2	! dereference pointers to get chars
		ldub	[%o1], %o3

		cmp	%o2, %o3	! if chars aren't equal don't return 0
		bne	not_equal
		nop

equal:		mov	0, %o0		! return 0 if they are
		retl
		nop

not_equal:	cmp	%o2, %o3	! if first char is bigger than second
		bg	first_big	! 1 will be returned
		nop

first_small:	mov	-1, %o0		! return -1 if first char smaller than
		retl			! second char
		nop

first_big:	mov	1, %o0		! return 1 if first char bigger than
		retl			! second char
		nop
