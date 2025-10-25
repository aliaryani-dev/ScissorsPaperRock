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

pub fn get_user_choice() !u8 {
    try stdout.print("Please choose:\n1.Scissors\n2.Paper\n3.Rock\n", .{});
    try stdout.print("choice => ", .{});
    try stdout.flush();
    const input = try stdin.takeDelimiterExclusive('\n');
    const choice = try std.fmt.parseInt(u8, input, 10);
    switch (choice) {
        1,2,3 => {return choice;},
         else => {
            try stdout.print("PLESE ENTER A VALID OPTION!\n", .{});
            try stdout.flush();
            return error.inputError;
        }
    }
}

fn eval_choice(choice:u8) []const u8 {
    return switch (choice) {
        1 => "Scissors",
        2 => "Paper",
        3 => "Rock",
        else => "",
    };
}

pub fn compare(sys:u8,user:u8) !void {
    try stdout.print("{s} (Your choice) vs. {s}", .{eval_choice(user), eval_choice(sys)});
    try stdout.flush();

}
