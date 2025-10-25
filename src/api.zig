const std = @import("std");
var prng = std.Random.DefaultPrng.init(blk: {
    var seed:u64 = undefined;
    std.posix.getrandom(std.mem.asBytes(&seed));
    break :blk seed;
});
const rand = prng.random();

pub fn get_sys_choice() u8 {
    return rand.int(u8);
}
