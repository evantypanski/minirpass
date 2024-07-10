const std = @import("std");

const minir = @import("minir");
const Driver = minir.Driver;
const Options = minir.options.Options;
const MySimplePass = @import("simple_pass.zig").MySimplePass;
const VisitorPass = @import("visitor_pass.zig").VisitorPass;

pub fn main() !void {
    var general_purpose_allocator = std.heap.GeneralPurposeAllocator(.{}){};
    const gpa = general_purpose_allocator.allocator();
    const stdout = std.io.getStdOut().writer();

    const args = try std.process.argsAlloc(gpa);
    defer std.process.argsFree(gpa, args);

    if (args.len < 2) {
        std.log.err("Must provide file name", .{});
        std.process.exit(1);
    }

    // Use the format option to see the result
    const cmd = Options {
        .fmt = .{
            .filename = args[1],
        },
    };

    try Driver.init(gpa, stdout).driveWithExtraPasses(cmd, &[_]type{MySimplePass, VisitorPass});
}
