//! A simple pass that uses a visitor. This just changes all numbers to 42. It also errors if the
//! number is already 42

const std = @import("std");

const Allocator = std.mem.Allocator;

const minir = @import("minir");
const Modifier = minir.pass.Modifier;
const Program = minir.Program;
const IrVisitor = minir.IrVisitor;

pub const VisitorPass = Modifier(
    VisitorPassImpl, VisitorPassImpl.Error, &[_]type{},
    VisitorPassImpl.init, VisitorPassImpl.execute
);

const VisitorPassImpl = struct {
    pub const Error = error {
        BadNumber,
    };

    const Self = @This();
    const VisitorTy = IrVisitor(*Self, Error!void);

    allocator: Allocator,

    pub fn init(args: anytype) Self {
        return .{
            .allocator = args.allocator,
        };
    }

    pub fn deinit(self: *Self) void {
        _ = self;
    }

    pub const VisitorPassVisitor = VisitorTy {
        .visitInt = visitInt,
    };

    pub fn execute(self: *Self, program: *Program) Error!void {
        try VisitorPassVisitor.visitProgram(VisitorPassVisitor, self, program);
    }

    pub fn visitInt(visitor: VisitorTy, self: *Self, i: *i32) Error!void {
        _ = visitor;
        _ = self;
        if (i.* == 42) {
            std.log.err("Found bad number!", .{});
            return error.BadNumber;
        } else {
            std.log.info("Changing {d} to {d}\n", .{i.*, 42});
            i.* = 42;
        }
    }
};
