// æwiczenie 4.1 Karol Piech Kamil Gierlach


;Kod z instrukcji
.include"m32def.inc"
.org 0x00 ;dyrektywa org nie jest konieczna
rjmp prog_start ;skok do programu g³ównego
.org 0x32 ;adres pocz¹tku listy danych dyrektywy DB
prime: .DB 2, 3, 5, 7, 11, 13, 17, 19, 23	;stworzenie listy dziewiêciu liczb pierwszych
;w przestrzeni pamiêci programu
.org 0x100 ;adres pocz¹tku programu
prog_start: ldi r30, low(2*prime) ;mno¿enie przez dwa, celem uzyskania adresu
ldi r31, high(2*prime) ;w przestrzeni bajtowej


;sprawdzone adresy pamiêci s¹ zgodne z tabel¹:  "prog 0x0064  02 03 05 07 0b 0d 11 13 17 00"

;odczytane wartoœci z adresów 0x200-0x203:		"prog 0x0200  e4 e6 f0 e0" 