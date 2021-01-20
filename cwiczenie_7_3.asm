//Cwiczenie 7.3    Kamil Gierlach	 Karol Piech		
.include"m32def.inc"
.cseg
.org 0
jmp start
.org INT2addr
jmp keypad_ISR ;Keyoad External Interrupt Request 2
.def button_code=r20

; Main program start
start:
; Set Stack Pointer to top of RAM
.org 0x100

ldi r16, high(ramend) ;load sph
out sph, r16
ldi r16, low(ramend) ;load spl
out spl, r16


;Set up port A as output for LED controls
ldi r16 ,0b11111111 ; 
out ddra , r16 ; 


; Clear intf2 flag
ldi r16, (1<<intf2)
out gifr, r16

; Enable Int2
ldi r16, (1<<int2) 
out gicr, r16
; Set Int2 active on falling edge
ldi r16, (1<<isc10)
out mcucsr, r16
;Set rows as inputs and columns as outputs
ldi r16, 0x0F ; 
out ddrd, r16
;Set rows to high (pull ups) and columns to low to activate JP13
ldi r16, 0xF0 ; LUB NA ODWROT
out ddrd, r16
;Global Enable Interrupt
sei
;Set up infinite loop
loop:
;read button code from r20 and send to port A
mov r16,r20
out porta,r16
rjmp loop


;Keypad Interrupt Service Routine
keypad_ISR:
;Disable interrupts
cli
;Store registers that are to be used in ISR on stack
push r16;
push r17;

;Set rows as outputs and columns as inputs on Port D
ldi r16, 0xF0
out ddrd, r16
;Set rows to low and columns to high (pull up) on Port D
ldi r16, 0x0F
out ddrd, r16
;Read Port D. Column code in lower nibble

nop 
nop
in r16, pind
;Store column code to r20 on lower nibble
mov r20, r16
;Set rows as inputs and columns as outputs on Port D
ldi r16, 0xF0
out ddrd, r16
;Set rows to high (pull up) and columns to low on Port D
ldi r16, 0x0F
out ddrd, r16
;Read Port D. Row code in higher nibble

nop 
nop
in r16,pind
;Store row code to r20 on higher nibble
swap r20
swap r16
add r20, r16
swap r20	
;Set rows as inputs and columns as outputs
ldi r16, 0x0F
out ddrd, r16
;Set rows to high and columns to low to activate JP13
ldi r16, 0xF0
out ddrd, r16
;Clear intf2 flag
ldi r16,(1<<intf2)
out gifr, r16
;Restore registers from stack (in opposite order)
pop r17 ;
pop r16 ;
;Enable interrupts globally
sei ;
reti;