const Builder = @import("std").build.Builder;
const CrossTarget = @import("std").zig.CrossTarget;
const Target = @import("std").Target;

pub fn build(b: *Builder) void {
    const target = CrossTarget{
        .cpu_arch = Target.Cpu.Arch.aarch64,
        .os_tag = Target.Os.Tag.freestanding,
        .abi = Target.Abi.none,
    };
    const kernel = b.addExecutable("zkernel.elf", "kernel/init.zig");
    kernel.addPackagePath("uart", "arch/aarch64/uart.zig");
    kernel.addAssemblyFile("arch/aarch64/start.S");
    kernel.setBuildMode(.ReleaseSmall);
    kernel.setTarget(target);
    kernel.setLinkerScriptPath(.{ .path = "arch/aarch64/kernel.ld" });
    kernel.code_model = .small;
    kernel.install();
}
