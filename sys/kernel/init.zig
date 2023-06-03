const uart = @import("uart");

export fn start_kernel() void {
    uart.printf("hello, world!\n", .{});
}
