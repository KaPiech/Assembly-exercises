//Cwiczenie 5.2     Karol Piech		Kamil Gierlach

ldi r16, 70		;first number	
ldi r21, 96		;second number
add r16, r21	;add

ldi r17, -70
ldi r22, -96 
add r17, r22

ldi r18, -126  
ldi r23, 30
add r18, r23

ldi r19, 126 
ldi r24, -6
add r19, r24

ldi r20, -2 
ldi r25, -5
add r20, r25


;Checked:											Wyniki:	
;Argumenty		C		V		N		S			binary				signed				unsigned		
;{+70, +96}		0		1		1		0			0b10100110			-90					166
;{-70, -96}		1		1		0		1			0b01011010			 90					90
;{-126, 30}		0		0		1		1			0b10100000			-96					160
;{126, -6}		1		0		0		0			0b01111000			 --					120
;{-2, -5}		1		0		1		1			0b11111001			-7					249