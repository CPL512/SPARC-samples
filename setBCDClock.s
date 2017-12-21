/*
 * Filename: setBCDClock.s
 * Author: Charles Li
 * Userid: cs30xdx
 * Description: Sets the time in the BCD clock array using the hours, minutes,
 *              and seconds in tmPtr.
 * Date: May 01 2017
 * Sources of Help: Megan Wang, Stefanie Tonnu
 */
	PLACE_FACTOR = 10;
	NIBBLE_BITS = 4;
	CLOCK_HOUR = 0;
	CLOCK_MIN = 1;
	CLOCK_SEC = 2;

 	.global setBCDClock

	.section ".text"

/*
 * Function name: setBCDClock()
 * Function prototype: void setBCDClock( const struct tm * tmPtr,
 *					 unsigned char clock[] );
 * Description: Sets the time in the BCD clock array using the hours, minutes,
 *              and seconds in tmPtr.
 * Parameters:
 *	arg 1: tm* tmPtr	     - struct holding all the times to use
 *	arg 2: unsigned char clock[] - the char array holding the time
 *
 * Side effects: clock is updated
 * Error Conditions: None
 * Return Value: None
 *
 * Registers Used:
 *     %i0 - arg 1 -- struct holding the times to use
 *     %i1 - arg 2 -- unsigned char array holding the time
 *
 *     %l0 - hold each time segment while calculating
 *     %l1 - tens place of each time segment
 *     %l2 - ones place of each time segment
 *     %l3 - nibble holding combined tens and ones places
 *     %l5 - hold the offset of each time segment while calculating
 *
 *     %o0 - arg 1 for div and rem function calls
 *     %o1 - arg 2 for div and rem function calls
 */
 setBCDClock:
 		
		save	%sp, -96, %sp

		! LOAD HOUR INTO CLOCK
		set	tm_hourOffset, %l5		! keep offset in l5
		ld	[%l5], %l5			! dereference offset
		ld	[%i0 + %l5], %l0		! load tm_hour into l0

		mov	%l0, %o0			! tm_hour / 10 to get
		mov	PLACE_FACTOR, %o1		! tens place of hour
		call	.div
		nop

		mov	%o0, %l1			! map tens place to l1

		mov	%l0, %o0			! tm_hour % 10 to get
		mov	PLACE_FACTOR, %o1		! ones place of hour
		call	.rem
		nop

		mov	%o0, %l2			! map ones place to l2

		sll	%l1, NIBBLE_BITS, %l1		! shift tens 4 left
		or	%l1, %l2, %l3			! combined nibble in l3
		stb	%l3, [%i1 + CLOCK_HOUR]

		! LOAD MIN INTO CLOCK
		set	tm_minOffset, %l5		! keep offset in l5
		ld	[%l5], %l5			! dereference offset
		ld	[%i0 + %l5], %l0		! load tm_min into l0

		mov	%l0, %o0			! tm_min / 10 to get
		mov	PLACE_FACTOR, %o1		! tens place of min
		call	.div
		nop

		mov	%o0, %l1			! map tens place to l1

		mov	%l0, %o0			! tm_min % 10 to get
		mov	PLACE_FACTOR, %o1		! ones place of min
		call	.rem
		nop

		mov	%o0, %l2			! map ones place to l2

		sll	%l1, NIBBLE_BITS, %l1		! shift tens 4 left
		or	%l1, %l2, %l3			! combined nibble in l3
		stb	%l3, [%i1 + CLOCK_MIN]

		! LOAD SEC INTO CLOCK
		set	tm_secOffset, %l5		! keep offset in l5
		ld	[%l5], %l5			! dereference offset
		ld	[%i0 + %l5], %l0		! load tm_sec into l0

		mov	%l0, %o0			! tm_sec / 10 to get
		mov	PLACE_FACTOR, %o1		! tens place of sec
		call	.div
		nop

		mov	%o0, %l1			! map tens place to l1

		mov	%l0, %o0			! tm_sec % 10 to get
		mov	PLACE_FACTOR, %o1		! ones place of hour
		call	.rem
		nop

		mov	%o0, %l2			! map ones place to l2

		sll	%l1, NIBBLE_BITS, %l1		! shift tens 4 left
		or	%l1, %l2, %l3			! combined nibble in l3
		stb	%l3, [%i1 + CLOCK_SEC]

		ret
		restore
