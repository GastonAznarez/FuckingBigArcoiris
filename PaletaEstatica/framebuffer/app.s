//----------------------- 16/5/18 -----------------------//
// Integrantes: 																				 //
//							Aznarez Gaston													 //
//							Guerra Lucas														 //
//							Lauret Ignacio													 //
//							Legnini Papalardo Gino									 //
//-------------------------------------------------------//


// *Se establecio en 0 el bit menos significativo del verde (G,w4) para acomodarlo a los otros colores y se perdio la mitad de la gama del mismo.
// *Para reducir la velocidad del cambio de color, se establecio que los bits (n,y) y (n+1,y) para 'n' par e 'y' fijo tienen el mismo color.

.globl app
app:
	// X0 contiene la direccion base del framebuffer o bit 0 (0,0)

	mov x2,512         // Y Size

	//------------- LOOP Y-----------------------------------------//

	loop1: //Este loop se repite para llenar los Y

	mov x1,512         // X Size

	mov w10, 0x0000    // w10 = blanco -> suma de Niveles R, G y B
	mov w3, 0x0000     // x3 = R -> Nivel del color rojo
	mov w4, 0x0000     // x4 = G -> Nivel del color verde
	mov w5, 0x0000     // x5 = B -> Nivel del color Azul

	//-Secuencia de cambio de colores-//

	  bl subirRojo

		bl subirVerde

		bl bajarRojo

		bl subirAzul

		bl bajarVerde

		bl subirRojo

		bl bajarAzul

		bl bajarRojo

		lsl x1, x1, 1 					//Multiplico la cantidad de X que quedan por dos [Sacar]
		add x0,x0,x1	 				  //Cambio el pixel seleccionado por X*X mas [Sacar]

		sub x2, x2, 1 					//Le resto uno a los Y

		cbnz x2, loop1 					//Si me quedan Ys (x2 != 0) vuelvo al loop

//--------END LOOP Y----------------------------------------------//

		b InfLoop  							//Se mostro todo, loop infinito para no reiniciar


//-------------------ROJO--------------------//

  subirRojo: 	//Termina cuando el color se termina o el X = 0

    add w10, w3, w4
  	add w10, w10, w5   	  //Genero el color R + G + B

    sturh w10,[x0]			  //Pinto el primer bit
		add x0,x0,2 					//Selecciono otro bit
		sturh w10,[x0]				//Pinto el segundo bit
    add x0,x0,2	  				//Selecciono otro bit

    sub x1,x1,2	   				// decrement X counter
    cbz x1,alTreinta	    //Si es el ultimo X, terminar funcion (vuelve a la siguiente linea de la que empezo)

    mov w7, 0xF8
    lsl w7, w7, 8					//w7 es el valor maximo de R
    sub w6,w3,w7	  			//R - max R
    cbz w6, alTreinta	    // Si R es su maximo

    add x3, x3, 0x800 		//Sumo una unidad al color sin alterar los bits del resto de colores ni al bit menos significativo del verde

    b subirRojo  //Llamada recirsiva, todavia no termino el color

  bajarRojo:

    add w10, w3, w4
    add w10, w10, w5   	 //Genero el color R + G + B

    sturh w10,[x0] 			 //Pinto el primer bit
		add x0,x0,2					 //Selecciono otro bit
		sturh w10,[x0] 			 //Pinto el segundo bit
    add x0,x0,2	  			 // Selecciono otro bit

    sub x1,x1,2	  			 // decrement X counter
    cbz x1,alTreinta	   //Si es el ultimo X, terminar funcion (vuelve a la siguiente linea de la que empezo)

    sub w3, w3, 0x800 	 //Resto una unidad al color sin alterar los bits del resto de colores ni al bit menos significativo del verde

    cbz w3, alTreinta	   // Si R es su minimo termina la funcion (vuelve a la siguiente linea de la que empezo)

    b bajarRojo  //Llamada recirsiva, todavia no termino el color

//-----------END ROJO----------------------------//

