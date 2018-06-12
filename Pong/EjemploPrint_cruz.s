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

	x3 = Color blanco
	x4 = Punto para pintar con 'print'
		[0:8] = x
		[9:17] = y
		[18:33] = color

*/

//-------FIN REGISTROS----------------------//


//--------DEFINICION DE FUNCIONES-----------//
.globl app
.global print

//--------FIN DEFINICION DE FUNCIONES-------//

//--------------CODIGO----------------------//
app:
	mov x2,512         // Y Size
	mov x7,x0
	mov w6, 0xFFFF
	loop4:
	mov x1,512         // X Size
	loop5:
	sturh w6,[x7]	   // Set color of pixel N
	add x7,x7,2	   // Next pixel
	sub x1,x1,1	   // decrement X counter
	cbnz x1,loop5	   // If not end row jump
	sub x2,x2,1	   // Decrement Y counter
	cbnz x2,loop4	   // if not last row, jump

	//Hasta aca solo pinte todo de blanco

	mov x4, 0xF800
	lsl x4, x4, #1
	add x4, x4, #1
	lsl x4, x4, 17
	mov x8, #0
	//Dejo a x4 con color rojo, y = 254, x = 0
	loopn: //pinta todos los x, solo printea y suma 1 a la parte del x en x4 512 veces
	bl print
	subs xzr, x8, #511
	b.eq horizontal
	add x8, x8, #1
	add x4, x4, #1
	b loopn

horizontal:
	mov x4, 0x1F
	lsl x4, x4, #18
	add x4, x4, #254
	mov x8, #0
	//Dejo a x4 con color azul, y = 0, x = 254

	loopr: //pinta todos los y, solo printea y suma 1 a la parte del x en x4 512 veces
		bl print
		subs xzr, x8, #511
		b.eq InfLoop
		add x8, x8, #1
		add x4, x4, 0x200
		b loopr













//-----------FIN CODIGO----------------------------------------------------//



	print:
	and x10, x4, 0x1FF
	and x9, x4, 0x3FE00
	lsr x9, x9, #9
	mov x11, #512
	madd x9, x11, x9, x10
	lsr x10, x4, #18
	and x10, x10, 0xFFFF
	lsl x9, x9, #1
	add x9, x9, x0
	sturh w10, [x9]
	br x30
        // Infinite Loop
InfLoop:
	b InfLoop
