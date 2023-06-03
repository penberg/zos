const Writer = @import("std").io.Writer;
const fmt = @import("std").fmt;

var UART0DR = @intToPtr([*]volatile u16, 0x09000000);
var UART0FR = @intToPtr([*]volatile u16, 0x09000018);

pub const writer = Writer(void, error{}, callback){ .context = {} };

fn callback(_: void, string: []const u8) error{}!usize {
    puts(string);
    return string.len;
}

pub fn printf(comptime format: []const u8, args: anytype) void {
    fmt.format(writer, format, args) catch unreachable;
}

pub fn puts(data: []const u8) void {
    for (data) |c|
        putChar(c);
}

pub fn putChar(ch: u8) void {
    while ((UART0FR[0]) & (1 << 5) != 0) {}
    UART0DR[0] = ch;
}
