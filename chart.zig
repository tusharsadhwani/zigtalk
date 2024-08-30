const std = @import("std");
const sprintf = std.fmt.allocPrintZ;

const pl = @cImport(@cInclude("plplot.h"));

pub fn draw_bar(al: std.mem.Allocator, x: f64, y: f64) !void {
    const xbox: [4]f64 = .{ x, x, x + 1, x + 1 };
    const ybox: [4]f64 = .{ 0, y, y, 0 };
    pl.plfill(4, &xbox, &ybox);

    const value = try sprintf(al, "{d}", .{y});
    pl.plptex((x + 0.5), (y + 1.0), 1.0, 0.0, 0.5, value);

    pl.plcol1(0.5); // Black text

    const label = try sprintf(al, "{d}", .{x});
    pl.plmtex("b", 1.0, ((x - 1980.0 + 1) * 0.1 - 0.05), 0.5, label);
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer if (gpa.deinit() != .ok) {
        std.process.exit(1);
    };
    const al = gpa.allocator();

    pl.plsdev("png");
    pl.plsfnam("out.png");
    pl.plscolbg(255, 255, 255);
    pl.plinit();
    defer pl.plend();

    pl.pladv(0);
    pl.plvsta();
    pl.plwind(1980.0, 1990.0, 0.0, 35.0);
    pl.plcol1(0.5); // Black text
    pl.pllab("Year", "Widget Sales (millions)", 0);

    const data: [10]f64 = .{ 5, 15, 12, 24, 28, 30, 20, 8, 12, 3 };
    for (data, 0..10) |item, index| {
        pl.plcol1(@as(f64, @floatFromInt(index)) / 9.0); // 0 - 1 shifts from purple to black to red
        try draw_bar(al, 1980.0 + @as(f64, @floatFromInt(index)), item);
    }
}
