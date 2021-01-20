// æwiczenie 2.2 Kamil Gierlach Karol Piech
ldi r16, $ff; 
out PORTa, r16; writing ones to port a to set input 
ldi r16, $ff; 
out DDRa, r16; writing ones to ddra to set output direction
ldi r16, $00;
out PORTa, r16;

//Reading the value of port B
ldi r16, $ff; load immediate r16 <= 0xff
out PORTb, r16; writing ones to port b 
ldi r16, $00;
out DDRb, r16; writing zeros to ddrb to set input direction
in r16,PINb; reading pinb value into r16 

start:
	sbis pinb, 0; test bit 0 in pinb - check buttons status
	sbi porta, 0; set bit 0 to porta - lights led 
	sbic pinb, 0; test bit 0 in pinb
	cbi porta, 0; clear bit 0 in porta 
stop: rjmp start