//-------------AZUL------------------------------//

	subirAzul: //Termina cuando el color se termina o el X = 0

    add w10, w3, w4
  	add w10, w10, w5    	//Genero el color R + G + B

    sturh w10,[x0] 				//Pinto el primer bit
		add x0,x0,2 					//Selecciono otro bit
		sturh w10,[x0] 				//Pinto el segundo bit
    add x0,x0,2	   				//Selecciono otro bit

    sub x1,x1,2	  				//Decrement X counter
    cbz x1,alTreinta	    //Si es el ultimo X, terminar funcion (vuelve a la siguiente linea de la que empezo)

    mov w7, 0x1F					//w7 es el valor maximo de B
    sub w6,w5,w7	 			  //B - max B
    cbz w6, alTreinta 	  //Si B es su maximo

    add w5, w5, 1 				//Sumo una unidad al color sin alterar los bits del resto de colores ni al bit menos significativo del verde

    b subirAzul  //Llamada recirsiva, todavia no termino el color

  bajarAzul:

    add w10, w3, w4
    add w10, w10, w5   		//Genero el color R + G + B

    sturh w10,[x0]				//Pinto el primer bit
		add x0,x0,2 					//Selecciono otro bit
		sturh w10,[x0] 				//Pinto el segundo bit
    add x0,x0,2	   				//Selecciono otro bit

    sub x1,x1,2	  				//Decrement X counter
    cbz x1,alTreinta	    //Si es el ultimo X, terminar funcion (vuelve a la siguiente linea de la que empezo)

    sub w5, w5, 1  				//Resto una unidad al color sin alterar los bits del resto de colores ni al bit menos significativo del verde

    cbz w5, alTreinta	    // Si B es su minimo termina la funcion (vuelve a la siguiente linea de la que empezo)

    b bajarAzul  //Llamada recirsiva, todavia no termino el color

//-----------END AZUL-----------------------//

//------------VERDE--------------------------//

	subirVerde: //Termina cuando el color se termina o el X = 0

    add w10, w3, w4
  	add w10, w10, w5    	//Genero el color R + G + B

    sturh w10,[x0] 				//Pinto el primer bit
		add x0,x0,2 					//Selecciono otro bit
		sturh w10,[x0]				//Pinto el segundo bit
    add x0,x0,2	   				// Selecciono otro bit

    sub x1,x1,2	   				// decrement X counter
    cbz x1,alTreinta	    //Si es el ultimo X, terminar funcion (vuelve a la siguiente linea de la que empezo)

    mov w7, 0x7C0					//w7 es el valor maximo de G
    sub w6,w4,w7	   			//G - max G
    cbz w6, alTreinta	    // Si G es su maximo

    add w4, w4, 0x40			//Sumo una unidad al color sin alterar los bits del resto de colores ni al bit menos significativo del verde

    b subirVerde  //Llamada recirsiva, todavia no termino el color

  bajarVerde:

    add w10, w3, w4
    add w10, w10, w5    	//Genero el color R + G + B

    sturh w10,[x0] 				//Pinto el primer bit
		add x0,x0,2 					//Selecciono otro bit
		sturh w10,[x0] 				//Pinto el segundo bit
    add x0,x0,2	   				// Selecciono otro bit

    sub x1,x1,2	   				// decrement X counter
    cbz x1,alTreinta	    //Si es el ultimo X, terminar funcion (vuelve a la siguiente linea de la que empezo)

    sub w4, w4, 0x40 			//Reto una unidad al color sin alterar los bits del resto de colores ni al bit menos significativo del verde

    cbz w4, alTreinta	    // Si G es su minimo termina la funcion (vuelve a la siguiente linea de la que empezo)

    b bajarVerde //Llamada recirsiva, todavia no termino el color

//-----------------END VERDE--------------//


InfLoop:				 //Loop infinito
	b InfLoop

alTreinta: 			//Salta a la linea del bl, se uso para hacer saltos condicionales con un registro en vez de un label
  br x30
