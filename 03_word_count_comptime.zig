const std = @import("std");

fn read_bee_movie_script() usize {
    @setEvalBranchQuota(1000000);
    const text = @embedFile("./beemovie.txt");
    var token_iterator = std.mem.tokenizeSequence(u8, text, " ");

    var word_count: usize = 0;
    while (token_iterator.next()) |token| {
        if (token.len > 1)
            word_count += 1;
    }
    return word_count;
}

pub fn main() u8 {
    const word_count = comptime read_bee_movie_script();
    return @intCast(word_count % 256);
}
