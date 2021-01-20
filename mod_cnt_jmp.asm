// æwiczenie 2.4 Kamil Gierlach Karol Piech
.EQU write =0xff;
	ldi r16 ,0b00000101; number 5 -> first 
	ldi r17 ,0b00001111; number 14 -> last

start:
loop:
	ldi r21,write;
	out ddrc,r21;
	out portc,r16	
	ldi r20,0x64;		

first_loop:				;loop number one ->three loops to make delay
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

	inc r16;		
	cp r17,r16;			 ;end condition
	brne loop;
	ldi r16 ,0b00000101; ;counting reset
	rjmp step;			 ;jump to step
	
Step:
	rjmp start			 ;main jump to start