const std = @import("std");

test "compile time type information" {
    const data: Data = .{
        .count_donations = 12.34,
        .count_happy_people = 100,
        .count_balance = -1,
        .bike_flag = true,
    };
    try std.testing.expectEqual(comptime add_fields(data), 111);
}

const Data = struct {
    count_donations: f32,
    count_happy_people: u32,
    count_balance: i32,
    bike_flag: bool,
};

fn add_fields(data: Data) i32 {
    var accumulator: i32 = 0;
    inline for (std.meta.fields(Data)) |field| {
        if (std.mem.startsWith(u8, field.name, "count_")) {
            switch (field.type) {
                f32 => accumulator += @intFromFloat(@field(data, field.name)),
                u32 => accumulator += @intCast(@field(data, field.name)),
                i32 => accumulator += @field(data, field.name),
                else => unreachable,
            }
        }
    }
    return accumulator;
}

// Things to ponder:
// - What happens if you do reach an unreachable statement?
