.globl app
app:
	// X0 contiene la direccion base del framebuffer

	//---------------- CODE HERE ------------------------------------

	mov x2,512         // Y Size

	loop1:

	mov x1,512         // X Size

	mov w10, 0x0000    // w10 es blanco
	mov w3, 0x0000     // x3 R
	mov w4, 0x0000     // x4 G
	mov w5, 0x0000     // x5 B

  loop0:

	  bl subirRojo

		bl subirVerde

		bl bajarRojo

		bl subirAzul

		bl bajarVerde

		bl subirRojo

		bl bajarAzul

		bl bajarRojo

		lsl x1, x1, 1
		add x0,x0,x1	   // Next pixel

		sub x2, x2, 1

		cbnz x2, loop1

		b InfLoop


//-------------------ROJO--------------------//

  subirRojo: //Termina cuando el color se termina o el X = 0

    add w10, w3, w4
  	add w10, w10, w5    //Genero el color R + G + B

    sturh w10,[x0]
		add x0,x0,2
		sturh w10,[x0]
			   // Set color of pixel N
    add x0,x0,2	   // Next pixel

    sub x1,x1,2	   // decrement X counter
    cbz x1,alTreinta	   // If not end row jump

    mov w7, 0xF8
    lsl w7, w7, 8			//w7 es el valor maximo de R
    sub w6,w3,w7	   //R - max R
    cbz w6, alTreinta	   // Si R es su maximo

    add x3, x3, 0x800

    b subirRojo

  bajarRojo:

    add w10, w3, w4
    add w10, w10, w5    //Genero el color R + G + B

    sturh w10,[x0]
		add x0,x0,2
		sturh w10,[x0]
			   // Set color of pixel N
    add x0,x0,2	   // Next pixel

    sub x1,x1,2	   // decrement X counter
    cbz x1,alTreinta	   // If not end row jump

    sub w3, w3, 0x800

    cbz w3, alTreinta	   // Si R es su minimo

    b bajarRojo

//-----------END ROJO----------------------------//

//-------------AZUL------------------------------//

	subirAzul: //Termina cuando el color se termina o el X = 0

    add w10, w3, w4
  	add w10, w10, w5    //Genero el color R + G + B

    sturh w10,[x0]
		add x0,x0,2
		sturh w10,[x0]
			   // Set color of pixel N
    add x0,x0,2	   // Next pixel

    sub x1,x1,2	   // decrement X counter
    cbz x1,alTreinta	   // If not end row jump

    mov w7, 0x1F		//w7 es el valor maximo de B
    sub w6,w5,w7	   //B - max B
    cbz w6, alTreinta	   // Si B es su maximo

    add w5, w5, 1

    b subirAzul

  bajarAzul:

    add w10, w3, w4
    add w10, w10, w5    //Genero el color R + G + B

    sturh w10,[x0]
		add x0,x0,2
		sturh w10,[x0]
			   // Set color of pixel N
    add x0,x0,2	   // Next pixel

    sub x1,x1,2	   // decrement X counter
    cbz x1,alTreinta	   // If not end row jump

    sub w5, w5, 1

    cbz w5, alTreinta	   // Si B es su minimo

    b bajarAzul

//-----------END AZUL-----------------------//

//------------VERDE--------------------------//

	subirVerde: //Termina cuando el color se termina o el X = 0

    add w10, w3, w4
  	add w10, w10, w5    //Genero el color R + G + B

    sturh w10,[x0]
		add x0,x0,2
		sturh w10,[x0]
			   // Set color of pixel N
    add x0,x0,2	   // Next pixel

    sub x1,x1,2	   // decrement X counter
    cbz x1,alTreinta	   // If not end row jump

    mov w7, 0x7C0			//w7 es el valor maximo de G
    sub w6,w4,w7	   //G - max G
    cbz w6, alTreinta	   // Si G es su maximo

    add w4, w4, 0x40

    b subirVerde

  bajarVerde:

    add w10, w3, w4
    add w10, w10, w5    //Genero el color R + G + B

    sturh w10,[x0]
		add x0,x0,2
		sturh w10,[x0]
			   // Set color of pixel N
    add x0,x0,2	   // Next pixel

    sub x1,x1,2	   // decrement X counter
    cbz x1,alTreinta	   // If not end row jump

    sub w4, w4, 0x40

    cbz w4, alTreinta	   // Si G es su minimo

    b bajarVerde

//-----------------END VERDE--------------//


	//---------------------------------------------------------------

        // Infinite Loop
InfLoop:
	b InfLoop

alTreinta:
  br x30
