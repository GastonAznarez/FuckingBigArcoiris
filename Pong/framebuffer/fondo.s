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

variables:
    mov w11,0xFFFF //Blanco
    mov x6, 0
    mov x5, 0
    mov x7, 256
	mov w10,0x0     // azul
	mov x2,512         // Y Size
    add x6,x0,0
loop1:
	mov x1,512         // X Size
loop0:
	sturh w10,[x6]	   // Set color of pixel N
	add x6,x6,2	    // Next pixel
	sub x1,x1,1	    // decrement X counter
	cbnz x1,loop0   // If not end row jump
	sub x2,x2,1	    // Decrement Y counter
	cbnz x2,loop1  // if not last row, jump


    add x6,x0,512
    add x6,x6,131072

lineaMedio:
    sturh w11,[x6] //Pinta el pixel BLANCO
    add x6,x6,1024 // Next line
    sub x7,x7,1 //Counter
    sturh w11,[x6] //Pinta el pixel BLANCO
    add x6,x6,1024 // Next line
    sub x7,x7,1 //Counter
    sturh w10,[x6] //Pinta el pixel NEGRO
    add x6,x6,1024 // Next line
    sub x7,x7,1 //Counter
    sturh w10,[x6] //Pinta el pixel NEGRO
    add x6,x6,1024 // Next line
    sub x7,x7,1 //Counter
    cbnz x7,lineaMedio // loop


    sub x6,x6,512 //Al principio
    add x7,x7,511 //Counter
lineaLateralB:
    sturh w11,[x6] //Pinta el pixel
    add x6,x6,2 // Next pixel
    sub x7,x7,1 //Counter
    cbnz x7,lineaLateralB // loop

    add x7,x7,511 //Counter
    add x6,x0,131072
    //lsl x6,x6,4
lineaLateralA:
    sturh w11,[x6] //Pinta el pixel
    add x6,x6,2 // Next pixel
    sub x7,x7,1 //Counter
    cbnz x7,lineaLateralA // loop
    b InfLoop


/*
cero:
    mov x7,18 //Counter
    add x6,x0,0
    add x5,x6,0
    ceroVertical1:
    sturh w11,[x6] //Pinta el pixel
    add x6,x6,2 // Next pixel
    sturh w11,[x6] //Pinta el pixel
    add x6,x6,1022 // Next line
    sub x7,x7,1
    cbnz x7, ceroVertical1

    add x6,x6,1022 // Next line
    mov x7, #10 //Counter
    ceroHorizontal1:
    sturh w11,[x6] //Pinta el pixel
    add x6,x6,1024 // Next line
    sturh w11,[x6] //Pinta el pixel
    sub x6,x6,1022 //Siguiente pixel
    sub x7,x7,1
    cbnz x7, ceroHorizontal1

    add x6,x5,0
    mov x7, #10 //Counter
    ceroHorizontal2:
    sturh w11,[x6] //Pinta el pixel
    add x6,x6,1024 // Next line
    sturh w11,[x6] //Pinta el pixel
    sub x6,x6,1022 //Siguiente pixel
    sub x7,x7,1
    cbnz x7, ceroHorizontal2

    mov x7,18 //Counter
    sub x6,x6,4 //Siguiente pixel
    ceroVertical2:
    sturh w11,[x6] //Pinta el pixel
    add x6,x6,2 // Next pixel
    sturh w11,[x6] //Pinta el pixel
    add x6,x6,1022 // Next line
    sub x7,x7,1
    cbnz x7, ceroVertical2
    b InfLoop



    add x7,x7,20 //Counter
    add x6,x0,30
uno:
    sturh w11,[x6] //Pinta el pixel
    add x6,x6,2 // Next pixel
    sturh w11,[x6] //Pinta el pixel
    add x6,x6,1022 // Next line
    sub x7,x7,1
    cbnz x7, uno
    b InfLoop


dos:
    mov x7,10 //Counter
    add x6,x0,60
    add x5,x6,0
    dosHorizontal1:
    sturh w11,[x6] //Pinta el pixel
    add x6,x6,1024 // Next line
    sturh w11,[x6] //Pinta el pixel
    sub x6,x6,1022 //Siguiente pixel
    sub x7,x7,1
    cbnz x7, dosHorizontal1

    mov x7,9 //Counter
    sub x6,x6,4 //Anterior pixel
    dosVertical1:
    sturh w11,[x6] //Pinta el pixel
    add x6,x6,2 // Next pixel
    sturh w11,[x6] //Pinta el pixel
    add x6,x6,1022 // Next line
    sub x7,x7,1
    cbnz x7, dosVertical1

    mov x7,10 //Counter
    sub x6,x6,20 //Anterior pixel
    dosHorizontal2:
    sturh w11,[x6] //Pinta el pixel
    add x6,x6,1024 // Next line
    sturh w11,[x6] //Pinta el pixel
    sub x6,x6,1022 //Siguiente pixel
    sub x7,x7,1
    cbnz x7, dosHorizontal2

    mov x7,9 //Counter
    sub x6,x6,20 //Anterior pixel
    dosVertical2:
    sturh w11,[x6] //Pinta el pixel
    add x6,x6,2 // Next pixel
    sturh w11,[x6] //Pinta el pixel
    add x6,x6,1022 // Next line
    sub x7,x7,1
    cbnz x7, dosVertical2

    mov x7, #10 //Counter
    sub x6,x6,4 //Anterior pixel
    dosHorizontal3:
    sturh w11,[x6] //Pinta el pixel
    add x6,x6,1024 // Next line
    sturh w11,[x6] //Pinta el pixel
    sub x6,x6,1022 //Siguiente pixel
    sub x7,x7,1
    cbnz x7, dosHorizontal3


tres:
    mov x7,10 //Counter
    add x6,x0,90
    add x5,x6,0
    tresHorizontal1:
    sturh w11,[x6] //Pinta el pixel
    add x6,x6,1024 // Next line
    sturh w11,[x6] //Pinta el pixel
    sub x6,x6,1022 //Siguiente pixel
    sub x7,x7,1
    cbnz x7, tresHorizontal1

    mov x7,9 //Counter
    sub x6,x6,4 //Anterior pixel
    tresVertical1:
    sturh w11,[x6] //Pinta el pixel
    add x6,x6,2 // Next pixel
    sturh w11,[x6] //Pinta el pixel
    add x6,x6,1022 // Next line
    sub x7,x7,1
    cbnz x7, tresVertical1

    mov x7,10 //Counter
    sub x6,x6,20 //Anterior pixel
    tresHorizontal2:
    sturh w11,[x6] //Pinta el pixel
    add x6,x6,1024 // Next line
    sturh w11,[x6] //Pinta el pixel
    sub x6,x6,1022 //Siguiente pixel
    sub x7,x7,1
    cbnz x7, tresHorizontal2

    mov x7,9 //Counter
    sub x6,x6,4 //Anterior pixel
    tresVertical2:
    sturh w11,[x6] //Pinta el pixel
    add x6,x6,2 // Next pixel
    sturh w11,[x6] //Pinta el pixel
    add x6,x6,1022 // Next line
    sub x7,x7,1
    cbnz x7, tresVertical2

    mov x7,10 //Counter
    sub x6,x6,20 //Anterior pixel
    tresHorizontal3:
    sturh w11,[x6] //Pinta el pixel
    add x6,x6,1024 // Next line
    sturh w11,[x6] //Pinta el pixel
    sub x6,x6,1022 //Siguiente pixel
    sub x7,x7,1
    cbnz x7, tresHorizontal3
*/


//-------FIN DE CODIGO----------//
