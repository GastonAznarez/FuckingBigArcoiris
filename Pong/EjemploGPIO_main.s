/*********************************************************************************************
*	main.s
*	by Delfina Vélez
*
*	Ejemplo de uso de assembly de ARM sobre una Raspberry Pi
*	El programa permite leer una entrada digital de 5V en el GPIO17 (P1-pin 11)
*	y encender la salida digital GPIO24 (P1-pin 18) mientras dicha entrada está activa
**********************************************************************************************/

// Inicio (mantener para todos los programas)

/*
* .section is a directive to our assembler telling it to place this code first.
* .globl is a directive to our assembler, that tells it to export this symbol
* to the elf file. Convention dictates that the symbol _start is used for the 
* entry point, so this all has the net effect of setting the entry point here.
* Ultimately, this is useless as the elf itself is not used in the final 
* result, and so the entry point really doesn't matter, but it aids clarity,
* allows simulators to run the elf, and also stops us getting a linker warning
* about having no entry point. 
*/
.section .init
.globl _start
_start:


// Cargar en r0 la dirección base de los registros GPIO (0x20200000):

ldr r0,=0x20200000


// Configurar el GPIO24 como salida

/*
* 001 = para configurar Pin GPIO como output
*
* El GPIO 24 está en el registro: GPIO Function Select 2
* en los bits 14-12 (página 93 de la hoja de datos)
*/


// Colocar 1 en el bit 12 de r1

mov r1,#1
lsl r1,#12   


// Colocar 001 en los bits 14-12 del registro GPFSEL2 (base + 8)

str r1,[r0,#8]     //MODIFICADO (Terceros 4 bytes/ de 20 a 29) SALIDA EN GPIO24


// Configurar el GPIO17 como entrada

/*
* 000 = para configurar Pin GPIO como input
*
* El GPIO 17 está en el registro: GPIO Function Select 1
* en los bits 23-21 (página 92 de la hoja de datos)
*/


// Colocar 0 en r1

mov r1,#0


// Colocar 000 en los bits 23-21 del registro GPFSEL1 (base + 4)

str r1,[r0,#4]  


// Colocar 1 en el bit 24 de r1  

mov r1,#1
lsl r1,#24   //MODIFICADO (PIN 24)


// Comienzo del lazo que se ejecuta hasta el infinito:

loop$:

	// Leer el registro GPIO Pin Level 0 y guardarlo en r2

	ldr r2,[r0,#52]

	// Limpiar el bit 17 (estado del GPIO17)

	and r2,r2,#0X20000

	// Mover el valor obtenido a la posición 1

	lsr r2,#17

	// Comparar el valor obtenido. Si no es igual a 1, saltar a OFF$

	teq r2,#1
	bne OFF$


	// Colocar 1 en el bit 24 del registro GPIO Pin Output Set 0 para encender el GPIO24

	str r1,[r0,#28]   

b loop$
	
	OFF$:

		// Colocar 1 en el bit 24 del registro GPIO Pin Output Clear 0
		//para apagar el GPIO24

		str r1,[r0,#40]  

b loop$
