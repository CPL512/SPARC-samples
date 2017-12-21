/*
 * Filename: searchCompare.s
 * Author: Charles Li
 * Userid: cs30xdx
 * Description: Compares two struct Anagrams using their sorted words
 * Date: May 15 2017
 * Sources of Help: None
 */

 		.global searchCompare

		.section ".text"

/*
 * Function name: searchCompare()
 * Function prototype: int searchCompare( void const * p1, void const * p2 );
 * Description: Compares two struct Anagrams and returns the comparison value
 * Parameters:
 *	arg 1: void const * p1 - pointer to the first Anagram
 *	arg 2: void const * p2 - pointer to the second Anagram
 *
 * Side effects: None.
 * Error Conditions: None.
 * Return Value: -1 if the first sorted word is smaller, 0 if the two sorted
 *		 words are the same, or 1 is the first sorted word is larger
 *
 * Registers Used:
 *	%i0 - arg 1 -- pointer to first Anagram to compare, also used to return
 *	%i1 - arg 2 -- pointer to second Anagram to compare
 *	%l0 - pointer to sortedWord of first Anagram
 *	%l1 - pointer to sortedWord of second Anagram
 *	%l2 - offset of sortedWord in Anagram
 *	%o0 - arg 1 of strcmp -- first sortedWord, also return value
 *	%o1 - arg 2 of strcmp -- second sortedWord
 */
 searchCompare:
		save	%sp, -96, %sp

		set	sortedWordOffset, %l2	! set offset of sortedWord
		ld	[%l2], %l2		! for dereferencing later
		add	%i0, %l2, %l0		! find pointer to first word
		add	%i1, %l2, %l1		! find pointer to second word

		mov	%l0, %o0		! prepare args for
		mov	%l1, %o1		! strcmp(word1, word2)
		call	strcmp
		nop

		cmp	%o0, 0			! strcmp didn't return 0
		bne	not_equal		! means words aren't equal
		nop

equal:		mov	0, %i0			! if it did return 0, the words
		ret				! are equal and 0 is returned
		restore

not_equal:	cmp	%o0, 0			! strcmp returned 1, first
		bg	first_big		! word is bigger
		nop

first_small:	mov	-1, %i0			! strcmp returned -1, so first
		ret				! word is smaller
		restore

first_big:	mov	1, %i0			! strcmp returned 1, so first
		ret				! word is bigger
		restore
