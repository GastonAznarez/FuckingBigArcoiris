//--------DEFINICION DE FUNCIONES-----------//
    .global iniciarBarras
        //DESCRIPCION: Setea la posicion de las barras en el medio y llama a mostrarBarras
        //USA x1
        //MODIFICA: x8

    .global mostrarBarras
        //DESCRIPCION: Pinta de Blanco los pixeles alrededor de la posicion de las barras.
        //USA: posicion Barra 1 [0:8] Barra 2 [9:15]
        //MODIFICA: x4, x8, x29, x7

    .global borrarBarras
        //DESCRIPCION: Pinta de Negro los pixeles alrededor de la posicion de las barras.
        //USA: posicion Barra 1 [0:8] Barra 2 [9:15]

    .global SiguientePosicionBarra
        //DESCRIPCION: Calcula la posicion de las barras para el siguiente loop.
        //USA: posicion Barra 1 [0:8] Barra 2 [9:15]

    .global MoverBarra
        //DESCRIPCION: Borra la Barra, la dibuja en la posicion actual, y calcula la proxima.
        //USA: posicion Barra 1 [0:8] Barra 2 [9:15]
        //MODIFICA: posicion Barra 1 [0:8] Barra 2 [9:15]


//------FIN DEFINICION DE FUNCIONES-------//

iniciarBarras:

    mov x27, 0x100
    mov x26, 0x100              //Les doy a las barras la posicion inicial del medio

    b mostrarBarras

borrarBarras:
    movk x1, NEGRO, lsl #48     //Si las quiero borrar les pongo colr negro
    b dibujarBarra
mostrarBarras:
    movk x1, BLANCO, lsl #48    //Si las quiero mostrar les pongo color blanco

dibujarBarra:

    mov x29, x30            //Guardo la direccion de retorno porque se sobreescribe x30 en print
    mov x13, #1

    mov x7, x27
    and x7, x7, BARRA_X     //x7 barra 1
    mov x6, BARRA_ALTO
    lsr x6, x6, #1
    sub x7, x7, x6          //Le resto a la posicion de la barra la mitad de la altura

    lsr x15, x1, #48
    and x15, x15, 0xFFFF
    mov x4, x15             //seteo el color de x4
	lsl x4, x4, #9
    orr x4, x4, x7          //Seteo el eje Y con la posicion menos la mitad de la altura
    lsl x4, x4, #9          //El eje X queda en 0

    puntoBarra:             //Punto de partida de dibujar eje Y

	mov x8, #0              //Contador vertical

    barraVertical:
        subs xzr, x8, BARRA_ALTO
        b.eq barraTeminado          //Si el contador llego al limite, termina o aumenta el X
    	bl print
    	add x8, x8, #1              //Sumo uno al contador
    	add x4, x4, BARRA_UNIDAD_Y  //Sumo 1 al eje Y

    	b barraVertical             //Recurcion

barraTeminado:

    add x13, x13, #1                  //Se termino de pintar una columna

    subs xzr, x13, BARRA_ANCHO
    b.eq barra2                     //Branch de configuracion si se termino la primer barra, sinio aumentamos x

    mov x11, BARRA_ANCHO
    lsl x11, x11, #1
    subs xzr, x13, x11
    b.eq listaBarra                 //Si se termino de dibujar la segunda barra

    mov x10, BARRA_ALTO * BARRA_UNIDAD_Y
    sub x4, x4, x10                 //Le resto los 50 lugares que me adelante en el Y de

    add x4, x4, #1                  //Le sumo 1 al eje X

    b puntoBarra

barra2:

    mov x7, x26
    and x7, x7, BARRA_X
    sub x7, x7, x6                   //x7 + Primer punto del Y para pintar la barra

    lsr x15, x1, #48
    and x15, x15, 0xFFFF

    mov x4, x15          //seteo el color de x4
    lsl x4, x4, #9
    orr x4, x4, x7
    lsl x4, x4, #9
    mov x10, EJE_MAX
    sub x10, x10, BARRA_ANCHO
    orr x4, x4, x10                  //x4 Con color Blanco, Y = primer punto para pintar y X = El limite de la pantalla menos el ancho de la barra

    b puntoBarra


listaBarra:

    br x29


SiguientePosicionBarra:

    mov x29, x30                    //Guardo la posicion de retorno

    //mov x5, xzr                     //Dejo a x5 como cero

    mov x6, x27
    and x6, x6, 0x1FF               //Guardo en x6 la posicion de la primer barra
    mov x8, BARRA_ALTO
    lsr x8, x8, #1                  //Guardo en x8 la mitad de la altura de la barra

	and x7, x1, BTN_1		        //Obtengo solo el bit del BTN_1
	cbz x7, restarPrimeraBarra		//Si el bit no es cero (boton pulsado) salto

    add x7, x6, x8                  //Guardo en x7 el punto maximo de l abarra
    subs xzr, x7, FIN_TABLERO_ABAJO
    b.eq restarPrimeraBarra         //Si esta en su ultima posicion no le puedo sumar


    add x27, x27, #1                //Si se apreto el boton y la barra no esta en un limite, sumo 1
    //mov x5, 0x3


    restarPrimeraBarra:

    and x7, x1, BTN_2
	cbz x7, sumarSegundaBarra

    sub x7, x6, x8
    subs xzr, x7, FIN_TABLERO_ARRIBA
    b.eq sumarSegundaBarra

    sub x27, x27, #1

    //eor x5, x5, 0x1

    sumarSegundaBarra:

    //-------lo mismo que con la primera barra----------//

    and x6, x26, 0x1FF
    mov x8, BARRA_ALTO
    lsr x8, x8, #1


	and x7, x1, BTN_3
	cbz x7, restarSegundaBarra

    add x7, x6, x8
    subs xzr, x7, FIN_TABLERO_ABAJO
    b.eq restarSegundaBarra

    add x26, x26, #1
    //eor x5, x5, 0x18

    restarSegundaBarra:

    and x7, x1, BTN_4
	cbz x7, SiguientePosicionBarraTerminado

    sub x7, x6, x8
    subs xzr, x7, FIN_TABLERO_ARRIBA
    b.eq SiguientePosicionBarraTerminado

    sub x26, x26, #1
    //eor x5, x5, 0x8

    SiguientePosicionBarraTerminado:


    done:

    br x29


//-------INICIO DE CODIGO-------//

//-------FIN DE CODIGO----------//
