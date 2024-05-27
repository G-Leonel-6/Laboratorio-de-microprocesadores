; cascara.asm
;
; Creado: 29/04/2021 08:00:00 p.m.
; Autor : Gabriel
;

.include "m328pdef.inc"

 
; Constantes del programa

; Alias de los registros

.dseg
; Segmento de datos en memoria de datos
.org SRAM_START
; Definicion de variable 
; Nombre .byte Tamanio_en_bytes

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

	ldi r16, 0x02
	out DDRB, r16
	ldi r16, 0
	out PORTB, r16

	ldi r16, 0x40		; configuro registro de control A
	sts TCCR1A, r16

	ldi r16, 0x0a		; configuro clock con prescaling 64
	sts TCCR1B, r16

	ldi r16, 249
	sts OCR1AL, r16		; valor de comparacion A
	ldi r16, 0
	sts OCR1AH, r16


fin:
    rjmp fin

