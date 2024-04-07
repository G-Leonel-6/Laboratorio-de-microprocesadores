;
; cascara.asm
;
; Creado: 29/04/2021 08:00:00 p.m.
; Autor : Gabriel
;

.include "m328pdef.inc"

 
; Constantes del programa
.equ	CONSTANTE = 1 ; Numero constante

; Alias de los registros
.def	cont = r16

; Definicion de una macro de nombre ldi16
; Macro que carga un valor de dos bytes en dos registros
; LOW y HIGH son sentencias para el pre-ensamblador
.macro ldi16
	ldi		@0, LOW(@2)			;@0 primer argumento de la llamada
	ldi		@1, HIGH(@2)		;@1 segundo argumento de la llamada
.endmacro						;@2 tercer argumento de la llamada

.dseg
; Segmento de datos en memoria de datos
.org SRAM_START
; Definicion de variable 
; Nombre .byte Tamanio_en_bytes
var1:	.byte	1

.cseg
.org 0x0000
; Segmento de datos en memoria de codigo
	rjmp	main

.org INT_VECTORS_SIZE
main:

	; Se inicializa el Stack Pointer al final de la RAM utilizando la definicion global
	; RAMEND
	ldi		r16,HIGH(RAMEND)
	out		sph,r16
	ldi		r16,LOW(RAMEND)
	out		spl,r16

	clr r16
	out DDRD, r16
	ldi r16, 0x40
	out PORTD, r16

	ser r16
	out DDRB, r16
	ldi r16, 0x00
	out PORTB, r16
	
	
; Arranca mi loop principal que se ejecutará eternamente	

main_loop:

ES_UNO_ON:
	sbic PIND, 7
	rjmp ES_UNO_ON
ES_CERO_ON:
	ldi r17, 0x0c
	out PORTB, r17
ES_UNO_OFF:
	sbic PIND, 6
	rjmp ES_UNO_OFF
ES_CERO_OFF:
	ldi r17, 0x00
	out PORTB, r17

	rjmp main_loop


; Definicion de tabla en memoria de codigo
tabla: .db	"Esto es una tabla constante", 0x00