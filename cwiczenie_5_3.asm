//Cwiczenie 5.3    Kamil Gierlach	 Karol Piech		
.org 0x00
ldi R16, high(ramend)
out SPH, R16
ldi R16, low(ramend)
out SPL, R16

;set ports as out
ldi r17, 0xff ; 
out ddra, r17 ; 
out ddrb, r17 ; 
out ddrd, r17 ; 

rjmp prog_start

.org 0x32 
prime: .DB 0x7e, 0x30, 0x6d, 0x79, 0x33, 0x5b, 0x5f, 0x70, 0x7f, 0x7b, 0x77, 0x1f, 0x4e, 0x3d, 0x4f, 0x47	;list of 7SEG code for Hex numbers 
.org 0x100				;adres of program beginning

prog_start:
	ldi zl, low(2*prime)	;multiplication by two to get the address
	ldi zh, high(2*prime) 

	ldi r20, 0b11111111 ; Lower byte of first number
	ldi r21, 0b11111111 ; Higher byte of first number

	ldi r22, 0b00000001 ; Lower byte of second number
	ldi r23, 0b00000000 ; Higher byte of second number

	ldi r24, 0b00000001 ; 16-bit "one" used in
	ldi r25, 0b00000000 ; abs the result

	ldi r17, 0x00 ; Load immediate r16<=0x00
	out portd, r17 ; Diodes for overflow and signed
	
	rjmp start

start:
	sub r20, r22; subtract low byte
	sbc r21, r23; subtract with carry, high byte
	brvs over1; flag V set -> overflow

back1:
	brlt sign1; flag S set -> signed


over1:			; light first led
	ldi r17, 0xFF
	out portd, r17
	rjmp back1

sign1:			; light last led 
	ldi r17, 0x01
	out portd, r17
	com r20
	com r21
	add r20, r24
	adc r21, r25
	rjmp counter

counter:
	call display
	rjmp counter	

display:
	ldi r26, 5
	loop0:
		call seg1
		call wait
		call seg2
		call wait
		call seg3
		call wait
		call seg4
		call wait
		brne loop0
	ret


wait:	;time delay = 1/20s
	ldi R16, 2
		loop1:
		ldi R17, 50
			loop2: 
			ldi R18, 10
				loop3:
				dec R18
				brne loop3
				nop
				dec R17
			brne loop2
			nop
			dec R16
		brne loop1
		nop
	ret


seg1:
	ldi zl, low(2*prime) 
	ldi zh, high(2*prime)

	ldi r25,0x01 
	out portb, r25

	mov r23, r20 
	andi r23, 0x0f 
	ldi r27, 0x01 
	add r23, r27 

l2:
	lpm r24, z+ 
	dec r23
	brne l2
	out porta, r24		;show on display
	ret

seg2:
	ldi zl, low(2*prime);
	ldi zh, high(2*prime);
	ldi r25,~0x02
	out portb, r25
	mov r23, r20
	andi r23, 0xf0
	swap r23
	ldi r27, 0x01
	add r23, r27
l3:
	lpm r24, z+
	dec r23
	brne l3
	out porta, r24
	ret
seg3:
	ldi zl, low(2*prime);
	ldi zh, high(2*prime);
	ldi r25,~0x04
	out portb, r25
	mov r23, r21
	andi r23, 0x0f
	ldi r27, 0x01
	add r23, r27
l5:
	lpm r24, z+
	dec r23
	brne l5
	out porta, r24
	ret
seg4:
	ldi zl, low(2*prime);
	ldi zh, high(2*prime);
	ldi r25,~0x08
	out portb, r25	
	mov r23, r21
	andi r23, 0xf0
	swap r23
	ldi r27, 0x01
	add r23, r27
l7:
	lpm r24, z+
	dec r23
	brne l7
	out porta, r24
	ret