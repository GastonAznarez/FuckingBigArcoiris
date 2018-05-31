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
    //Code

BorrarPelota:
    //Code

CambiarDireccionPelota:
    //Code

MoverPelota:
    //Code

CheckPelota:
    //Code

InicioPelota:
    //Code

PuntoPelota:
    //Code

//-------FIN DE CODIGO----------//
