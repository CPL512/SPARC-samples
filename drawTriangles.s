/*
 * Filename: drawTriangles.s
 * Author: Charles Li
 * Userid: cs30xdx
 * Description: Draws triangles and a border using the three given characters
 *		Called from main()
 * Date: April 23, 2017
 * Sources of Help: Natalie Duong
 */

 	.global drawTriangles

	SPACE = 0x20
	NEWLINE = 0x0A
	WIDTH_MULTIPLIER = 2
	BASE = 10


	.section ".text"

/*
 * Function name: drawTriangles()
 * Function prototype: void drawTriangles( long triWidth, char triChar1,
 *			char triChar2, char borderChar );
 * Description: Prints triangles and a border using the the three given chars
 * Parameters:
 *	arg 1: long triWidth   - width of the triangles
 *	arg 2: char triChar1   - the character composing the first triangle
 *	arg 3: char triChar2   - the character composing the second triangle
 *	arg 4: char borderChar - the character composing the border
 *
 * Side effects: None
 * Error Conditions: None
 * Return Value: None
 *
 * Registers Used:
 *	%i0 - arg 1 -- width of triangles
 *	%i1 - arg 2 -- first triangle character
 *	%i2 - arg 3 -- second triangle character
 *	%i3 - arg 4 -- border character
 */
 drawTriangles:

 		save	%sp, -96, %sp

		mov	%i0, %o0		! triWidth is param 1
		mov	BASE, %o1		! BASE is param 2
		call	numOfDigits		! numOfDigits(triWidth, BASE)
		nop

		clr	%l0
		mov	%o0, %l0		! map numDigits to l0

		mov	WIDTH_MULTIPLIER, %o0	! mul(WIDTH_MULTIPLIER *
		add	%l0, %i0, %o1		! (numDigits + triWidth)) 
		call	.mul 
		nop

		clr	%l1
		mov	%o0, %l1		! map totalWidth to l1
		inc	%l1			! totalWidth = above mul + 1

		clr	%l2			! map row to l2
		mov	0, %l2
		clr	%l3			! map col to l3
		mov	0, %l3

		cmp	%l2, %l0		! check row < numDigits
		bge	post_top		! skip top if not
		nop

top_outer:	mov	0, %l3			! reset col for inner loop
		cmp	%l3, %l1		! check col < totalWidth
		bge	top_newline		! skip top_inner if not
		nop

top_inner:	mov	%i3, %o0		! borderChar is param 1
		call	printChar		! printChar(borderChar)
		nop

		inc	%l3			! col++

		cmp	%l3, %l1		! check col < totalWidth
		bl	top_inner		! repeat inner loop if true
		nop

top_newline:	mov	NEWLINE, %o0		! newline character is param 1
		call	printChar		! printChar('\n')
		nop

		inc	%l2			! row++

		cmp	%l2, %l0		! check row < numDigits
		bl	top_outer		! repeat outer loop if true
		nop

post_top:	mov	0, %l2			! reset row to draw triangles

		cmp	%l2, %i0		! check row < triWidth
		bge	post_tri		! skip triangles if not true
		nop

tri_outer:	mov	0, %l3			! reset col for inner loop
		cmp	%l3, %l1		! check col < totalWidth
		bge	tri_newline		! skip inner loop if not true
		nop

tri_inner:					! here for documentation

check_side:	cmp	%l3, %l0		! check col < numDigits
		bl	print_side		! print borderChar if true
		nop

		sub	%l1, %l0, %o0		! o0 = totalWidth - numDigits
		cmp	%l3, %o0		! check col >= above diff
		bl	check_tri1		! skip print_side if false
		nop

print_side:	mov	%i3, %o0		! borderChar is param 1
		call	printChar		! printChar(borderChar)
		nop

		ba	tri_inner_end		! finish iteration after print
		nop

check_tri1:	cmp	%l3, %l0		! check col >= numDigits
		bl	check_buffer		! if <, then skip tri1
		nop

		add	%l0, %i0, %o0		! o0 = numDigits + triWidth
		cmp	%l3, %o0		! check col < above sum
		bge	check_buffer		! if >=, then skip tri1
		nop

print_tri1:	add	%l0, %i0, %o0		! o0 = numDigits + triWidth
		sub	%o0, %l2, %o1		! o1 = o0 - row
		dec	%o1			! o1 = o1 - 1
		cmp	%l3, %o1		! check col<(dig+width)-row-1
		bl	print_buffer		! print buffer char if true
		nop
						! above false, so print tri1
		mov	%i1, %o0		! triChar1 is param 1
		call	printChar		! printChar(triChar1)
		nop

		ba	tri_inner_end		! finish iteration after print
		nop

check_buffer:	add	%l0, %i0, %o0		! o0 = numDigits + triWidth
		cmp	%l3, %o0		! check col == above sum
		bne	else_tri2		! if false, skip buffer
		nop

print_buffer:	mov	SPACE, %o0		! space is param 1
		call	printChar		! printChar(' ')
		nop

		ba	tri_inner_end		! finish iteration after print
		nop

else_tri2:	sub	%l1, %l0, %o0		! o0 = totalWidth - numDigits
		sub	%o0, %l2, %o1		! o1 = above diff - row
		cmp	%l3, %o1		! check col<(width-digits-row)
		bge	print_buffer		! if >=, print buffer
		nop
						! else <, print triChar2
		mov	%i2, %o0		! triChar2 is param 1
		call	printChar		! printChar(triChar2)
		nop

tri_inner_end:	inc	%l3			! col++

		cmp	%l3, %l1		! check col < totalWidth
		bl	tri_inner		! repeat inner loop if true
		nop

tri_newline:	mov	NEWLINE, %o0		! newline is param 1
		call	printChar		! printChar('\n')
		nop

		inc	%l2			! row++

		cmp	%l2, %i0		! check row < triWidth
		bl	tri_outer		! repeat outer loop if true
		nop

post_tri:	mov	%l0, %l2		! row = numDigits for loop
		cmp	%l2, 0			! check row > 0
		ble	post_bot		! skip bot if not
		nop

bot_outer:	mov	%l1, %l3		! reset col for inner loop
		cmp	%l3, 0			! check col > 0
		ble	bot_newline		! skip bot_inner if not
		nop

bot_inner:	mov	%i3, %o0		! borderChar is param 1
		call	printChar		! printChar(borderChar)
		nop

		dec	%l3			! col--

		cmp	%l3, 0			! check col > 0
		bg	bot_inner		! repeat inner loop if true
		nop

bot_newline:	mov	NEWLINE, %o0		! newline character is param 1
		call	printChar		! printChar('\n')
		nop

		dec	%l2			! row--	

		cmp	%l2, 0			! check row > 0
		bg	bot_outer		! repeat outer loop if true
		nop

post_bot:	ret
		restore
