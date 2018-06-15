//--------DEFINICION DE FUNCIONES-----------//

.global DibujarPelota
    //DESCRIPCION: Pinta de blanco los pixeles al rededor del punto de la pelota.
    //USA: Posicion Pelota x2[0:17], tamaño de la pelota.

.global BorrarPelota
    //DESCRIPCION: Pinta de negro los pixeles al rededor del punto de la pelota.
    //USA: Posicion Pelota x2[0:17], tamaño de la pelota.

.global CambiarDireccionPelota
    //DESCRIPCION: Calcula la proxima direccion.
    //USA: Posicion de Pelota x2[0:17] - Direccion Pelota x2[18:22].
    //MODIFICA:  Direccion Pelota x2[18:22].

.global MoverPelota
    //DESCRIPCION: Calcula la siguiente posicion, Borra la pelota de la anterior y la dibuja en la siguiente.
    //USA: Posicion de Pelota x2[0:17] - Direccion Pelota x2[18:22].
    //MODIFICA: Posicion de Pelota x2[0:17].

.global CheckPelota
    //DESCRIPCION: Comprueba si la pelota esta tocando algo.
    //USA: Posicion Pelota x2[0:17].
    //MODIFICA: Estado Pelota x2[27:31] - Posicion Barra 1 x1[0:8] - Posicion Barra 2 x1[0:15], tamaño pelota, tamaño barra.

.global InicioPelota
    //DESCRIPCION: Dibuja la pelota en el medio, le da direccion horizontal a la derecha y setea los registros necesarios.
    //USA: nada.
    //MODIFICA: Posicion de Pelota x2[0:17] - Direccion Pelota x2[18:22] - Estado Pelota x2[27:31] - Puntaje x2[23:26].

.global PuntoPelota
    //DESCRIPCION: Se efija si se suma un punto, lo suma dependiendo a quien y ve si gano alguien. Si alguien gano hace lo correspondiente.
    //USA: Estado Pelota x2[27:31].
    //MODIFICA: Puntaje x2[23:26].

//------FIN DEFINICION DE FUNCIONES-------//

//-------INICIO DE CODIGO-------//

DibujarPelota:
    mov x29, x30            //Guardo la direccion de retorno porque se sobreescribe x30 en print
    mov x13, #1
    and x7, x3, 0x1FF
    mov x6, #14
    lsr x6, x6, #1
    sub x7, x7, x6          //Le resto a la posicion de la barra la mitad de la altura
    lsr x8, x3, #9
    sub x8, x8, x6
    and x8, x8, 0x1FF

    mov x4, BLANCO          //seteo el color de x4
	  lsl x4, x4, #9
    orr x4, x4, x8          //Seteo el eje Y con la posicion menos la mitad de la altura
    lsl x4, x4, #9          //El eje X queda en 0
    orr x4, x4, x7

  puntoPelota:             //Punto de partida de dibujar eje Y
	  mov x8, #0              //Contador vertical

  pelotaVertical:
        subs xzr, x8, #14
        b.eq pelotaTeminado          //Si el contador llego al limite, termina o aumenta el X
    	bl print
    	add x8, x8, #1              //Sumo uno al contador
    	add x4, x4, BARRA_UNIDAD_Y  //Sumo 1 al eje Y

    	b pelotaVertical             //Recurcion

pelotaTeminado:

    add x13, x13, #1                  //Se termino de pintar una columna

    subs xzr, x13, #14
    b.eq pelotaLista                     //Branch de configuracion si se termino la primer barra, sinio aumentamos x


    mov x10, 0x1C00
    sub x4, x4, x10                 //Le resto los 50 lugares que me adelante en el Y de

    add x4, x4, #1                  //Le sumo 1 al eje X

    b puntoPelota

    pelotaLista:
    br x29





BorrarPelota:
    mov x29, x30            //Guardo la direccion de retorno porque se sobreescribe x30 en print
    mov x13, #1

    and x7, x3, 0x1FF
    mov x6, #14
    lsr x6, x6, #1
    sub x7, x7, x6          //Le resto a la posicion de la pelota la mitad de la altura
    lsr x8, x3, #9
    sub x8, x8, x6
    and x8, x8, 0x1FF



    mov x4, 0x0             //seteo el color de x4
    lsl x4, x4, #9
    orr x4, x4, x8          //Seteo el eje Y con la posicion menos la mitad de la altura
    lsl x4, x4, #9
    orr x4, x4, x7          //Seteo el eje x con la posicion menos la mitad

    puntoPelotab:           //Punto de partida de dibujar eje Y

    mov x8, #0              //Contador vertical

    pelotaVerticalb:
        subs xzr, x8, #14           //veo si termino la columna
        b.eq pelotaTeminadob        //Si el contador llego al limite, termina o aumenta el X
        bl print
        add x8, x8, #1              //Sumo uno al contador
        add x4, x4, BARRA_UNIDAD_Y  //Sumo 1 al eje Y

        b pelotaVerticalb             //Recursion

