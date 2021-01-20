// æwiczenie 2.1 Karol Piech Kamil Gierlach
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
	in r16, PINb;
	out PORTa, r16; send value from port b to port a 
stop: rjmp start 