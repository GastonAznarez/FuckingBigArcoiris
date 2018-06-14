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
    sub x7, x7, x6          //Le resto a la posicion de la barra la mitad de la altura
    lsr x8, x3, #9
    sub x8, x8, x6
    and x8, x8, 0x1FF



    mov x4, 0x0         //seteo el color de x4
    lsl x4, x4, #9
    orr x4, x4, x8          //Seteo el eje Y con la posicion menos la mitad de la altura
    lsl x4, x4, #9          //El eje X queda en 0
    orr x4, x4, x7

    puntoPelotab:             //Punto de partida de dibujar eje Y

    mov x8, #0              //Contador vertical

    pelotaVerticalb:
        subs xzr, x8, #14
        b.eq pelotaTeminadob          //Si el contador llego al limite, termina o aumenta el X
        bl print
        add x8, x8, #1              //Sumo uno al contador
        add x4, x4, BARRA_UNIDAD_Y  //Sumo 1 al eje Y

        b pelotaVerticalb             //Recurcion

pelotaTeminadob:

    add x13, x13, #1                  //Se termino de pintar una columna

    subs xzr, x13, #14
    b.eq pelotaListab                     //Branch de configuracion si se termino la primer barra, sinio aumentamos x


    mov x10, 0x1C00
    sub x4, x4, x10                 //Le resto los 50 lugares que me adelante en el Y de

    add x4, x4, #1                  //Le sumo 1 al eje X

    b puntoPelotab

    pelotaListab:
    br x29



MoverPelota:
    mov x21, x30
    bl BorrarPelota
    bl CheckPelota

    mov x9, x2

    and x8, x9, 0x2
    cbnz x8, horizontal
    mov x10, 1
    mov x11, 1
    and x8, x9, 0x1
    cbnz x8, diagoexterna
    add x10, x10, 1
    b saltoInterna
    diagoexterna:
    add x11, x11, 1
    saltoInterna:
    and x8, x9, 0x4
    lsl x11, x11, #9
    cbnz x8, arriba
    add x3, x3, x11
    b verdireccion
    arriba:
    sub x3,x3,x11
    b verdireccion
    horizontal:
    mov x10, 3
    verdireccion:
    and x8, x9, 0x8
    cbz x8, izquierda
    add x3, x3, x10
    b termine
    izquierda:
    sub x3, x3, x10
    termine:

    bl DibujarPelota

    br x21





CheckPelota:
    and x5, x3, 0x1FF
    lsr x4, x3, 9
    sub x4,x4, 7
    and x4, x4, 0x1FF
    cmp x4, 0x80
    b.le tocalado
    add x4, x4, 15
    cmp x4, 384
    b.ge tocalado
sigo:
    mov x6, PELOTA_MITAD + BARRA_ANCHO
    cmp x5, x6
    b.le tocaizquierda
    add x7, x6, x5
    cmp x7, EJE_MAX
    b.ge tocaderecha
    br x30

tocalado:
    mov x11, 0x4
    eor x2, x2, x11
    b sigo

tocaderecha:
    mov x13, BARRA_ALTO + PELOTA
    lsr x13, x13, 1
    add x12, x13, x26
    cmp x4, x12
    b.ge punto
    sub x12, x26, x13
    cmp x4, x12
    b.le punto

    mov x13, 21
    add x11, x26, x13
    cmp x4, x11
    b.le noabajo
    mov x2, 0x1
    br x30
noabajo:
    sub x11, x11, 10
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
    mov x13, BARRA_ALTO + PELOTA
    lsr x13, x13, 1
    add x12, x13, x27
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
  b app

punto2:
  b app

InicioPelota:
    mov x3, 0x201
    mov x2, 0x2
    lsl x6, x6, 8
    mov x2, x6                  //posicion al medio y direccion horizontal
    add x2, x2, x3              //le agrego el puntaje
    br x30



//-------FIN DE CODIGO----------//
