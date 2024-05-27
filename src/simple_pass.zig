//! The simplest minIR pass can just provide a couple of functions. This pass is meant to show that
//! a pass doesn't even have to initialize anything!
const std = @import("std");

const Verifier = @import("minir").pass.Verifier;
const Program = @import("minir").Program;

fn init(_: anytype) void {}

fn run(_: *void, _: *const Program) anyerror!void {
    std.debug.print("In simple pass!\n\n", .{});
}

pub const SimplePass = Verifier(
    void,
    anyerror,
    &[_]type{},
    init,
    run,
);
