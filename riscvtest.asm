consts:
	addi	x1, x0, 1  # TxRDY
	addi	x2,	x0,	2  # RxRDY
	addi	x3,	x0, 3  # RxParityErr
	addi	x5, x0, 0  # counter
    addi	x8, x0, 0x500  #UART reg
    addi	x9, x0, 0x504  #status reg

polling:
	lw	 	x4,	0(x9)	# r4 = (status reg)
	andi	x4, x4, 0x3 
	beq		x4, x1, TxRDY
	beq		x4, x2, RxRDY
    beq		x0, x0, polling

TxRDY:
    bne		x5, x0, TxRDY2
	addi	x6, x0, 76		# x6 = L
	sw	 	x6, 0(x8) # store ascii into uart reg
	addi	x5, x5, 1	# inc counter
	beq		x0, x0, polling
	# if 1 
	#repeat stuff above

    
TxRDY2:
	bne		x5, x1, TxRDY3
	addi	x6, x0, 65		# x6 = T
	sw	 	x6, 0(x8) # store ascii into uart reg
	addi	x5, x5, 1	# inc counter
	beq		x0, x0, polling
    
TxRDY3:
	addi	x6, x0, 55		# x6 = 7
	sw	 	x6, 0(x8) # store ascii into uart reg
	addi	x5, x5, 1	# inc counter
	beq		x0, x0, polling

RxRDY:
	lw		x7, 0(x8)
	beq		x0, x0, polling