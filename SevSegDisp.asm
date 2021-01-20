// �wiczenie 4.3 Karol Piech Kamil Gierlach
.DSEG;						;start data memory
.ORG 0x600;
delay: .BYTE 1;				;memory reservation for delay

.CSEG						;start program memory
.EQU write =0xff;
ldi r16 ,0b00000000;		;number 0 -> first
ldi r17 ,0x47;				;number F -> last


start:
.org 0x32										;adress off data list beginning
prime: .DB 0x7E, 0x30, 0x6D, 0x79, 0x33, 0x5B, 0x5F, 0x70, 0x7F, 0x7B, 0x77, 0x1F, 0x4E, 0x3D, 0x4F, 0x47	;list of 7SEG code for Hex numbers 
.org 0x100										;adres of program beginning
prog_start: ldi r30, low(2*prime)				;multiplication by two to get the address
ldi r31, high(2*prime)							


loop:
	lpm r16,Z+;				 ;downloading data from memory
	ldi r21, write
	out ddra ,r21
	out ddrb ,r21
	out porta, r16
	ldi r18, 0x01
	com r18					 ;negation creating an active zero
	out portb, r18			 ;activation first display with port B

	call delay_function;	;call function
	cp r17,r16;				;end condition
	brne loop;
	rjmp start;				;jump to start


delay_function:				;function definition
	push r18;
	push r19;
	push r20;
	ldi r20,0x64;
first_loop:					;loop number one ->three loops to make delay
	ldi r19,0x64;
second_loop:				;loop number two
	ldi r18,0x64;
third_loop:;				;loop number three
	dec r18; 
	brne third_loop;
	dec r19;
	brne second_loop;
	dec r20; 
	brne first_loop;
	pop r20;
	pop r19;
	pop r18;
	sts delay,r31
	ret;					;return from function