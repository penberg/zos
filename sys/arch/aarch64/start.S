	.global start
start:
	b start_kernel
halt:	wfi
	b halt
