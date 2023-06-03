const Builder = @import("std").build.Builder;
const CrossTarget = @import("std").zig.CrossTarget;
const Feature = @import("std").Target.Cpu.Feature;
const Target = @import("std").Target;

pub fn build(b: *Builder) void {
    const features = Target.aarch64.Feature;
    var cpu_features_disable = Feature.Set.empty;
    cpu_features_disable.addFeature(@enumToInt(features.fp_armv8));
    cpu_features_disable.addFeature(@enumToInt(features.neon));
    const target = CrossTarget{
        .cpu_arch = Target.Cpu.Arch.aarch64,
        .cpu_features_sub = cpu_features_disable,
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
