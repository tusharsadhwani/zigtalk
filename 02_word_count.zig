const std = @import("std");

pub fn read_file(al: std.mem.Allocator, filepath: []const u8) ![]u8 {
    const file = try std.fs.cwd().openFile(filepath, .{});
    defer file.close();
    const contents = try file.readToEndAlloc(al, std.math.maxInt(usize));
    return contents;
}

fn read_bee_movie_script() !usize {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer if (gpa.deinit() != .ok) {
        std.process.exit(1);
    };
    const al = gpa.allocator();

    const text = try read_file(al, "./beemovie.txt");
    defer al.free(text);

    var token_iterator = std.mem.tokenizeSequence(u8, text, " ");
    var word_count: usize = 0;
    while (token_iterator.next()) |token| {
        if (token.len > 1)
            word_count += 1;
    }
    return word_count;
}

pub fn main() !void {
    const word_count = try read_bee_movie_script();
    std.debug.print("{}\n", .{word_count});
}

// Things to ponder / tinker with:
// Why is the type `!void`? What's the `try` keyword?
// How does the tokenizer work? Does it allocate memory?
