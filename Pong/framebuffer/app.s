//----------------------- 31/5/18 -----------------------//
// Integrantes: 										 //
//				Aznarez Gaston							 //
//				Guerra Lucas							 //
//				Lauret Ignacio							 //
//				Legnini Papalardo Gino					 //
//-------------------------------------------------------//

//----------CONSTANTES-----------//
	//TODO: Ver cuantos pixeles van a ocupar cada cosa
	//TODO: Ver el tamaño de la pelota.

//--------FIN CONSTANTES---------//

//----------REGISTROS------------//

/*
	x0 = Direccion base del framebuffer.

	x1 = Posicion de barras: //TODO: los valores maximos y minimos que puede tomar.
		Barra 1 [0:8]
		Barra 2 [9:15]
		GPIO  (1 ON, 0 OFF)
			btn 1 [16]
			btn 2 [17]
			btn 3 [18]
			btn 4 [19]

	x2 = Pelota
		Posicion [0:17] //TODO: Valores maximos y minimos que puede tomar.
			[0:8] eje X, [9:15] eje Y.
		Direccion [18:22]
			[18] Izquierda 0 Derecha 1,
			[19] Horizontal 1 Diagonal 0,
			[20] Arriba 1 Abajo 0,
			[21] 1 Diagonal externa, 0 Diagonal interna (interna: mas cerca de la orizontal).
		Puntaje [23:26]
			[23:24] Puntaje p1,
			[25:26] Puntaje p2.
		Estado pelota [27:31] //TODO: Valos en los que toca la pelta dependiendo de la posicion de las barras y el centro de la pelota.
			[27:31] -> numero n.
				n = 0 -> no toca nada,
				n = 1:5 Posicion barra 1 de arriba para abajo,
				n = 6:10 Posicion barra 2 de arriba a abajo,
				n = 11 limite superior,
				n = 12 limite inferior,
				n = 13 arco p1,
				n = 14 arco p2.

*/

//-------FIN REGISTROS----------------------//


//--------DEFINICION DE FUNCIONES-----------//
.globl app

//--------FIN DEFINICION DE FUNCIONES-------//

//--------------CODIGO----------------------//
app:
	// X0 contiene la direccion base del framebuffer

	//---------------- CODE HERE ------------------------------------//

	mov w10, 0xF800    // 0xF800 = RED
	mov x2,512         // Y Size
	loop1:
	mov x1,512         // X Size
loop0:
	sturh w10,[x0]	   // Set color of pixel N
	add x0,x0,2	   // Next pixel
	sub x1,x1,1	   // decrement X counter
	cbnz x1,loop0	   // If not end row jump
	sub x2,x2,1	   // Decrement Y counter
	cbnz x2,loop1	   // if not last row, jump

//-----------FIN CODIGO----------------------------------------------------//

        // Infinite Loop
InfLoop:
	b InfLoop
