/*
 * Filename: getTableIndex.s
 * Author: Charles Li
 * Userid: cs30xdx
 * Description: Calculates the index into the hashtable for the uppercase 
 *		sorted string ucSorted in a hashtable of size tableSize.
 * Date: May 15 2017
 * Sources of Help: None
 */
 		.global getTableIndex

		.section ".text"

/*
 * Function name: getTableIndex()
 * Function prototype: 
 *	int getTableIndex( char const * ucSorted, size_t tableSize );
 * Description: Calculates the index of ucSorted in a tableSize size hashtable
 * Parameters:
 *	arg 1: char const * ucSorted - the string for which index is calculated
 *	arg 2: size_t tableSize	     - the size to consider while calculating
 *
 * Side effects: None.
 * Error Conditions: None.
 * Return Value: The index of ucSorted in the hashtable
 *
 * Registers Used:
 *	%i0 - arg 1 -- the string whose index is calculated
 *	%i1 - arg 2 -- the size of the hashtable in which index is calculated
 *	%o0 - arg 1 and return values of hash and .rem
 *	%o1 - arg 2 of .rem -- tableSize
 */
 getTableIndex:
 		save	%sp, -96, %sp

		mov	%i0, %o0	! prepare for hash(ucSorted)
		call	hash		! %o0 now hashKey
		nop

		mov	%i1, %o1	! prepare for hashKey % tableSize
		call	.rem		! %o0 now tableIndex
		nop

		cmp	%o0, 0		! if tableIndex isn't negative
		bge	return		! return it
		nop

neg_index:	neg	%o0, %o0	! if negative, negate it to positive

return:		mov	%o0, %i0	! return calculated index
		ret
		restore
