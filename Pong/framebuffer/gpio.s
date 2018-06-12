//--------DEFINICION DE FUNCIONES-----------//
    .global inputRead
        //DESCRIPCION: Cambia a 1 el estado del boton 1.
        //USA: Queseio como andan los GPIO.
        //Modifica: btn 1 [16]

//------FIN DEFINICION DE FUNCIONES-------//

inputRead: //x1 16-19   GPIO 5,6,12,13
    mov w8, PERIPHERAL_BASE + GPIO_BASE     //Direccion de los GPIO.
	ldr w9, [x8, GPIO_GPLEV0]               //Obtengo los datos del GPIO 4

    and x1, x1, x6                  //Seteo los valores leidos anteriormente a 0

    and w10, w9, GPIO_5                     //w10 queda con 1 o 0 en el bit del GPIO_5 0x20
    lsl x10, x10, #14                       //Muevo ese bit a la posicion del BTN_1 0x40000
    orr x1, x1, x10                         //Dejo el bit de estado en la posicion BTN_1 del x1

    and w10, w9, GPIO_6
    lsl x10, x10, #14
    orr x1, x1, x10

    and w10, w9, GPIO_12
    lsl x10, x10, #9
    orr x1, x1, x10

    and w10, w9, GPIO_13
    lsl x10, x10, #9
    orr x1, x1, x10


    br x30                                  //Vuelvo a la instruccion link



//-------INICIO DE CODIGO-------//

//-------FIN DE CODIGO----------//
