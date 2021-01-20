//Cwiczenie 4.4    Kamil Gierlach   Karol Piech
.include "m32def.inc"
.org 0x00				
rjmp start			
.org 0x32																			;adress off data list beginning
digits: .DB ~0x7E, ~0x30, ~0x6D, ~0x79, ~0x33, ~0x5B, ~0x5F, ~0x70, ~0x7F, ~0x7B	;list of 7SEG code for numbers 0 to 9
.org 0x100																			;adres of program beginning
																			 
start:
	call main

main:
	ldi r16, 0xff	
	out ddrb, r16																	;set port as output
	out ddrc, r16																	;set port as output
	
	ldi xl, 0		
	ldi xh, 0		

loop:	
	call show																		;call show on display function
	;call delay_function															;call delay function

	ldi r21, 1				
	ldi r22, 0				
	add xl, r21																		;increment
	adc xh, r22																		;increment
rjmp loop		


show:																				;show on display function
	;First display
	ldi r16, 0x01																	; Select display
	com r16																			;negation creating an active zero
	out portc, r16																    ;activation first display with port C
	mov r21, xh		
	swap r21																		;swap byte halves
	andi r21, 0x0f	
	call number_to_7seg																;call conversion function
	com r21																			;negation creating an active zero
	out portb, r21  

	;Second display
	ldi r16, 0x02	
	com r16			
	out portc, r16  
	mov r21, xh		
	andi r21, 0x0f	
	call number_to_7seg
	com r21			
	out portb, r21  

	;Third display
	ldi r16, 0x04	
	com r16			
	out portc, r16  
	mov r21, xl		
	swap r21		
	andi r21, 0x0f	
	call number_to_7seg
	com r21			
	out portb, r21  

	;Fourth display
	ldi r16, 0x08	
	com r16			
	out portc, r16  
	mov r21, xl		
	andi r21, 0x0f	
	call number_to_7seg
	com r21			
	out portb, r21  

	ret
 
number_to_7seg:																		;conversion function
	ldi zl, low(2*digits)															;multiplication by two to get the address
	ldi zh, high(2*digits)	
	ldi r22, 0			
	add zl, r21				
	adc zh, r22				
	lpm r21, z																		;loading number
	ret

delay_function:																		;function definition
	push r18;
	push r19;
	push r20;
	ldi r20,0x64;	
first_loop:																			;loop number one ->three loops to make delay 1/5[s]
	ldi r19,0x14;	
second_loop:																		;loop number two
	ldi r18,0x64 ;
third_loop:																			;loop number three
	dec r18; 
	brne third_loop;
	dec r19;
	brne second_loop;
	dec r20; 
	brne first_loop;
	pop r20;
	pop r19;
	pop r18;
	ret;																			;return from function

	pop r25
	pop r24
	pop r23
	pop r16
	ret