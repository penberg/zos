	.global start
start:
	bl start_kernel
halt:	wfi
	b halt
