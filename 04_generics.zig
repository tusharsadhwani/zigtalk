const std = @import("std");

fn LinkedList(comptime T: type) type {
    return struct {
        const Self = @This();

        pub const Node = struct {
            next: ?*Node = null,
            data: T,
        };

        first: ?*Node = null,

        pub fn prepend(list: *Self, new_node: *Node) void {
            new_node.next = list.first;
            list.first = new_node;
        }
    };
}

const Point = struct {
    x: f64,
    y: f64,
};

pub fn main() !void {
    const PointList = LinkedList(Point);
    const p1 = Point{ .x = 0, .y = 1 };
    const p2 = Point{ .x = 2, .y = 3 };

    var my_list = PointList{};

    var first_node = PointList.Node{ .data = p2 };
    var prev_node = PointList.Node{ .data = p1 };
    my_list.first = &first_node;
    my_list.prepend(&prev_node);

    var node_iter = my_list.first;
    while (node_iter) |node| {
        std.debug.print("Point <{d},{d}>\n", .{ node.data.x, node.data.y });
        node_iter = node.next;
    }
}

// Things to ponder:
// - Is there a null pointer dereference bug here?
