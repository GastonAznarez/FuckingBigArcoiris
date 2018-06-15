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


    .global lineaVertical

    .global borrarNumeros

//------FIN DEFINICION DE FUNCIONES-------//

lineaVertical:
    mov x29, x30

    b vertical

iniciarFondo:   //Dibujo lineas perimetrales y central

    mov x29, x30                       //Guardo el registro de retorno, porque se sobreescribe x30

    mov x4, 0xFFFF
    lsl x4, x4, #9
    add x4, x4, #121
    //lsl x4, x4, #2
    //add x4, x4, #1
    lsl x4, x4, #9
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
    add x4, x4, 0x190
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
    subs xzr, x8, #272             //Condicion del loop
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

borrarNumeros:

    mov x28, x30
    mov x19, 0x0

    mov x23, #0

    mov x9, 30
    lsl x9, x9, 9
    mov x22, 140
    orr x9, x9, x22
    mov x10, 98
    lsl x10, x10, 9
    mov x21, 450
    orr x10, x10, x21
    bl DibujarRectangulo
    br x28




dibujarCero:
    mov x28, x30

    mov x19, BLANCO
    cbnz x5, playerUnoCero


    mov x23, #165 // Si se le suma a player 2

    b dibujandoCero

    playerUnoCero:

    mov x23, #0  // Si se le suma a player 1

    dibujandoCero:     //Lado superior

    mov x9, 30          // Y del punto inicial
    lsl x9, x9, 9       // Corremos 9 Lugares
    add x22,x23, 150    // X del punto inicial
    orr x9, x9, x22     // Fucionamos X,Y punto inicial
    mov x10, 45         // Y punto final
    lsl x10, x10, 9     // Corremos 9 lugares
    add x21,x23, 200    // X del punto final
    orr x10, x10, x21   // Fusionamos X,Y punto final
    bl DibujarRectangulo // Volvemos

    //Se repite para cada lado del numero

    mov x9, 45         //Lado izquierdo
    lsl x9, x9, 9
    add x22,x23, 150
    orr x9, x9, x22
    mov x10, 83
    lsl x10, x10, 9
    add x21,x23, 165
    orr x10, x10, x21
    bl DibujarRectangulo


    mov x9, 45         //lado derecho
    lsl x9, x9, 9
    add x22,x23, 185
    orr x9, x9, x22
    mov x10, 83
    lsl x10, x10, 9
    add x21,x23, 200
    orr x10, x10, x21
    bl DibujarRectangulo


    mov x9, 83         //Abajo
    lsl x9, x9, 9
    add x22,x23, 150
    orr x9, x9, x22
    mov x10, 98
    lsl x10, x10, 9
    add x21,x23, 200
    orr x10, x10, x21
    bl DibujarRectangulo
    br x28


dibujarUno:
    mov x19, BLANCO
    mov x28, x30

    cbnz x5, playerUnoUno

    mov x23, #165  // Si se le suma a player 2

    b dibujandoUno

    playerUnoUno:

    mov x23, #0    // Si se le suma a player 1

    dibujandoUno:

    mov x9, 30         //Unica barra del 1
    lsl x9, x9, 9
    add x22,x23, 150
    orr x9, x9, x22
    mov x10, 98
    lsl x10, x10, 9
    add x21,x23, 165
    orr x10, x10, x21
    bl DibujarRectangulo


    br x28


dibujarDos:
    mov x19, BLANCO
    mov x28, x30


    cbnz x5, playerUnoDos

    mov x23, #165   // Si se le suma a player 2

    b dibujandoDos

    playerUnoDos:

    mov x23, #0     // Si se le suma a player 1

    dibujandoDos:

    mov x9, 30 //Lado superior
    lsl x9, x9, 9
    add x22,x23, 150
    orr x9, x9, x22
    mov x10, 45
    lsl x10, x10, 9
    add x21,x23, 200
    orr x10, x10, x21
    bl DibujarRectangulo



    mov x9, 45  //lado derecho
    lsl x9, x9, 9
    add x22,x23, 185
    orr x9, x9, x22
    mov x10, 56
    lsl x10, x10, 9
    add x21,x23, 200
    orr x10, x10, x21
    bl DibujarRectangulo

    mov x9, 56  //Lado medio
    lsl x9, x9, 9
    add x22,x23, 150
    orr x9, x9, x22
    mov x10, 71
    lsl x10, x10, 9
    add x21,x23, 200
    orr x10, x10, x21
    bl DibujarRectangulo

    mov x9, 71   // Lado izquierdo
    lsl x9, x9, 9
    add x22,x23, 150
    orr x9, x9, x22
    mov x10, 83
    lsl x10, x10, 9
    add x21,x23, 165
    orr x10, x10, x21
    bl DibujarRectangulo

    mov x9, 83  // Lado inferior
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
