// æwiczenie 3.2 Karol Piech Kamil Gierlach
.DSEG;						;start data memory
.ORG 0x600;
delay: .BYTE 1;				;memory reservation

.CSEG						;start program memory
.EQU write =0xff;
ldi r16 ,0b00000000;		;number 0 -> first
ldi r17 ,0b00111111;		;number 14 -> last

start:
loop:
	ldi r21,write;
	out ddrb,r21;
	out portb,r16;
	lds r20,delay;
	lds r19,delay;
	lds r18,delay;

	call delay_function;	;call function

	inc r16;		
	cp r17,r16;				;end condition
	brne loop;
	ldi r16 ,0b00000000;	;counting reset 
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