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


    .global lineaVertical

//------FIN DEFINICION DE FUNCIONES-------//

lineaVertical:
    mov x29, x30

    b vertical

iniciarFondo:   //Dibujo lineas perimetrales y central

    mov x29, x30                       //Guardo el registro de retorno, porque se sobreescribe x30

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

    vertical:

    mov x4, 0xFFFF
    lsl x4, x4, #2                     //Color en x4 blanco
    add x4, x4, #1
    lsl x4, x4, 16                     //Y = 128 en x4
    add x4, x4, #254                   //x = 256 en x4
    mov x8, #0                         //Contador x8 = 0

    loopVertical:
    subs xzr, x8, #256             //Condicion del loop
    b.eq fondoListo
    bl print                       //Dibujo el pixel [X,Y]
    add x8, x8, #1                 //Sumo 1 al contador
    add x4, x4, 0x200              //Sumo 1 al eje Y
    bl print                       //Dibujo el siguiente pixel
    add x8, x8, #1                 //Sumo 1 al contador
    add x4, x4, 0x200              //Sumo 1 al eje Y
    add x8, x8, #2                 //sUMO 2 AL CO
    add x4, x4, 0x400

    b loopVertical

    fondoListo:

        br x29

//-------INICIO DE CODIGO-------//

//-------FIN DE CODIGO----------//
