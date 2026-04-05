{
  lib,
  pkgs,
  ...
}:
{
  boot.kernelPackages = pkgs.linuxPackagesFor (
    pkgs.linux_zen.override {
      argsOverride = rec {
        version = "6.19.10";
        modDirVersion = "${version}-lqx1";
        src = pkgs.fetchurl {
          url = "https://github.com/zen-kernel/zen-kernel/archive/refs/tags/v${modDirVersion}.tar.gz";
          sha256 = "sha256-k8vKKrHbqXqP8tLsj66yxsyBvDn8JGUgNnKkCpH5SII=";
        };
        # 配置自定义内核选项
        structuredExtraConfig = with lib.kernel; {
        # ========== 抢占策略 ==========
          # 启用完全抢占
          PREEMPT = lib.mkForce yes;
          # 显式禁用其他抢占模型
          PREEMPT_RT = lib.mkForce no;         # 完全实时抢占: 会牺牲吞吐量, 桌面环境不需要
          PREEMPT_NONE = lib.mkForce no;       # 无抢占: 服务器风格, 延迟高
          PREEMPT_LAZY = lib.mkForce no;       # 懒惰抢占: 不适合桌面激进优化
          PREEMPT_VOLUNTARY = lib.mkForce no;  # 自愿抢占: 延迟高于完全抢占
          # 核心调度, 为防御侧信道攻击将超线程配对调度, 会增加调度延迟
          SCHED_CORE = lib.mkForce no;
          # 动态抢占
          PREEMPT_DYNAMIC = lib.mkForce no;
          # BPF 调度类扩展
          SCHED_CLASS_EXT = lib.mkForce no;
        # ========== 内核裁剪 ==========
          # GPS
          GNSS = lib.mkForce no;
          # USB4 和 Thunderbolt 支持
          USB4 = lib.mkForce no;
          # 火线
          FIREWIRE = lib.mkForce no;
          # 触摸屏
          INPUT_TOUCHSCREEN = lib.mkForce no;
        };
      };
    }
  );
}
