;
; cascara.asm
;
; Creado: 29/04/2021 08:00:00 p.m.
; Autor : Gabriel
;

.include "m328pdef.inc"

 
; Constantes del programa
.equ	LOWER = 5  ; Numero constante

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
.org OC0Aaddr
	rjmp timer0_interrupcion

.org INT_VECTORS_SIZE
main:

	; Se inicializa el Stack Pointer al final de la RAM utilizando la definicion global
	; RAMEND
	ldi		r16,HIGH(RAMEND)
	out		sph,r16
	ldi		r16,LOW(RAMEND)
	out		spl,r16

	ldi r16, 0x04		;configuro pc2 como salida
	out DDRC, r16
	clr r16
	out PORTC, r16		; valor inicial de la salida como 0

	ldi r16, 0x02		; configuro registro de control A
	out TCCR0A, r16

	ldi r16, 0x03		; configuro clock con prescaling 64
	out TCCR0B, r16

	ldi r16, 124
	out OCR0A, r16		; valor de comparacion A

	ldi r16,0x02
	sts TIMSK0,r16		; habilito interrupcion por comparacion A

	sei 
fin:
    rjmp fin

timer0_interrupcion:
	sbi PINC, 2
	reti
