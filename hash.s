/*
 * Filename: hash.s
 * Author: Charles Li
 * Userid: cs30xdx
 * Description: Creates and returns the hash key of a string
 * Date: May 15 2017
 * Sources of Help: None
 */
 		.global hash

		.section ".text"

/*
 * Function name: hash()
 * Function prototype: int hash( char const * str );
 * Description: Creates and returns the hash key of str
 * Parameters:
 *	arg 1: char const * str - the string whose hash key is created
 *
 * Side effects: None.
 * Error Conditions: None.
 * Return Value: The hash key of str
 *
 * Registers Used:
 *	%i0 - arg 1 -- string whose hash key is created, also return value
 *	%l0 - hash, the hash key of str while calculating
 *	%l1 - strLen, the length of str
 *	%l2 - int i in a for loop
 *	%o0 - arg 1 of strlen and .mul
 *	%o1 - arg 2 of .mul
 */
 hash:
 		save	%sp, -96, %sp

		set	HashStartVal, %l0	! set address of HashStartVal
		ld	[%l0], %l0		! map hash to %l0

		mov	%i0, %o0		! prepare for strlen(str)
		call	strlen
		nop

		mov	%o0, %l1		! map strLen to %l1

		mov	0, %l2			! begin for loop, declare i
		cmp	%l2, %l1		! opposite logic to skip for
		bge	post_for
		nop

for:		mov	%l0, %o0		! first prepare for
		set	HashPrime, %o1		! hash * HASH_PRIME by setting
		ld	[%o1], %o1		! address of HashPrime
		call	.mul
		nop

		ldub	[%i0 + %l2], %o1	! find str[i] which is a char
		add	%o0, %o1, %l0		! hash * HASH_PRIME + str[i]
						! set hash equal to the above
		inc	%l2			! end of for, increment i

		cmp	%l2, %l1		! if i < strLen still true,
		bl	for			! repeat loop
		nop

post_for:	mov	%l0, %i0		! return hash after the loop
		ret
		restore
