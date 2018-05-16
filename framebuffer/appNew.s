.globl app
app:
	// X0 contiene la direccion base del framebuffer

	//---------------- CODE HERE ------------------------------------

	mov w10, 0x0000    // 0xF800 = RED
	mov x2,512         // Y Size
	loop1:
	mov w10, 0x0000
	mov x1,512         // X Size
	mov w3, 0x0000     // x3 R
	mov w4, 0x0000     // x4 G
	mov w5, 0x0000     // x5 B

loop0:
	add w10, w3, w4
	add w10, w10, w5    //Genero el color R + G + B
	sturh w10,[x0]	   // Set color of pixel N
	add x0,x0,2	   // Next pixel

	mov w7, 0xF8
	lsl w7, w7, 8			//w7 es el valor maximo de R

	sub w6,w3,w7	   //R - max R
	cbnz w6,subR	   // If not end row jump

	mov w7, 0x7E			//w7 es el valor maximo de G
	lsl w7, w7, 4

	sub w6,w4,w7	   // G - max G
	cbnz w6,subG	   // if not last row, jump

	mov w7, 0x1F		//w7 es el valor maximo de B

	sub w6,w5,w7	   // B - max B
	cbnz x2,subB	   // if not last row, jump

	b InfLoop

	subR:
	add x3, x3, 0x800

	sub x1,x1,1	   // decrement X counter
	cbnz x1,loop0	   // If not end row jump
	sub x2,x2,1	   // Decrement Y counter
	cbnz x2,loop1	   // if not last row, jump

	b InfLoop

	subG:
	add x4, x4, 0x20

	sub x1,x1,1	   // decrement X counter
	cbnz x1,loop0	   // If not end row jump
	sub x2,x2,1	   // Decrement Y counter
	cbnz x2,loop1	   // if not last row, jump

	b InfLoop

	subB:
	add x5, x5, 1
	
	sub x1,x1,1	   // decrement X counter
	cbnz x1,loop0	   // If not end row jump
	sub x2,x2,1	   // Decrement Y counter
	cbnz x2,loop1	   // if not last row, jump

	b InfLoop

	//---------------------------------------------------------------

        // Infinite Loop
InfLoop:
	b InfLoop