pelotaTeminadob:

    add x13, x13, #1                 //Se termino de pintar una columna

    subs xzr, x13, #14               //veo si termino la pelota
    b.eq pelotaListab                //Branch de configuracion si se termino la pelota, sinio aumentamos x


    mov x10, 0x1C00
    sub x4, x4, x10                 //Le resto los  lugares que me adelante en el Y de

    add x4, x4, #1                  //Le sumo 1 al eje X

    b puntoPelotab

    pelotaListab:
    br x29



MoverPelota:
    mov x21, x30
    bl BorrarPelota
    bl CheckPelota

    mov x9, x2                    //guardo la direccion actual

    and x8, x9, 0x2               //veo horizontal - diagonal (ver grafico pelota )
    cbnz x8, horizontal
    mov x10, 1                    //si es diagonal debo modificar almenos en 1 las x y las y
    mov x11, 1
    and x8, x9, 0x1
    cbnz x8, diagoexterna
    add x10, x10, 1               //si es diago interna debo modificar uno mas las x
    b saltoInterna
    diagoexterna:
    add x11, x11, 1               //si era externa debo modificar uno mas las y
    saltoInterna:
    and x8, x9, 0x4
    lsl x11, x11, #9
    cbnz x8, arriba
    add x3, x3, x11               //si va para abajo, debo sumar las y
    b verdireccion
    arriba:
    sub x3,x3,x11                 //sino resto las y
    b verdireccion
    horizontal:
    mov x10, 3                    //si era horizontal me debo mover 3 en las x
    verdireccion:
    and x8, x9, 0x8
    cbz x8, izquierda
    add x3, x3, x10               //si es a la derecha debo sumar las x
    b termine
    izquierda:
    sub x3, x3, x10               //sino las resto
    termine:

    bl DibujarPelota

    br x21



CheckPelota:
    and x5, x3, 0x1FF
    lsr x4, x3, 9
    sub x4,x4, 7                        //le resto la mitad de la pelota asi toma el borde y no el centro
    and x4, x4, 0x1FF
    cmp x4, 0x7E                        //comparo con el borde superior
    b.le tocalado
    add x4, x4, 15                      //ahora le sumo el tamaño de la pelota asi toma el otro borde
    cmp x4, 400                         //comparo con el borde inferior
    b.ge tocalado                       //hago el sigo por si suceden las dos cosas al mismo tiempo
sigo:
    mov x6, PELOTA_MITAD + BARRA_ANCHO
    cmp x5, x6                          //comparo con el borde de la barra izquierda
    b.le tocaizquierda
    add x7, x6, x5
    cmp x7, EJE_MAX                     //sumo y comparo con el eje maximo de la derecha
    b.ge tocaderecha
    br x30

tocalado:
    mov x11, 0x4
    eor x2, x2, x11                     //si toca algun lado entonces invierto la direccion arr-abajo
    b sigo

tocaderecha:
    mov x13, BARRA_ALTO + PELOTA
    lsr x13, x13, 1
    add x12, x13, x26
    add x12, x12, 2
    cmp x4, x12                         //comparo el borde con el borde de la barra a ver si toca o si es punto
    b.ge punto
    sub x12, x26, x13
    cmp x4, x12                         //igual pero con el otro borde
    b.le punto

    mov x13, 21                         //dividi la barra en secciones (ver grafico barra)
    add x11, x26, x13
    cmp x4, x11                         //comparo con la primer seccion
    b.le noabajo
    mov x2, 0x1                         //cambio a la direccion correcta si es de esta seccion
    br x30
noabajo:
    sub x11, x11, 10                    //idem siguientes
    cmp x4, x11
    b.le nodiagoabajo
    mov x2, 0x0
    br x30
nodiagoabajo:
    sub x11, x11, 15
    cmp x4, x11
    b.le nomedio
    mov x2, 0x2
    br x30
nomedio:
    sub x11, x11, 10
    cmp x4, x11
    b.le nodiagoarriba
    mov x2, 0x4
    br x30
nodiagoarriba:
    mov x2, 0x5
    br x30






tocaizquierda:
    mov x13, BARRA_ALTO + PELOTA          //idem barra derecha
    lsr x13, x13, 1
    add x12, x13, x27
    add x12, x12, 2
    cmp x4, x12
    b.ge punto2
    sub x12, x27, x13
    cmp x4, x12
    b.le punto2

    mov x13, 21
    add x11, x27, x13
    cmp x4, x11
    b.le noabajoi
    mov x2, 0x9
    br x30
noabajoi:
    sub x11, x11, 10
    cmp x4, x11
    b.le nodiagoabajoi
    mov x2, 0x8
    br x30
nodiagoabajoi:
    sub x11, x11, 15
    cmp x4, x11
    b.le nomedioi
    mov x2, 0xa
    br x30
nomedioi:
    sub x11, x11, 10
    cmp x4, x11
    b.le nodiagoarribai
    mov x2, 0xc
    br x30
nodiagoarribai:
    mov x2, 0xd
    br x30

punto:

    add x24, x24, #1

    b comprobarPuntaje

punto2:

    add x24, x24, #4
    b comprobarPuntaje

InicioPelota:
    mov x3, 0x201
    mov x2, 0x2                  //posicion al medio y direccion horizontal
    lsl x6, x6, 8
    mov x2, x6
    add x2, x2, x3
    br x30



//-------FIN DE CODIGO----------//
