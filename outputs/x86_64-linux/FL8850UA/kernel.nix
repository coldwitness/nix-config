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
          PREEMPT = lib.mkForce lib.kernel.yes;
        # ========== 内核裁剪 ==========
          # 火线
          FIREWIRE = lib.mkForce lib.kernel.no;
          # 触摸屏
          INPUT_TOUCHSCREEN = lib.mkForce lib.kernel.no;
        };
      };
    }
  );
}
