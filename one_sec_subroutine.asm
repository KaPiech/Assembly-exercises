// æwiczenie 3.1 Karol Piech Kamil Gierlach
.EQU write =0xff;
	ldi r16 ,0b00000000; number 0 -> first
	ldi r17 ,0b00001110; number 14 -> last

start:

loop:
	ldi r21,write;
	out ddrb,r21;
	out portb,r16	

	call delay_function;	;call function

	inc r16;		
	cp r17,r16;			 ;end condition
	brne loop;
	ldi r16 ,0b0010011100001111; ;counting reset
	rjmp start;			 ;jump to start


delay_function:				;function definition
	push r18;
	push r19;
	push r20;
	ldi r20,0x64;	
first_loop:				;loop number one ->three loops to make delay 1/5[s]
	ldi r19,0x64;
second_loop:			;loop number two
	ldi r18,0x64 ;
third_loop:				;loop number three
	dec r18; 
	brne third_loop;
	dec r19;
	brne second_loop;
	dec r20; 
	brne first_loop;
	pop r20;
	pop r19;
	pop r18;
	ret;				;return from function
