const std = @import("std");

pub fn get_sys_choice() u8 {
    const timestamp:u64 = @intCast(std.time.nanoTimestamp() & 0xFFFF_FFFF_FFFF_FFFF);
    var prng = std.Random.DefaultPrng.init(timestamp);
    const random = prng.random();
    const choice = random.intRangeLessThan(u8, 1, 4);
    std.debug.print("sys choice: {d}\n", .{choice});
    return choice;
}
