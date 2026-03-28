{
  lib,
  hostOptions,
  ...
}:
let
  cfg = hostOptions.hardware.boot-loader;
  isGrub = cfg.type == "grub";
  isSystemdBoot = cfg.type == "systemd-boot";
in
{
  boot.loader = {
    # EFI系统分区挂载点
    efi.efiSysMountPoint = cfg.efiSysMountPoint;
    # 允许修改 EFI 变量, 支持 UEFI 引导
    efi.canTouchEfiVariables = true;
  } //
  lib.mkIf isGrub {
  # 启用 grub 引导程序
    grub = {
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
    };
  } //
  lib.mkIf isSystemdBoot {
  # 启用 systemd-boot 引导程序
    systemd-boot.enable = true;
  };
}
