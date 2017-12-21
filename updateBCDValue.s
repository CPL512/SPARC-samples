/*
 * Filename: updateBCDValue.s
 * Author: Charles Li
 * Userid: cs30xdx
 * Description: Increments the BCD nibble and checks if the next nibble should 
 *              be incremented.
 * Date: May 01 2017
 * Sources of Help: None
 */

 	.global updateBCDValue

	.section ".text"

/*
 * Function name: updateBCDValue()
 * Function prototype: unsigned char updateBCDValue( unsigned char BCDbits,
 *                                                const unsigned int maxValue);
 * Description: Increments the 4 BCD bits passed in as BCDbits and checks if
 *              the next nibble should be incremented by comparing to maxValue.
 * Parameters:
 *	arg 1: unsigned char BCDbits 	   - the 4 bits to increment
 *	arg 2: const unsigned int maxValue - the maximum value of BCDbits
 *
 * Side effects: None
 * Error Conditions: None
 * Return Value: 0 if incremented BCDbits > maxValue, or incremented BCDbits if
 *		 not.
 *
 * Registers Used:
 *     %i0 - arg 1 -- 4 bits to increment
 *     %i1 - arg 2 -- maximum value of BCDbits
 */
updateBCDValue:
 		
		save	%sp, -96, %sp

		inc	%i0			! increment BCDbits
		cmp	%i0, %i1		! check BCDbits > maxValue
		bg	over_max		! if true, return 0
		nop

		ret
		restore

over_max:	mov	0, %i0			! return 0 if
		ret				! BCDbits > maxValue
		restore
