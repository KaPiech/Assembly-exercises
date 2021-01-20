// æwiczenie 4.2 Karol Piech Kamil Gierlach
.DSEG;						;start data memory
.ORG 0x600;
delay: .BYTE 1;				;memory reservation for delay

.CSEG						;start program memory
.EQU write =0xff;
ldi r16 ,0b00000010;		;number 2 -> first
ldi r17 ,0b00011101;		;number 29 -> last


start:
.org 0x32										;adress off data list beginning
prime: .DB 2, 3, 5, 7, 11, 13, 17, 19, 23, 29	;list of 10 primes numbers
.org 0x100										;adres of program beginning
prog_start: ldi r30, low(2*prime)				;multiplication by two to get the address
ldi r31, high(2*prime)							


loop:
	lpm r16,Z+;									;downloading data from memory
	ldi r21,write;
	out ddra ,r21;
	out porta, r16;

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