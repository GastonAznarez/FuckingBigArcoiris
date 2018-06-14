//--------DEFINICION DE FUNCIONES-----------//
    .global iniciarFondo
        //DESCRIPCION: Inicia el tablero.

    .global iniciarContador
        //DESCRIPCION: Inicia el contador a 0 0.

    .global sumarP1
        //DESCRIPCION: Aumenta un punto al contador del jugador 1.
        //USA: Estado pelota [27:31]

    .global sumarP2
        //DESCRIPCION: Aumenta un punto al contador del jugador 2.
        //USA: Estado pelota [27:31]

    .global PruebaRectangulo



//------FIN DEFINICION DE FUNCIONES-------//

iniciarFondo:   //Dibujo lineas perimetrales y central

    mov x29, x30                       //Guardo el registro de retorno, porque se sobreescribe x30

	mov x4, 0xFFFF
	lsl x4, x4, #2                     //Color en x4 blanco
    add x4, x4, #1
    lsl x4, x4, 16                     //Y = 128 en x4
	add x4, x4, #254                   //x = 256 en x4
	mov x8, #0                         //Contador x8 = 0

    loopVertical:
        subs xzr, x8, #256             //Condicion del loop
        b.eq verticalTeminado
    	bl print                       //Dibujo el pixel [X,Y]
    	add x8, x8, #1                 //Sumo 1 al contador
    	add x4, x4, 0x200              //Sumo 1 al eje Y
        bl print                       //Dibujo el siguiente pixel
        add x8, x8, #1                 //Sumo 1 al contador
    	add x4, x4, 0x200              //Sumo 1 al eje Y
        add x8, x8, #2                 //sUMO 2 AL CO
    	add x4, x4, 0x400

    	b loopVertical

verticalTeminado:

    mov x4, 0xFFFF
    lsl x4, x4, #2
    add x4, x4, #1
    lsl x4, x4, #16
    mov x8, #0
    mov x5, #1                          //Contdor de lineas

	loopHorizontal:
    	bl print
    	subs xzr, x8, #511
    	b.eq horizontalTerminado1
    	add x8, x8, #1
    	add x4, x4, #1
    	b loopHorizontal

horizontalTerminado1:

    cbz x5, horizontalTerminado         //Si x5 no es cero, falta la segunda linea

    sub x5, x5, #1
    mov x4, 0xFFFF
    lsl x4, x4, #9
    add x4, x4, 0x181
    lsl x4, x4, #9
    mov x8, #0

    b loopHorizontal

horizontalTerminado:
    br x29

//-------INICIO DE CODIGO-------//

PruebaRectangulo:

mov x28, x30
//1
mov x9, 30
lsl x9, x9, 9
mov x22, 140
orr x9, x9, x22
mov x10, 98
lsl x10, x10, 9
mov x21, 155
orr x10, x10, x21
bl DibujarRectangulo

//2
mov x23, 162

mov x9, 30
lsl x9, x9, 9
add x22,x23, 150
orr x9, x9, x22
mov x10, 45
lsl x10, x10, 9
add x21,x23, 200
orr x10, x10, x21
bl DibujarRectangulo



mov x9, 45
lsl x9, x9, 9
add x22,x23, 185
orr x9, x9, x22
mov x10, 56
lsl x10, x10, 9
add x21,x23, 200
orr x10, x10, x21
bl DibujarRectangulo

mov x9, 56
lsl x9, x9, 9
add x22,x23, 150
orr x9, x9, x22
mov x10, 71
lsl x10, x10, 9
add x21,x23, 200
orr x10, x10, x21
bl DibujarRectangulo

mov x9, 71
lsl x9, x9, 9
add x22,x23, 150
orr x9, x9, x22
mov x10, 83
lsl x10, x10, 9
add x21,x23, 165
orr x10, x10, x21
bl DibujarRectangulo

mov x9, 83
lsl x9, x9, 9
add x22,x23, 150
orr x9, x9, x22
mov x10, 98
lsl x10, x10, 9
add x21,x23, 200
orr x10, x10, x21
bl DibujarRectangulo
br x28




//-------FIN DE CODIGO----------//
