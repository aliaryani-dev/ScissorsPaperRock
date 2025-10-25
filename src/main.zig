const std = @import("std");
var stdout_buffer:[1024]u8 = undefined;
var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
const stdout = &stdout_writer.interface;
const api = @import("api.zig");

pub fn main() !void {
    const sys_choice = api.get_sys_choice();
    const user_choice = try api.get_user_choice();
    try api.compare(sys_choice, user_choice);
}

