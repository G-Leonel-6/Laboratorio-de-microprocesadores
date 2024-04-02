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
	
	ldi r17, 0xFF
	out DDRD, r17

; Arranca mi loop principal que se ejecutará eternamente	
main_loop:
	;ldi16 cont, r17, 1024 	; uso de la macro

	sbi PORTD, 0
	call Delay
	cbi PORTD, 0
	call Delay
    rjmp main_loop

Delay:	ldi r23, 70
loop3:  ldi r22, 255
loop2:	ldi r21, 255
loop1:	dec r21
		brne loop1
		dec r22
		brne loop2
		dec r23
		brne loop3
		ret


; Definicion de tabla en memoria de codigo
tabla: .db	"Esto es una tabla constante", 0x00