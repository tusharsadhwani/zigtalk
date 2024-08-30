const std = @import("std");

pub fn main() void {
    var args = std.process.args();
    _ = args.next(); // program name, ignore

    const arg_name = args.next();
    const name = if (arg_name) |name| name else "world";
    std.debug.print("hello {s}\n", .{name});
}
