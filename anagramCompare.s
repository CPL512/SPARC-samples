/*
 * Filename: anagramCompare.s
 * Author: Charles Li
 * Userid: cs30xdx
 * Description: Compares two Anagrams first using their sorted words, then by
 *		their original words if the sorted words are the same.
 * Date: May 15 2017
 * Sources of Help: Christoph Steefel
 */

 		.global anagramCompare

		.section ".text"

/*
 * Function name: anagramCompare()
 * Function prototype: int anagramCompare( void const * p1, void const * p2 );
 * Description: Compares two Anagrams and returns the comparison value
 * Parameters:
 *	arg 1: void const * p1 - pointer to the first Anagram
 *	arg 2: void const * p2 - pointer to the second Anagram
 *
 * Side effects: None.
 * Error Conditions: None.
 * Return Value: -1 if the first Anagram is smaller, 0 if the Anagrams are the
 *		 same, or 1 if the first Anagram is bigger.
 *
 * Registers Used:
 *	%i0 - arg 1 -- pointer to first Anagram to compare, also used to return
 *	%i1 - arg 2 -- pointer to second Anagram to compare
 *	%l0 - pointer to sortedWord or word of first Anagram
 *	%l1 - pointer to sortedWord or word of second Anagram
  *	%l2 - offset of sortedWord or word in Anagram
 *	%o0 - arg 1 of strcmp -- first sortedWord or word, also return value
 *	%o1 - arg 2 of strcmp -- second sortedWord or word
 */
 anagramCompare:
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
		bne	not_equal		! means sortedWords aren't
		nop				! equal

sort_equal:
		set	wordOffset, %l2		! set offset of word for
		ld	[%l2], %l2		! dereferencing later
		add	%i0, %l2, %l0		! find pointer to first word
		add	%i1, %l2, %l1		! find pointer to second word

		ld	[%l0], %l0		! pointing to pointer, so it
		ld	[%l1], %l1		! needs to be dereferenced

		mov	%l0, %o0		! prepare args for
		mov	%l1, %o1		! strcmp(word1, word2)
		call	strcmp
		nop

		cmp	%o0, 0			! strcmp didn't return 0
		bne	not_equal		! means words aren't equal
		nop

word_equal:
		mov	0, %i0			! if it did return 0, the
		ret				! sortedWords and words are
		restore				! both equal

not_equal:	
		cmp	%o0, 0			! sortedWords or words 
		bg	first_big		! different, check strcmp 
		nop				! return for return value

first_small:
		mov	-1, %i0			! strcmp returned -1, so first
		ret				! Anagram is smaller
		restore

first_big:	
		mov	1, %i0			! strcmp returned 1, so first
		ret				! Anagram is bigger
		restore
