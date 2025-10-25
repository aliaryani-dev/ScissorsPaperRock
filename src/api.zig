const std = @import("std");
var stdout_buffer:[1024]u8 = undefined;
var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
const stdout = &stdout_writer.interface;
var stdin_buffer:[1024]u8 = undefined;
var stdin_writer = std.fs.File.stdin().reader(&stdin_buffer);
const stdin = &stdin_writer.interface;

pub fn get_sys_choice() u8 {
    const timestamp:u64 = @intCast(std.time.nanoTimestamp() & 0xFFFF_FFFF_FFFF_FFFF);
    var prng = std.Random.DefaultPrng.init(timestamp);
    const random = prng.random();
    const choice = random.intRangeLessThan(u8, 1, 4);
    std.debug.print("sys choice: {d}\n", .{choice});
    return choice;
}

pub fn get_user_choice() u8 {
    try stdout.print("Please choose:\n1.Scissors\n2.Paper\n3.Rock\n", .{});
    try stdout.print("choice => ", .{});
    try stdout.flush();
}
